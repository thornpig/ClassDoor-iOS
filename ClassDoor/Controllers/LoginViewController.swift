//
//  LoginViewController.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInUpButton: UIButton!
    
    var user: User? = nil
    var newUser: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSignInUpButtonTapped(_ sender: UIButton) {
        if let username = self.usernameTextField.text, let password = self.passwordTextField.text  {
            if self.user == nil {
                if User.validifyUsername(username: username) && User.validifyPassword(password: password) {
                    self.user = User(username: username, passwordHash: password, email: "\(username)@\(username).com", firstname: username, lastname: username)
                }
                BackendDataService.shared.save(self.user) {
                    BackendDataService.shared.getWithID($0!.id!, type: type(of: $0!)) {print($0!.id!)}
                    BackendDataService.shared.patchWithID($0!.id!, type: type(of: $0!), data: ["last_name": "\(self.user!.lastname)wahaha"]) {print($0!.lastname)}
                }
            }
        }
    }
    
    @IBAction func onViewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }



}
