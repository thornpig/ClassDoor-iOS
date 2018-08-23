//
//  LoginViewController.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    enum SignStatus: String {
        case In = "Sign in"
        case Up = "Sign up"
    }
    
    @IBOutlet weak var emailBorderLineView: UIView!
    @IBOutlet weak var firstnameBorderLineView: UIView!
    @IBOutlet weak var lastnameBorderLineView: UIView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var switchSignInUpButton: UIButton!
    @IBOutlet weak var signInUpButton: UIButton!
    var user: User? = nil
    var newUser: User? = nil
    var signStatus = SignStatus.In
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self

        self.arrangeViews(with: self.signStatus)
    }
    
    func arrangeViews(with status: SignStatus) {
        switch status {
        case .In:
            self.emailTextField.isHidden = true
            self.emailBorderLineView.isHidden = true
            self.firstnameTextField.isHidden = true
            self.firstnameBorderLineView.isHidden = true
            self.lastnameTextField.isHidden = true
            self.lastnameBorderLineView.isHidden = true
            self.signInUpButton.setTitle(SignStatus.In.rawValue, for: .normal)
            self.switchSignInUpButton.setTitle("or \(SignStatus.Up.rawValue)", for: .normal)
        case .Up:
            self.emailTextField.isHidden = false
            self.emailBorderLineView.isHidden = false
            self.firstnameTextField.isHidden = false
            self.firstnameBorderLineView.isHidden = false
            self.lastnameTextField.isHidden = false
            self.lastnameBorderLineView.isHidden = false
            self.signInUpButton.setTitle(SignStatus.Up.rawValue, for: .normal)
            self.switchSignInUpButton.setTitle("or \(SignStatus.In.rawValue)", for: .normal)
        }
//        self.signInUpButton.sizeToFit()
//        self.switchSignInUpButton.sizeToFit()
    }
    

    @IBAction func onSwitchSignInUpButtonTapped(_ sender: UIButton) {
        switch self.signStatus {
        case .In:
            self.signStatus = .Up
        case .Up:
            self.signStatus = .In
        }
        self.arrangeViews(with: self.signStatus)
    }
    
    @IBAction func onSignInUpButtonTapped(_ sender: UIButton) {
        switch self.signStatus {
        case .In:
//            guard let username = self.usernameTextField.text, let password = self.passwordTextField.text, User.validifyUsername(username: username) && User.validifyPassword(password: password) else {
//                print("Invalid username or password!")
//                return
//            }
//            self.user = User(username: username,  passwordHash: password)
            self.user = User(username: "zackzhu",  passwordHash: "123456")
            self.signIn(self.user!)
        case .Up:
            guard let username = self.usernameTextField.text, let password = self.passwordTextField.text, let email = self.emailTextField.text, let firstname = self.firstnameTextField.text, let lastname = self.lastnameTextField.text, User.validifyUsername(username: username) && User.validifyPassword(password: password) else {
                print("Invalid username, password, email, firstname or lastname!")
                return
            }
            self.user = User(username: username, email: email, firstname: firstname, lastname: lastname, passwordHash: password)
            self.signUp(self.user!)
        }
    }
    
    func signIn(_ user: User) {
        BackendDataService.shared.getWithIdentifier(user.username, type: User.AssociatedResource.self) { (userResource) in
            guard let foundUser = userResource?.modelObj else {
                print("could not find user with username \(user.username)")
                return
            }
            
            print("Successfully signed in user \(foundUser.username)")
            self.user = foundUser
            DispatchQueue.main.async {
                self.presentProfileNavVC()
            }
        }
    }
    
    func signUp(_ user: User) {
        BackendDataService.shared.save(UserBackendResource(of: user)) {
            guard let newUser = $0?.modelObj else {
                print("failed to register user with username \(self.user!.username) and email \(self.user!.email!)")
                return
            }
            self.user = newUser
            print("Successfully registered new user \(newUser.username)")
            DispatchQueue.main.async {
                    self.presentProfileNavVC()
            }
        }
    }
    
    func presentProfileNavVC() {
        let profileNavVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileNavigationController") as! UINavigationController
        let profileVC = profileNavVC.childViewControllers.first! as! ProfileViewController
        profileVC.user = self.user
        self.present(profileNavVC, animated: true, completion: nil)
    }
    
    @IBAction func onViewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    

}
