//
//  LoginViewController.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginViaWebsiteButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        TMDBClient.getRequestToken(completionHandler: self.handleRequestTokenResponse(bool:error:))
    }
    
    func handleRequestTokenResponse(bool: Bool, error: Error?) {
        if bool {
            DispatchQueue.main.async {
                TMDBClient.login(username: self.emailTextField.text ?? "", password: self.passwordTextField.text ?? "", completionHandler: self.handleLoginResponse(bool:error:))
            }
        }
    }
    
    func handleLoginResponse(bool: Bool, error: Error?) {
        if bool {
            DispatchQueue.main.async {
                TMDBClient.createSessionId(completionHandler: self.handleCreateSessoinIdresponse(bool:error:))
            }
        }
    }
    
    func handleCreateSessoinIdresponse(bool: Bool, error: Error?) {
        if bool {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "completeLogin", sender: nil)
            }
        }
    }
    
    @IBAction func loginViaWebsiteTapped() {
        TMDBClient.getRequestToken { bool, error in
            if bool {
                DispatchQueue.main.async {
                    UIApplication.shared.open(TMDBClient.Endpoints.webAuth.url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
}
