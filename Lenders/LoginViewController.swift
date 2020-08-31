//
//  ViewController.swift
//  Lenders
//
//  Created by Marcos Junior on 27/08/20.
//  Copyright © 2020 Marcos Junior. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userEmail = userEmailTextField
        let userPassword = userPasswordTextField
        
        let userEmailStored = UserDefaults.standard.string(forKey: "userEmail")
        let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword")
        
        if(userEmail?.isEqual(userEmailStored) == true) {
            if(userPassword?.isEqual(userPasswordStored) == true) {
//                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
//                UserDefaults.standard.synchronize()
//                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}

