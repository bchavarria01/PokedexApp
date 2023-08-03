//
//  NavigationHomeBar.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit

class NavigationHomeBar: UIView {
    
    // MARK: - Properties
    
    lazy var logoImage: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        button.setAttributedTitle(NSAttributedString(
            string: "Pokédex",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]), for: .normal
        )
        button.isUserInteractionEnabled = false
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 24)
        button.tintColor = UIColor(red: 0, green: 0.373, blue: 1, alpha: 1)
        
        let image = UIImage(named: "ic_pokemon_logo")
        button.setImage(image, for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        return button
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
        
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            logoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            
            logoImage.widthAnchor.constraint(equalToConstant: 120),
            logoImage.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
}
