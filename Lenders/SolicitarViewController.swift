//
//  SolicitarViewController.swift
//  Lenders
//
//  Created by Marcos Junior on 01/09/20.
//  Copyright © 2020 Marcos Junior. All rights reserved.
//

import UIKit

class SolicitarViewController: UIViewController {
    
    
    @IBOutlet weak var valorEmpTextField: UITextField!
    @IBOutlet weak var confirmarEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func voltarButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func confirmarButtonTapped(_ sender: Any) {
        if valorEmpTextField.text!.isEmpty || confirmarEmailTextField.text!.isEmpty {
            displayAlertMessage(userMessage: "Preencha todos os campos.")
            return
        }
        else {
            displayAlertMessage(userMessage: "Seu impréstimo foi solicitado com sucesso! Você pode acompanhar na aba de Acompanhar Propostas.")
            return
        }
    }
    
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
}
