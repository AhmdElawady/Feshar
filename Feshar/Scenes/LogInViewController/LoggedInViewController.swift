//
//  LoggedInViewController.swift
//  Feshar
//
//  Created by Awady on 3/23/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import UIKit

class LoggedInViewController: UIViewController {

    @IBOutlet weak var helloUserLabel: UILabel!
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentHomeVCAfterShortTime()
        setupAttrbutes()
        setupBackButtonNavItem()
    }
    
    func setupAttrbutes() {
        let string_to_color = "\(username)"
        helloUserLabel.text = "Hello, \(username)"
        let range = (helloUserLabel.text! as NSString).range(of: string_to_color)
        let attribute = NSMutableAttributedString.init(string: helloUserLabel.text!)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor( cgColor: #colorLiteral(red: 0.3294117647, green: 0.7921568627, blue: 0.2941176471, alpha: 1) ) , range: range)
        helloUserLabel.attributedText = attribute
    }
    
    func presentHomeVCAfterShortTime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
            nextVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
