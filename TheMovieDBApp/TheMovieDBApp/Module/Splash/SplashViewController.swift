//
//  SplashViewController.swift
//  TheMovieDBApp
//
//  Created by Hilal Akgül on 24.04.2022.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

class SplashViewController: UIViewController {

    var presenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter.viewDidAppear()
    }
    
    func showAlert(title:String, message:String) {
        DispatchQueue.main.async {
            self.exitAppAlert(message: message, title: title)
        }
    }


}


extension SplashViewController: SplashViewControllerProtocol {
    
    func noInternetConnection() {
        showAlert(title: "Error", message: "No Internet Connection, Please check your connection")
    }
}

