//
//  ProgressBarView.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit

class ProgressBarView: UIView {
    
    // MARK: - Properties
    
    lazy var progressStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fill
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "HP"
        return label
    }()
    
    lazy var progressBar: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setProgress(0.5, animated: true)
        view.trackTintColor = UIColor(named: "testYellow2")
        view.tintColor = UIColor(named: "testYellow")
        view.cornerRadius(
            with: [
                .layerMaxXMaxYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMinXMinYCorner
            ], cornerRadii: 12
        )
        view.clipsToBounds = true
        return view
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "050"
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
        
        progressStackView.addArrangedSubview(nameLabel)
        progressStackView.addArrangedSubview(progressBar)
        progressStackView.addArrangedSubview(valueLabel)
        
        addSubview(progressStackView)
        
        NSLayoutConstraint.activate([
            progressStackView.topAnchor.constraint(equalTo: topAnchor),
            progressStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            progressStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            progressStackView.heightAnchor.constraint(equalToConstant: 20),
            
            progressBar.heightAnchor.constraint(equalToConstant: 14),
            
            nameLabel.widthAnchor.constraint(equalToConstant: 121)
        ])
    }
    
}

