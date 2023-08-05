//
//  StatisticsView.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit

class StatisticsView: UIView {
    
    // MARK: - Properties
    
    lazy var statisticsTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 0.004, green: 0.259, blue: 0.416, alpha: 1)
        label.font = FontFamily.Montserrat.bold.font(size: 20)
        label.text = "Estadísticas"
        return label
    }()
    
    lazy var statisticsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 18
        view.alignment = .fill
        view.distribution = .fillEqually
        return view
    }()
    
    lazy var hpProgressView: ProgressBarView = {
        let view = ProgressBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = "HP"
        return view
    }()
    
    lazy var attackProgressView: ProgressBarView = {
        let view = ProgressBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = "Ataque"
        return view
    }()
    
    lazy var defenseProgressView: ProgressBarView = {
        let view = ProgressBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = "Defensa"
        return view
    }()
    
    lazy var specialAttackProgressView: ProgressBarView = {
        let view = ProgressBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = "Ataque especial"
        return view
    }()
    
    lazy var specialDefenseProgressView: ProgressBarView = {
        let view = ProgressBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = "Densa especial"
        return view
    }()
    
    lazy var speedProgressView: ProgressBarView = {
        let view = ProgressBarView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.nameLabel.text = "Velocidad"
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
        addSubview(statisticsTitleLabel)
        addSubview(statisticsStackView)
        
        statisticsStackView.addArrangedSubview(hpProgressView)
        statisticsStackView.addArrangedSubview(attackProgressView)
        statisticsStackView.addArrangedSubview(defenseProgressView)
        statisticsStackView.addArrangedSubview(specialAttackProgressView)
        statisticsStackView.addArrangedSubview(specialDefenseProgressView)
        statisticsStackView.addArrangedSubview(speedProgressView)
        
        NSLayoutConstraint.activate([
            statisticsTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            statisticsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            statisticsStackView.topAnchor.constraint(equalTo: statisticsTitleLabel.bottomAnchor, constant: 10),
            statisticsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            statisticsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            statisticsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
}
