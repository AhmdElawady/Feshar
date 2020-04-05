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
    
    private let staticUsername = "Robusta"
    private let staticPassword = "Robusta.123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLoginVC()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        loginValidation()
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let welcomeScreen = mainStoryboard.instantiateViewController(withIdentifier: "LoggedInViewController") as? LoggedInViewController {
                welcomeScreen.username = staticUsername
                welcomeScreen.modalTransitionStyle = .partialCurl
                self.navigationController?.pushViewController(welcomeScreen, animated: true)
            }
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
        if username != staticUsername || password != staticPassword {
            ShowAlert.basic(title: "Unable To Login", message: "Incorrect Username or Password", vc: self)
            usernameTextField.text = ""
            passwordTextField.text = ""
            return }
    }
    
    func setUpLoginVC() {
        logInButton.setupButtonView()
//         Setup Textfield Placeholder Attributes
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [ .font: UIFont(name: "Helvetica", size: 14)!, .foregroundColor: #colorLiteral(red: 0.3725490196, green: 0.3647058824, blue: 0.4392156863, alpha: 1)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [ .font: UIFont(name: "Helvetica", size: 14)!, .foregroundColor: #colorLiteral(red: 0.3725490196, green: 0.3647058824, blue: 0.4392156863, alpha: 1)])
    }
}

