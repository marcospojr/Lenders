import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let userEmail = userEmailTextField.text
        let userPassword = userPasswordTextField.text
        
        if (userEmail?.isEmpty)! || (userPassword?.isEmpty)! {
            displayAlertMessage(userMessage: "Email ou senha estão vazios.")
            return
        }
        
        // Indicador de atividade
        let myActivityIndicator = UIActivityIndicatorView()
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
         
        view.addSubview(myActivityIndicator)
        
        let myUrl = URL(string: "https://private-c7bb6-lendersapi1.apiary-mock.com/api/users/1")
        var request = URLRequest(url: myUrl!)
        
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
//        let getString = ["userEmail": userEmail!, "userPassword": userPassword!] as [String : String]
        
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: getString, options: .prettyPrinted)
//        } catch let error {
//            print(error.localizedDescription)
//            displayAlertMessage(userMessage: "Algo deu errado. Tente novamente!")
//            return
//        }
        
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
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                    
                    if let parseJSON = json {
                        
                        let userEmail = parseJSON["userEmail"] as? String
                        let userPassword = parseJSON["userPassword"] as? String
                        
                        if (userEmail?.isEmpty)! || (userPassword?.isEmpty)! {
                            self.displayAlertMessage(userMessage: "Não foi possível executar esta solicitação. Tente novamente mais tarde.")
                            return
                        } else {
                            
                            self.performSegue(withIdentifier: "protectedView", sender: nil)
//                            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//                            let appDelegate = UIApplication.shared.delegate
//                            appDelegate?.window??.rootViewController = homePage
                        }
                    } else {
                        self.displayAlertMessage(userMessage: "Não foi possível executar esta solicitação. Tente novamente mais tarde.")
                        return
                    }
                } catch {
                    self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                    
                    self.displayAlertMessage(userMessage: "Não foi possível executar esta solicitação. Tente novamente mais tarde.")
                    print(error.localizedDescription)
                    print(error)
                }
            }
        }
        task.resume()

    }
    
    @IBAction func crieButtonTapped(_ sender: Any) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        self.present(registerViewController, animated: true, completion: nil)
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
    
    
}

