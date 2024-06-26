//
//  ViewController.swift
//  XenditExample
//
//  Created by Maxim Bolotov on 3/28/17.
//  Copyright © 2017 Xendit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

}

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}

