//
//  DetailViewController.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit
import Nuke
import RxSwift

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
    
    lazy var navBar: NavigationDetailBar = {
        let navBar = NavigationDetailBar()
        navBar.backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleBackAction)))
        return navBar
    }()
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
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
    
    lazy var typeView: TypeView = {
        let view = TypeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var infoView: InfoView = {
        let view = InfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontFamily.Montserrat.medium.font(size: 12)
        label.textColor = UIColor(red: 0.488, green: 0.488, blue: 0.488, alpha: 1)
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()
    
    lazy var statisticsView: StatisticsView = {
        let view = StatisticsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Attributes
    
    var selectedPokemon: PokemonResponse?
    
        var viewModel: DetailViewModel!
        let disposeBag = DisposeBag()
    
    weak var delegate: DetailViewControllerDelegate?
    
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
        setupNavigationBar()
    }
    
    // MARK: - Methods
    
    private func setupNavigationBar() {
        navigationItem.title = ""
        navBar.backButton.setTitle(selectedPokemon?.name?.capitalizingFirstLetter() ?? "", for: .normal)
        navBar.numberLabel.text = "#\(selectedPokemon?.url?.getPokemonNumber() ?? "")"
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.004, green: 0.259, blue: 0.416, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navBar.backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navBar.numberLabel)
    }
    
    private func bindViewModel() {
        let url = URL(string: selectedPokemon?.url ?? "")!
        showLoading("\(L10n.loadingTitle)")
        viewModel.getPokemonDetail(detailUrl: url)
            .subscribe(
                onSuccess: { [weak self] data in
                    guard let self = self else { return }
                    let speciesUrl = URL(string: data.species?.url ?? "")!
                    viewModel.getPokemonAdditionalInfo(speciesUrL: speciesUrl)
                        .subscribe(
                            onSuccess: { [weak self] speciesResult in
                                guard let self = self else { return }
                                DispatchQueue.main.async {
                                    let imageUrl = URL(string: self.selectedPokemon?.url?.getImageUrl() ?? "")!
                                    Nuke.loadImage(with: imageUrl, options: K.Nuke.options, into: self.mainImageView)
                                    self.infoView.weightLabel.text = "\((Float(data.weight ?? 0) / 10)) Kg"
                                    self.infoView.heightLabel.text = "\((Float(data.height ?? 0) / 10)) m"
                                    self.colorView.backgroundColor = speciesResult.color?.name?.getColorByPokemonColor()
                                    self.infoLabel.text = speciesResult.flavorTextEntries?.first(where: { textEntry in
                                        textEntry.language?.name == "es" && textEntry.version?.name == "omega-ruby"
                                    })?.flavorText?.replacingOccurrences(of: "\n", with: " ")
                                    
                                    self.typeView.secondType.isHidden = data.types?.count ?? 0 < 2
                                    
                                    self.typeView.firstTypeLabel.text = data.types?.first?.type?.name?.getPokemonType()
                                    self.typeView.secondTypeLabel.text = data.types?.last?.type?.name?.getPokemonType()
                                    
                                    self.typeView.setupFirstTypeColors(with: speciesResult.color?.name?.getSecondColorByPokemonColor() ?? .black)
                                    self.typeView.setupSecondTypeColors(with: "black".getSecondColorByPokemonColor() )
                                    
                                    var i = 0
                                    self.statisticsView.subviews.forEach { view in
                                        if let stack = (view as? UIStackView) {
                                            stack.subviews.forEach { stackSubView in
                                                if let progressView = (stackSubView as? ProgressBarView) {
                                                    let progressValue = data.stats?.first(where: { stat in
                                                        switch i {
                                                        case 0:
                                                            return stat.stat?.name == "hp"
                                                        case 1:
                                                            return stat.stat?.name == "attack"
                                                        case 2:
                                                            return stat.stat?.name == "defense"
                                                        case 3:
                                                            return stat.stat?.name == "special-attack"
                                                        case 4:
                                                            return stat.stat?.name == "special-defense"
                                                        default:
                                                            return stat.stat?.name == "speed"
                                                        }
                                                    })?.baseStat ?? 1
                                                    
                                                    let hpProgress: Float = (Float(progressValue) / 100)
                                                    
                                                    progressView.progressBar.setProgress(hpProgress, animated: true)
                                                    progressView.valueLabel.text = String(format: "%.2f", hpProgress).replacingOccurrences(of: ".", with: "")
                                                    
                                                    progressView.progressBar.trackTintColor = speciesResult.color?.name?.getColorByPokemonColor()
                                                    progressView.progressBar.tintColor = speciesResult.color?.name?.getSecondColorByPokemonColor()
                                                    i += 1
                                                }
                                            }
                                        }
                                        
                                    }
                                    
                                    self.dismiss(animated: true) {
                                        self.dismiss(animated: true)
                                    }
                                }
                            }, onFailure: { [weak self] error in
                                guard let self = self else { return }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                                    self.dismiss(animated: true, completion: {
                                        self.showActionMessage(title: L10n.error, message: error.localizedDescription)
                                    })
                                })
                            }
                        ).disposed(by: disposeBag)
                }, onFailure: { [weak self] error in
                    guard let self = self else { return }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self.dismiss(animated: true, completion: {
                            self.showActionMessage(title: L10n.error, message: error.localizedDescription)
                        })
                    })
            }).disposed(by: disposeBag)
    }
    
    @objc func handleBackAction() {
        delegate?.detailViewControllerDelegateDidTapBack()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(colorView)
        contentView.addSubview(mainImageView)
        contentView.addSubview(typeView)
        contentView.addSubview(infoView)
        contentView.addSubview(infoLabel)
        contentView.addSubview(statisticsView)
        
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
            mainImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            mainImageView.heightAnchor.constraint(equalToConstant: 230),
            mainImageView.widthAnchor.constraint(equalToConstant: 265),
            
            colorView.topAnchor.constraint(equalTo: mainImageView.centerYAnchor, constant: -12),
            colorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            colorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            colorView.heightAnchor.constraint(equalToConstant: 168),
            
            typeView.bottomAnchor.constraint(equalTo: colorView.bottomAnchor, constant: -10),
            typeView.centerXAnchor.constraint(equalTo: colorView.centerXAnchor),
            
            infoView.topAnchor.constraint(equalTo: colorView.bottomAnchor, constant: 10),
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            infoLabel.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 32),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            statisticsView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 32),
            statisticsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            statisticsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -48),
            statisticsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
        ])
        
        let contentViewHeigthConstraint = contentView.heightAnchor.constraint(
            equalTo: view.heightAnchor
        )
        contentViewHeigthConstraint.priority = .defaultLow
        contentViewHeigthConstraint.isActive = true
    }
}
