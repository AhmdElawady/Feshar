//
//  ViewController.swift
//  Feshar
//
//  Created by Awady on 3/23/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLoginVC()
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9745692015, green: 0.9745692015, blue: 0.9745692015, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        loginValidation()
        Token.getToken(completion: handleRequestTokenResponse(success:error:))
    }
    
    func handleRequestTokenResponse(success: Bool, error: Error?) {
        if success {
            DispatchQueue.main.async {
                LoginUser.login(username: self.usernameTextField.text ?? "", password: self.passwordTextField.text ?? "", completion: self.handleLoginResponse(success:error:))
            }
        }
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        if success {
            SessionId.getSessionId(completion: handleSessionResponse(success:error:))
        }
    }
    
    func handleSessionResponse(success: Bool, error: Error?) {
        if success {
            DispatchQueue.main.async {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                guard let welcomeScreen = mainStoryboard.instantiateViewController(withIdentifier: "LoggedInViewController") as? LoggedInViewController else { return }
                welcomeScreen.username = self.usernameTextField.text!.capitalized
                welcomeScreen.modalTransitionStyle = .partialCurl
                self.navigationController?.pushViewController(welcomeScreen, animated: true)
            }}
    }
    
    func loginValidation()  {
        guard let username = usernameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        if username.isEmpty || password.isEmpty {
            ShowAlert.basic(title: "Incomplete Form", message: "Please fillout all fields", vc: self)
            return }
        if password.count < 8 {
            ShowAlert.basic(title: "Short Password", message: "Password should be at least 8 character", vc: self)
            passwordTextField.text = ""
            return }
    }
    
    func setUpLoginVC() {
        logInButton.setupButtonView()
//:- Setup Textfield Placeholder Attributes
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [ .font: UIFont(name: "Helvetica", size: 14)!, .foregroundColor: #colorLiteral(red: 0.3725490196, green: 0.3647058824, blue: 0.4392156863, alpha: 1)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [ .font: UIFont(name: "Helvetica", size: 14)!, .foregroundColor: #colorLiteral(red: 0.3725490196, green: 0.3647058824, blue: 0.4392156863, alpha: 1)])
    }
}

