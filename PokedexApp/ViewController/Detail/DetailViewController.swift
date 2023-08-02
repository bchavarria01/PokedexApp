//
//  DetailViewController.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit

final class DetailViewController: BaseViewController {
    // MARK: - Components
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "charizard")
        return imageView
    }()
    
    lazy var colorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.cornerRadius(
            with: [
                .layerMaxXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner
            ],
            cornerRadii: 15)
        return view
    }()
    
    lazy var infoStackView: UIStackView = {
        let view = UIStackView()
        view.spacing = 0
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Attributes
    
    //    var viewModel: PokemonDetailViewModel!
    //    var pokemonDetailUrl: String?
    //    var pokemonImageUrl: String?
    //    let disposeBag = DisposeBag()
    
    // MARK: - DataSource
    
    private lazy var collectionDataSource: PokemonDetailViewControllerCollectionDataSource = {
        return PokemonDetailViewControllerCollectionDataSource()
    }()
    
    private lazy var collectionDelegate: PokemonDetailViewControllerCollectionDelegate = {
        return PokemonDetailViewControllerCollectionDelegate()
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bindViewModel()
        navigationItem.title = "Charizard"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.backward.fill"), style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Helpers
    
    private func bindViewModel() {
        //        showLoading(L10n.getPokemonDetail)
        //        viewModel.getPokemonDetail(with: pokemonDetailUrl ?? "")
        //            .subscribe(
        //                onSuccess: { [weak self] data in
        //                    guard let self = self else { return }
        //                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
        //                        self.dismiss(animated: true, completion: {
        //                            self.setupInforamation(with: data)
        //                        })
        //                    })
        //                }, onError: { [weak self] error in
        //                    guard let self = self else { return }
        //                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
        //                        self.dismiss(animated: true, completion: {
        //                            self.showActionMessage(title: L10n.error, message: error.localizedDescription)
        //                            print(error.localizedDescription)
        //                        })
        //                    })
        //            }).disposed(by: disposeBag)
    }
    
    private func setupInforamation(with data: PokemonDetailResponseModel) {
        var eggGroups: String = ""
        data.eggGroups?.forEach { eggGroup in
            eggGroups += " \(eggGroup.name ?? ""),"
        }
        //        let pokemonBaseDetailModel = PokemonBaseDetailModel(
        //            pokemonImageUrl: self.pokemonImageUrl ?? "",
        //            pokemonName: data.name ?? "",
        //            baseHappiness: String(data.baseHappiness ?? 0),
        //            captureRate: String(data.captureRate ?? 0),
        //            generation: String(data.generation?.name ?? ""),
        //            eggGroups: String(eggGroups.dropLast().dropFirst()),
        //            growthRate: data.growthRate?.name ?? "",
        //            habitat: data.habitat?.name ?? "",
        //            shape:  data.shape?.name ?? ""
        //        )
        //        self.headerView.layer.borderWidth = 1
        //        self.headerView.setupHeaderContent(with: pokemonBaseDetailModel)
        //        self.headerView.backgroundColor = data.color?.name?.getColorByPokemonColor()
        //        self.headerView.layer.borderColor = UIColor(named: (data.color?.name?.capitalizingFirstLetter())!)?.cgColor
        //        self.habitatCollectionView.backgroundColor = data.color?.name?.getColorByPokemonColor()
        //        self.habitatCollectionView.layer.borderWidth = 1
        //        self.habitatCollectionView.layer.borderColor = UIColor(named: (data.color?.name?.capitalizingFirstLetter())!)?.cgColor
        //        self.habitatLabel.text = "Pokemons from habitat: "
        
        self.bindCollectionInformation(using: data.habitat?.url ?? "")
    }
    
    private func bindCollectionInformation(using habitatUrl: String) {
        //        if habitatUrl != "" {
        //            showLoading(L10n.getHabitatInformation)
        //            viewModel.getHabitatInformation(with: habitatUrl)
        //                .subscribe(
        //                    onSuccess: { [weak self] data in
        //                        guard let self = self else { return }
        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
        //                            self.dismiss(animated: true, completion: {
        //                                self.collectionDelegate.items = data.pokemonSpecies!
        //                                self.collectionDataSource.items = data.pokemonSpecies!
        //                                self.habitatCollectionView.reloadData()
        //                            })
        //                        })
        //                    }, onError: { [weak self] error in
        //                        guard let self = self else { return }
        //                        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
        //                            self.dismiss(animated: true, completion: {
        //                                self.showActionMessage(title: L10n.error, message: error.localizedDescription)
        //                                print(error.localizedDescription)
        //                            })
        //                        })
        //                }).disposed(by: disposeBag)
        //        }
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(colorView)
        contentView.addSubview(mainImageView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1),
            
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainImageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 62),
            mainImageView.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -62),
            
            mainImageView.heightAnchor.constraint(equalToConstant: 230),
            mainImageView.widthAnchor.constraint(equalToConstant: 265),
            
            colorView.topAnchor.constraint(equalTo: mainImageView.centerYAnchor, constant: -12),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            colorView.heightAnchor.constraint(equalToConstant: 158),
        ])
        
        let contentViewHeigthConstraint = contentView.heightAnchor.constraint(
            equalTo: view.heightAnchor
        )
        contentViewHeigthConstraint.priority = .defaultLow
        contentViewHeigthConstraint.isActive = true
    }
}
