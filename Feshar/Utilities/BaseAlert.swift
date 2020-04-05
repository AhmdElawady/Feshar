//
//  Alert.swift
//  Feshar
//
//  Created by Awady on 3/25/20.
//  Copyright © 2020 Awady. All rights reserved.
//

import Foundation
import UIKit

class ShowAlert {
    class func basic(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
