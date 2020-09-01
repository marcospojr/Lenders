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
        
        print("Email:" + (userEmail?.text)! + "\n")
        print("EmailStored:" + userEmailStored! + "\n")
        print("Senha:" + (userPassword?.text)! + "\n")
        print("SenhaStored:" + userPasswordStored! + "\n")

        if(userEmail?.text == userEmailStored) {
            if(userPassword?.text == userPasswordStored) {
                UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                UserDefaults.standard.synchronize()
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func crieButtonTapped(_ sender: Any) {
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        self.present(registerViewController, animated: true, completion: nil)
    }
    
    
}

