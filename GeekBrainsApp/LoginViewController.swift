//
//  ViewController.swift
//  GeekBrainsApp
//
//  Created by Laptev Sasha on 26/11/2017.
//  Copyright © 2017 Laptev Sasha. All rights reserved.
//

import UIKit

struct KeyChainConfiguration{
    static let serviceName = "TouchMeIn"
    static let accessGroup: String? = nil
}

class LoginViewController: UIViewController {
    var passwordItems: [KeychainPasswordItem] = []
    let createLoginButtonTag = 0
    let loginButtonTag = 1    
    
    @IBOutlet weak var authenticationScrollView: UIScrollView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keybordWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        let hasLogin = UserDefaults.standard.bool(forKey: "hasLoginKey")
        if hasLogin {
            loginButton.setTitle("Login", for: .normal)
            loginButton.tag = loginButtonTag
        } else {
            loginButton.setTitle("Create", for: .normal)
            loginButton.tag = createLoginButtonTag
        }
        if let storedUsername = UserDefaults.standard.value(forKey: "username") as? String {
            userNameTextField.text = storedUsername
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide,object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginButton_Pressed(_ sender: UIButton) {
        guard let newUserName = userNameTextField.text,
            let newPassword = passwordTextField.text,
            !newUserName.isEmpty && !newPassword.isEmpty
            else{
                showLoginError(errorText: "Неправильно заполнененные данные")
                return
        }
        
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        //createLoginPass
        if sender.tag == createLoginButtonTag {
            let hasLoginKey = UserDefaults.standard.bool(forKey: "hasLoginKey")
            if !hasLoginKey{
                UserDefaults.standard.setValue(userNameTextField.text, forKey: "username")
            }
            
            do{
                let passwordItem = KeychainPasswordItem(service: KeyChainConfiguration.serviceName, account: newUserName, accessGroup: KeyChainConfiguration.accessGroup)
                try passwordItem.savePassword(newPassword)
            }
            catch{
                fatalError("Error updating keychain - \(error)")
            }
            
            UserDefaults.standard.set(true, forKey: "hasLoginKey")
            loginButton.tag = loginButtonTag
        } else if sender.tag == loginButtonTag{
            if isAuthorizationCorrect(username: userNameTextField.text!, password: passwordTextField.text!){
                performSegue(withIdentifier: "fromLoginToMainView", sender: self)
            }else{
                
            }
        }
    }
    
    @objc func keybordWasShown(notification: Notification){
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0)
        self.authenticationScrollView?.contentInset = contentInsets
        authenticationScrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(notification: Notification){
        let contentInsets = UIEdgeInsets.zero
        authenticationScrollView?.contentInset = contentInsets
        authenticationScrollView?.scrollIndicatorInsets = contentInsets
    }
    

    @IBAction func authScrollVeiwTapped(_ sender: Any) {
        self.authenticationScrollView?.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    func isAuthorizationCorrect( username: String,  password: String)->Bool{
        guard username == UserDefaults.standard.value(forKey: "username") as? String else {
            return false
        }
        
        do {
            let passwordItem = KeychainPasswordItem(service: KeyChainConfiguration.serviceName,
                                                    account: username,
                                                    accessGroup: KeyChainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            return password == keychainPassword
        }
        catch {
            fatalError("Error reading password from keychain - \(error)")
        }
        
        return false
    }
    
    func showLoginError(errorText erText: String){
        let alert = UIAlertController(title: "Authorization", message:
            erText, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel,
                                      handler: nil))
        present(alert,animated: true, completion: nil)
    }
}

