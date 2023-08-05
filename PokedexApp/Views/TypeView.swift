//
//  TypeView.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 3/8/23.
//

import UIKit

class TypeView: UIView {
    
    // MARK: - Properties
    
    lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .center
        view.distribution = .fillEqually
        return view
    }()
    
    lazy var firstType: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cornerRadius(with: [
            .layerMaxXMaxYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMinXMinYCorner
        ], cornerRadii: 12)
        return view
    }()
    
    lazy var firstTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontFamily.Montserrat.medium.font(size: 10.62)
        return label
    }()
    
    lazy var secondType: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.cornerRadius(with: [
            .layerMaxXMaxYCorner,
            .layerMaxXMinYCorner,
            .layerMinXMaxYCorner,
            .layerMinXMinYCorner
        ], cornerRadii: 12)
        return view
    }()
    
    lazy var secondTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontFamily.Montserrat.medium.font(size: 10.62)
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
        addSubview(mainStackView)
        firstType.addSubview(firstTypeLabel)
        secondType.addSubview(secondTypeLabel)
        
        mainStackView.addArrangedSubview(firstType)
        mainStackView.addArrangedSubview(secondType)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            firstTypeLabel.topAnchor.constraint(equalTo: firstType.topAnchor, constant: 5),
            firstTypeLabel.leadingAnchor.constraint(equalTo: firstType.leadingAnchor, constant: 10),
            firstTypeLabel.bottomAnchor.constraint(equalTo: firstType.bottomAnchor, constant: -5),
            firstTypeLabel.trailingAnchor.constraint(equalTo: firstType.trailingAnchor, constant: -10),
            
            firstTypeLabel.centerXAnchor.constraint(equalTo: firstType.centerXAnchor),
            firstTypeLabel.centerYAnchor.constraint(equalTo: firstType.centerYAnchor),
            
            secondTypeLabel.topAnchor.constraint(equalTo: secondType.topAnchor, constant: 5),
            secondTypeLabel.leadingAnchor.constraint(equalTo: secondType.leadingAnchor, constant: 10),
            secondTypeLabel.bottomAnchor.constraint(equalTo: secondType.bottomAnchor, constant: -5),
            secondTypeLabel.trailingAnchor.constraint(equalTo: secondType.trailingAnchor, constant: -10),
            
            secondTypeLabel.centerXAnchor.constraint(equalTo: secondType.centerXAnchor),
            secondTypeLabel.centerYAnchor.constraint(equalTo: secondType.centerYAnchor),
        ])
    }
    
    func setupFirstTypeColors(with firstTypeColor: UIColor) {
        firstType.layer.borderColor = firstTypeColor.cgColor
        firstType.layer.borderWidth = 1
        firstType.backgroundColor = .white
        firstTypeLabel.textColor = firstTypeColor
    }
    
    func setupSecondTypeColors(with secondTypeColor: UIColor) {
        secondType.layer.borderColor = secondTypeColor.cgColor
        secondType.layer.borderWidth = 1
        secondType.backgroundColor = .white
        secondTypeLabel.textColor = secondTypeColor
    }
    
}

