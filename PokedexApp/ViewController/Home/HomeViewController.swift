//
//  HomeViewController.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 1/8/23.
//

import UIKit

final class HomeViewController: BaseViewController {
    
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
    
    lazy var logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_pokemon_logo")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0, green: 0.373, blue: 1, alpha: 1)
        label.font = UIFont(name: "Montserrat-Bold", size: 24)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        label.attributedText = NSMutableAttributedString(
            string: "Pokédex",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )

        return label
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
    
    // MARK: - Attributes
    
    var handle: NSObjectProtocol?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        setupActions()
//        hideKeyboardGesture()
//        setupKeyboardHandling()
    }
    
    // MARK: - Helpers
    
    private func setupKeyboardHandling() {
//        subscribeForKeyboardChange(
//            self,
//            selector: #selector(keyboardWillChange(_:))
//        )
    }
    
    @objc private func keyboardWillChange(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else if notification.name == UIResponder.keyboardWillShowNotification {
            scrollView.contentInset.bottom = frame.height
        }
    }
    
    private func setupActions() {
        
    }
    
    private func setupLayout() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        circleView.addSubview(searchIcon)
        
        contentView.addSubview(logoImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(searchField)
        contentView.addSubview(circleView)
        
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
            
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            logoImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            logoImage.widthAnchor.constraint(equalToConstant: 46),
            logoImage.heightAnchor.constraint(equalToConstant: 46),
            
            titleLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
            
            welcomeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            welcomeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            searchField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 12),
            searchField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            searchField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            searchField.heightAnchor.constraint(equalToConstant: 36),
            searchField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32),
            
            searchIcon.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            searchIcon.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            
            circleView.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            circleView.topAnchor.constraint(equalTo: searchField.topAnchor, constant: 5),
            circleView.trailingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: -5),
            circleView.bottomAnchor.constraint(equalTo: searchField.bottomAnchor, constant: -5),
            circleView.widthAnchor.constraint(equalToConstant: 30),
            circleView.heightAnchor.constraint(equalToConstant: 30),
            
        ])
        
    }
    
    @objc func singIn() {
        
    }
    
}

