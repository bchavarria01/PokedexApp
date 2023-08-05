//
//  InfoView.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit

class InfoView: UIView {
    
    // MARK: - Properties
    
    lazy var mainContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.cornerRadius(
            with: [
                .layerMaxXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner
            ], cornerRadii: 10
        )
        return view
    }()
    
    lazy var weightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_weight")
        return imageView
    }()
    
    lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "90,5 kg"
        label.textColor = UIColor(red: 0.004, green: 0.259, blue: 0.416, alpha: 1)
        label.font = FontFamily.Montserrat.bold.font(size: 14)
        return label
    }()
    
    lazy var weightLabelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Peso"
        label.textColor = UIColor(red: 0.172, green: 0.521, blue: 0.736, alpha: 1)
        label.font = FontFamily.Montserrat.regular.font(size: 10)
        return label
    }()
    
    lazy var rulerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ic_ruler")
        return imageView
    }()
    
    lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1.7 m"
        label.textColor = UIColor(red: 0.004, green: 0.259, blue: 0.416, alpha: 1)
        label.font = FontFamily.Montserrat.bold.font(size: 14)
        return label
    }()
    
    lazy var heightLabelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Altura"
        label.textColor = UIColor(red: 0.172, green: 0.521, blue: 0.736, alpha: 1)
        label.font = FontFamily.Montserrat.regular.font(size: 10)
        return label
    }()
    
    lazy var separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.839, alpha: 1)
        return view
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
        
        addSubview(mainContentView)
        
        mainContentView.addSubview(weightImageView)
        mainContentView.addSubview(weightLabel)
        mainContentView.addSubview(weightLabelTitle)
        
        mainContentView.addSubview(separator)
        
        mainContentView.addSubview(rulerImageView)
        mainContentView.addSubview(heightLabel)
        mainContentView.addSubview(heightLabelTitle)
        
        NSLayoutConstraint.activate([
            mainContentView.topAnchor.constraint(equalTo: topAnchor),
            mainContentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainContentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            weightImageView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 16),
            weightImageView.leadingAnchor.constraint(equalTo: mainContentView.leadingAnchor, constant: 32),
            weightImageView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -16),
            
            weightImageView.widthAnchor.constraint(equalToConstant: 24),
            weightImageView.heightAnchor.constraint(equalToConstant: 24),
            
            weightLabel.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 10),
            weightLabel.leadingAnchor.constraint(equalTo: weightImageView.trailingAnchor, constant: 16),
            weightLabel.heightAnchor.constraint(equalToConstant: 20),
            
            weightLabelTitle.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 1),
            weightLabelTitle.leadingAnchor.constraint(equalTo: weightImageView.trailingAnchor, constant: 16),
            weightLabelTitle.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -10),
            
            separator.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 10),
            separator.leadingAnchor.constraint(equalTo: mainContentView.centerXAnchor),
            separator.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -10),
            separator.widthAnchor.constraint(equalToConstant: 1),
            
            rulerImageView.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 16),
            rulerImageView.leadingAnchor.constraint(equalTo: separator.leadingAnchor, constant: 32),
            rulerImageView.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -16),
            
            rulerImageView.widthAnchor.constraint(equalToConstant: 24),
            rulerImageView.heightAnchor.constraint(equalToConstant: 24),
            
            heightLabel.topAnchor.constraint(equalTo: mainContentView.topAnchor, constant: 10),
            heightLabel.leadingAnchor.constraint(equalTo: rulerImageView.trailingAnchor, constant: 16),
            heightLabel.heightAnchor.constraint(equalToConstant: 20),
            
            heightLabelTitle.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 1),
            heightLabelTitle.leadingAnchor.constraint(equalTo: rulerImageView.trailingAnchor, constant: 16),
            heightLabelTitle.bottomAnchor.constraint(equalTo: mainContentView.bottomAnchor, constant: -10),
        ])
    }
    
}
