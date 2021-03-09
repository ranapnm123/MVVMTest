//
//  LoginVCViewController.swift
//  MVVMTest
//
//  Created by Ravi Rana on 09/03/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let disableColor:UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    let enableColor:UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTF.delegate = self
        passwordTF.delegate = self
        submitButton.backgroundColor = disableColor
        submitButton.isEnabled = false

    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""

        guard let stringRange = Range(range, in: currentText) else { return false }

        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        var emailText:String? = ""
        var passText:String? = ""
        if textField == emailTF {
            emailText = updatedText
            passText = passwordTF.text ?? ""
        } else if textField == passwordTF {
            emailText = emailTF.text ?? ""
            passText = updatedText
        }
        
        if isValidEmail(emailText!) == true && isValidPassword(pass: passText!) {
            submitButton.backgroundColor = enableColor
            submitButton.isEnabled = true
        } else {
            submitButton.backgroundColor = disableColor
            submitButton.isEnabled = false
        }
        
        return true
    }
    
    
    @IBAction func submitAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbar = storyboard.instantiateViewController(identifier: "tabbar")
        self.navigationController?.pushViewController(tabbar, animated: true)
        Utility.shared.saveUserDetails(email: emailTF.text!, pass: passwordTF.text!)
    }

    func isValidPassword(pass:String) -> Bool {
        if pass.count >= 8 && pass.count <= 15 {
            return true
        }
        return false
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
