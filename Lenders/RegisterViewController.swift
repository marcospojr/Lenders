//
//  RegisterViewController.swift
//  Lenders
//
//  Created by Marcos Junior on 29/08/20.
//  Copyright © 2020 Marcos Junior. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userCpfTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let userName = userNameTextField.text
        let userLastName = userLastNameTextField.text
        let userCpf = userCpfTextField.text
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        let repeatPassword = repeatPasswordTextField.text
        
        // Verifica se os campos estao vazios
        if(((userName?.isEmpty) == true)        || userName == nil      ||
            ((userLastName?.isEmpty) == true)   || userLastName == nil  ||
            ((userCpf?.isEmpty) == true)        || userCpf == nil       ||
            ((userEmail?.isEmpty) == true)      || userEmail == nil     ||
            ((userPassword?.isEmpty) == true)   || userPassword == nil  ||
            ((repeatPassword?.isEmpty) == true) || repeatPassword == nil) {
            

            displayAlertMessage(userMessage: "Preencha todos os campos!")
            
            return
        }
        
        // Verifica se as senhas coincidem
        if(userPassword != repeatPassword) {
            
            displayAlertMessage(userMessage: "As senhas não coincidem!")
            
            return
        }
        
        // Armazena os dados
        UserDefaults.standard.object(forKey: userName!)
        UserDefaults.standard.object(forKey: userLastName!)
        UserDefaults.standard.object(forKey: userCpf!)
        UserDefaults.standard.object(forKey: userEmail!)
        UserDefaults.standard.object(forKey: userPassword!)
        
        UserDefaults.standard.synchronize()
        
        // Mensagem de confirmacao
        let confirmAlert = UIAlertController(title: "Alert", message: "Registrado com sucesso!", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default){
            action in self.dismiss(animated: true, completion: nil)
        }
        
        confirmAlert.addAction(okAction)
        self.present(confirmAlert, animated: true, completion: nil)
        
    }
    
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
