//
//  HomeViewController.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 1/8/23.
//

import UIKit
import RxSwift
import RxCocoa
import Nuke

final class HomeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Components
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var navigationView: NavigationHomeBar = {
        let view = NavigationHomeBar()
        return view
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0.14, blue: 0.23, alpha: 1)
        label.font = FontFamily.Montserrat.medium.font(size: 20)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.31
        
        let mainString = "¡Hola, bienvenido!"
        let stringToColor = "bienvenido!"
        
        let range = (mainString as NSString).range(of: stringToColor)

        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        mutableAttributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 20), range: range)
        
        label.attributedText = mutableAttributedString
        return label
    }()
    
    lazy var searchField: SearchField = {
        let view = SearchField()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pokemonsCollectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionLayout
        )
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    
    // MARK: - Attributes
    
    weak var delegate: HomeViewControllerDelegate?
    var viewModel: HomeViewModel!
    var disposeBag = DisposeBag()
    var items: [PokemonResponse] = []
    var nextUrlValue: String?
    
    // MARK: - DataSource
    
    private lazy var collectionDataSource: PokemonDetailViewControllerCollectionDataSource = {
        return PokemonDetailViewControllerCollectionDataSource()
    }()
    
    // MARK: - Delegate
    
    private lazy var collectionDelegate: PokemonDetailViewControllerCollectionDelegate = {
        let delegete = PokemonDetailViewControllerCollectionDelegate()
        return delegete
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupActions()
        bindViewModel()
        setupCollectionView()
    }
    
    // MARK: - Helpers
    
    private func setupActions() {
        headerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleKeyboardDismiss)))
    }
    
    @objc func handleKeyboardDismiss() {
        self.view.endEditing(true)
    }
    
    private func bindViewModel() {
        showLoading("\(L10n.loadingTitle)")
        viewModel.getPokemons(limit: "151")
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    self.dismiss(animated: true) {
                        let result: [PokemonResponse]? = data.results
                        self.viewModel.items.accept(result)
                        self.bindCollectionView()
                        self.nextUrlValue = data.next
                    }
                }, onFailure: { [weak self] error in
                    guard let self = self else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.dismiss(animated: true, completion: {
                            self.showActionMessage(title: L10n.error, message: error.localizedDescription)
                        })
                    })
            }).disposed(by: disposeBag)
    }
    
    private func bindCollectionView() {
        let _ = searchField.searchField.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .map { query in
                self.viewModel.items.value?.filter({ pokemonResponse in
                    query.isEmpty ||
                    (pokemonResponse.name?.lowercased().contains(query.lowercased())) ?? true ||
                    (pokemonResponse.url?.getPokemonNumber().lowercased().contains(query.lowercased())) ?? true
                }) ?? []
            }
            .bind(to: pokemonsCollectionView
                .rx
                .items(cellIdentifier: "PokemonsCollectionViewCell", cellType: PokemonsCollectionViewCell.self)) { (_, tableViewItem, cell) in
                    cell.cornerRadius(with: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], cornerRadii: 10)
                    let item = tableViewItem
                    let urlReplaced = item.url?.getImageUrl()
                    let url = URL(string: urlReplaced!)
                    cell.pokemonName.text = item.name?.capitalizingFirstLetter() ?? ""
                    Nuke.loadImage(with: url, options: K.Nuke.options, into: cell.pokemonImage)
                    cell.pokemonNumber.text = "#\(item.url?.getPokemonNumber() ?? "")"
                }
                .disposed(by: disposeBag)
        
        pokemonsCollectionView.rx
            .modelSelected(PokemonResponse.self)
            .subscribe(onNext: { pokemonObject in
                self.delegate?.homeViewControllerDidSelectOnePokemon(with: pokemonObject)
            }).disposed(by: disposeBag)
        
        pokemonsCollectionView.rx.setDelegate(collectionDelegate).disposed(by: disposeBag)
    }
    
    private func setupCollectionView() {
        pokemonsCollectionView.register(cellType: PokemonsCollectionViewCell.self)
    }
    
    private func setupLayout() {
        let logoView = navigationView.logoImage
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoView)
        view.addSubview(contentView)
        
        headerView.addSubview(welcomeLabel)
        headerView.addSubview(searchField)

        contentView.addSubview(headerView)
        contentView.addSubview(pokemonsCollectionView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 30),
            welcomeLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 24),
            
            searchField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 12),
            searchField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 24),
            searchField.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -24),
            searchField.heightAnchor.constraint(equalToConstant: 36),
            searchField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            
            pokemonsCollectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            pokemonsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            pokemonsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -90),
            pokemonsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
        ])
        
    }
}
