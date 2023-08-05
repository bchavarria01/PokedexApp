//
//  SearchField.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 1/8/23.
//

import UIKit

class SearchField: UIView {
    
    // MARK: - Components
    
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
        textField.font = FontFamily.Montserrat.regular.font(size: 12)

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
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: Methods
    
    private func setupView() {
        circleView.addSubview(searchIcon)
        
        addSubview(searchField)
        addSubview(circleView)
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: topAnchor),
            searchField.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchField.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            searchIcon.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            searchIcon.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            
            circleView.centerYAnchor.constraint(equalTo: searchField.centerYAnchor),
            circleView.trailingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: -5),
            circleView.bottomAnchor.constraint(equalTo: searchField.bottomAnchor, constant: -5),
            circleView.widthAnchor.constraint(equalToConstant: 30),
            circleView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
