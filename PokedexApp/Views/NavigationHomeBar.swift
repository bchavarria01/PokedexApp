//
//  NavigationHomeBar.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit

class NavigationHomeBar: UIView {
    
    // MARK: - Properties
    
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
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    private func setUpView() {
        self.addSubview(logoImage)
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            logoImage.widthAnchor.constraint(equalToConstant: 46),
            logoImage.heightAnchor.constraint(equalToConstant: 46),
            
            titleLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor),
        ])
    }
    
}
