//
//  LoginVC.swift
//  IOSTest
//
//  Created by Sirak Zeray on 10/29/19.
//  Copyright © 2019 Sirak Zeray. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak fileprivate var emailTextfield: TextFieldExtended!
    @IBOutlet weak fileprivate var passwordTextField: TextFieldExtended!
    @IBOutlet weak fileprivate var loginOutlet: UIButton!
    
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
     //MARK: - ACTIONS
    @IBAction fileprivate func login(_ sender: Any) {
        
        if !textFieldsAreEmpty() {
            // Force Unwrap on text because textfield is already checked if it contains any value
            let email = emailTextfield.text!
            let password = passwordTextField.text!
            if Login.isEmailValid(email: email) && Login.isPasswordValid(password: password ) {
                let model = LoginModel(email: email, password: password)
                let login = Login(model: model)
                login.logUserIn { (res) in
                    switch res {
                    case .success(let status):
                        if status{

                            let timeDiffrence = "\(login.timeDiffrence ?? 0) miliseconds"
                            self.createAlert(title: "Sucess", message: "Login was Sucessful. Time took \(timeDiffrence)", dismiss: true)

                        } else {
                            self.createAlert(title: "Wrong Cruditional", message: "Your cruditional does not match our database", dismiss: false)
                        }
                    case .failure(let error):
                        self.createAlert(title: "Error Took Place", message: error.localizedDescription, dismiss: true)
                    }
                }

            } else {
                createAlert(title: "Proper Format", message: "Please enter proper format email and password. Password must contain 1 uppercase letter", dismiss: false)
            }
        } else {
            createAlert(title: "Enter All Fields", message: "", dismiss: false)
        }
    }
    
     //MARK: - FUNCTIONS
    
    /// Checks if password and email textfields are empty or not
    fileprivate func textFieldsAreEmpty() -> Bool {
        guard let _ = emailTextfield.text else {return true}
        guard let _ = passwordTextField.text else {return true}
        if emailTextfield.text!.isEmpty || passwordTextField.text!.isEmpty {
            return true
        }
       
        return false
    }
    
  /// Creates an UIAlertController with the passed in parameters
  fileprivate func createAlert(title : String , message : String, dismiss : Bool)  {
         DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
                                  alertController.addAction(UIAlertAction(title: "Okay",
                                  style: UIAlertAction.Style.default,
                                  handler: {(alert: UIAlertAction!) in
                                       if !dismiss{
                                           alertController.dismiss(animated: true)
                                       }else {
                                         self.navigationController?.popToRootViewController(animated: true)
                                       } }))
              self.present(alertController, animated: true, completion: nil)
        }
     }
    
   

}
