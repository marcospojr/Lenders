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
        if((userName?.isEmpty)!         || userName == nil      ||
            (userLastName?.isEmpty)!    || userLastName == nil  ||
            (userCpf?.isEmpty)!         || userCpf == nil       ||
            (userEmail?.isEmpty)!       || userEmail == nil     ||
            (userPassword?.isEmpty)!    || userPassword == nil  ||
            (repeatPassword?.isEmpty)!  || repeatPassword == nil) {
            

            displayAlertMessage(userMessage: "Preencha todos os campos!")
            
            return
        }
        
        // Verifica se as senhas coincidem
        if(userPassword != repeatPassword) {
            
            displayAlertMessage(userMessage: "As senhas não coincidem!")
            
            return
        }
        
        // Indicador de atividade
        let myActivityIndicator = UIActivityIndicatorView()
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
         
        view.addSubview(myActivityIndicator)
        
        // Registrando o usuário
        let myUrl = URL(string: "https://private-c7bb6-lendersapi1.apiary-mock.com/api/users/1")
        var request = URLRequest(url: myUrl!)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        
        let postString = ["userName": userNameTextField.text!,
                          "userLastName": userLastNameTextField.text!,
                          "userCpf": userCpfTextField.text!,
                          "userEmail": userEmailTextField.text!,
                          "userPassword": userPasswordTextField.text!
        ] as [String : String]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: postString, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayAlertMessage(userMessage: "Algo deu errado. Tente novamente!")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            DispatchQueue.main.async {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                
                if error != nil {
                    self.displayAlertMessage(userMessage: "Não foi possível executar esta solicitação. Tente novamente mais tarde.")
                    print("error=\(String(describing: error))")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: /*.allowFragments*/ .mutableContainers) as? NSDictionary
                    
                    if let parseJSON = json {
                        
                        let userId = parseJSON["userId"] as? String
                        
                        if (userId?.isEmpty)! {
                            self.displayAlertMessage(userMessage: "Não foi possível executar esta solicitação. Tente novamente mais tarde.")
                            return
                        } else {
                            self.displayAlertMessage(userMessage: "Registrado com sucesso. Por favor, continue para fazer o login.")
                            return
                        }
                    } else {
                        self.displayAlertMessage(userMessage: "Não foi possível executar esta solicitação. Tente novamente mais tarde.")
                        return
                    }
                } catch {
                    self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                    
                    self.displayAlertMessage(userMessage: "Não foi possível executar esta solicitação. Tente novamente mais tarde.")
                    print(error)
                }
            }
            
        }
        task.resume()
        
        
    }
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
