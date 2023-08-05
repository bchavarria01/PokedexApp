//
//  BaseViewController.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 1/8/23.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.973, green: 0.973, blue: 0.973, alpha: 1)
    }
    
    // MARK: - Methods
    
    public func showActionMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (actions: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    public func showLoading(_ message: String) {
        let alert = UIAlertController(title: "Loading", message: message, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 60, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();
        
        var imageView = UIImageView(frame: CGRectMake(220, 10, 40, 40))
        imageView.image = R.Base.icPokeball.image
        
        alert.view.addSubview(loadingIndicator)
        alert.view.addSubview(imageView)
        present(alert, animated: true, completion: nil)
    }
    
}
