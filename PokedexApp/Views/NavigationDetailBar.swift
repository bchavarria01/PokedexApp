//
//  NavigationDetailBar.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit

class NavigationDetailBar: UIView {
    
    // MARK: - Attributes
    
    // MARK: - Properties
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 16)
        button.setTitleColor(UIColor(red: 0.004, green: 0.259, blue: 0.416, alpha: 1), for: .normal)
        button.setImage(UIImage(named: "ic_back_arrow"), for: .normal)
        return button
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.488, green: 0.488, blue: 0.488, alpha: 1)
        label.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.3
        label.attributedText = NSMutableAttributedString(
            string: "",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )

        return label
    }()
    
    // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
