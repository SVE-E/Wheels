//
//  ViewController.swift
//  Wheels
//
//  Created by Seve Esposito on 10/11/18.
//  Copyright © 2018 SS. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        return true
    }
    

    @IBAction func login(_ sender: Any) {
        if let email = emailTextField.text, let pass = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: pass) { (user, error) in
                if user != nil{ // successful login
                    self.performSegue(withIdentifier: "loginToMap", sender: self)
                }
                if error != nil{ //unsuccessful login
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = "Incorrect information entered"
                }
            }
        }
        else {
            errorLabel.isHidden = false
            errorLabel.text = "Complete all fields"
        }
    }
    
    
    @IBAction func signup(_ sender: Any) {
        if confirmLabel.isHidden == true { //hits create account firsttime
            confirmLabel.isHidden = false
            confirmPasswordTextField.isHidden = false
             self.errorLabel.isHidden = false
            errorLabel.text = "Enter information and press create account"
        }
        else{ //presses it second time to create account
            if let email = emailTextField.text, let pass = passwordTextField.text, let confirmpass = confirmPasswordTextField.text {
                if pass == confirmpass{ //checks confirmPassword
                    Auth.auth().createUser(withEmail: email, password: pass) { (user, errpr) in //succesful sign up
                        self.confirmLabel.isHidden = true
                        self.confirmPasswordTextField.isHidden = true
                        self.errorLabel.isHidden = false
                        self.errorLabel.text = "Signed up!"
                    }
                }
                else {
                     self.errorLabel.isHidden = false
                     errorLabel.text = "Passwords do not match"
                }
            }
            else {
                 self.errorLabel.isHidden = false
                errorLabel.text = "Complete all fields"
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToMap" {
            if let viewController = segue.destination as? LocationViewController {
                //pass data if need be
            }
        }
    }
    
    
}

