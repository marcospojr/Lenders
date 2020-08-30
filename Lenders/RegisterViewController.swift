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
    @IBOutlet weak var userCpfTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
        let userName = userNameTextField.text;
        let userCpf = userCpfTextField.text;
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text
        let repeatPassword = repeatPasswordTextField.text;
        
        // Verifica se os campos estao vazios
        if(((userName?.isEmpty) == true)        || userName == nil  ||
            ((userCpf?.isEmpty) == true)        || userCpf == nil   ||
            ((userEmail?.isEmpty) == true)      || userEmail == nil ||
            ((userPassword?.isEmpty) == true)   || userPassword == nil ||
            ((repeatPassword?.isEmpty) == true) || repeatPassword == nil) {
            

            displayAlertMessage(userMessage: "Preencha todos os campos!");
            
            return;
        }
        
        // Verifica se as senhas coincidem
        if(userPassword != repeatPassword) {
            
            displayAlertMessage(userMessage: "As senhas não coincidem!");
            
            return;
        }
        
        // Armazena os dados
        
        // Mensagem de confirmacao
        
        
    }
    
    func displayAlertMessage(userMessage:String) {
        var myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
