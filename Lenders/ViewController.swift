//
//  ViewController.swift
//  Lenders
//
//  Created by Marcos Junior on 29/08/20.
//  Copyright © 2020 Marcos Junior. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        if(!isUserLoggedIn){
            self.performSegue( withIdentifier: "loginView", sender: self)
        }
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        self.performSegue( withIdentifier: "loginView", sender: self)
    }
}
