//
//  HomeViewController.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 1/8/23.
//

import UIKit

final class HomeViewController: BaseViewController {
    
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
    
    lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0.14, blue: 0.23, alpha: 1)
        label.font = UIFont(name: "Montserrat-Medium", size: 20)
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
    
    lazy var searchField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isUserInteractionEnabled = true
        textField.layer.borderColor = UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1).cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 20
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x:0,y:0,width:15,height:0))
        textField.placeholder = "Buscar"
        textField.isEnabled = true

        return textField
    }()
    
    lazy var circleView: UIView = {
        let circleView = UIView()
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.layer.backgroundColor = UIColor(red: 1, green: 0.776, blue: 0, alpha: 1).cgColor
        circleView.layer.cornerRadius = 15
        
        return circleView
    }()
    
    lazy var searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_search")
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        return imageView
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
    
    // MARK: - DataSource
    
    private lazy var collectionDataSource: PokemonDetailViewControllerCollectionDataSource = {
        return PokemonDetailViewControllerCollectionDataSource()
    }()
    
    // MARK: - Delegate
    
    private lazy var collectionDelegate: PokemonDetailViewControllerCollectionDelegate = {
        let delegete = PokemonDetailViewControllerCollectionDelegate()
        delegete.delegate = self.delegate
        return delegete
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupCollectionView()
    }
    
    // MARK: - Helpers
    
    private func setupCollectionView() {
        let items = [PokemonResponse(name: "", url: ""), PokemonResponse(name: "", url: ""), PokemonResponse(name: "", url: ""), PokemonResponse(name: "", url: ""), PokemonResponse(name: "", url: ""), PokemonResponse(name: "", url: ""), PokemonResponse(name: "", url: ""), PokemonResponse(name: "", url: ""), PokemonResponse(name: "", url: ""), PokemonResponse(name: "", url: ""), PokemonResponse(name: "", url: ""), PokemonResponse(name: "", url: "")]
        
        collectionDelegate.items = items
        collectionDataSource.items = items
        
        pokemonsCollectionView.register(cellType: PokemonsCollectionViewCell.self)
        pokemonsCollectionView.dataSource = collectionDataSource
        pokemonsCollectionView.delegate = collectionDelegate
        pokemonsCollectionView.reloadData()
    }
    
    private func setupLayout() {
        let logoView = navigationView.logoImage
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoView)
        view.addSubview(contentView)
        circleView.addSubview(searchIcon)
    
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(searchField)
        contentView.addSubview(circleView)
        contentView.addSubview(pokemonsCollectionView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            welcomeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            searchField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 12),
            searchField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            searchField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            searchIcon.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            searchIcon.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            
            circleView.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            circleView.trailingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: -5),
            circleView.bottomAnchor.constraint(equalTo: searchField.bottomAnchor, constant: -5),
            circleView.widthAnchor.constraint(equalToConstant: 30),
            circleView.heightAnchor.constraint(equalToConstant: 30),
            
            pokemonsCollectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 20),
            pokemonsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            pokemonsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -90),
            pokemonsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
        ])
        
    }
    
    @objc func singIn() {
        
    }
    
}

