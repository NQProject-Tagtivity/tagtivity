//
//  LoginViewController.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField


class LoginViewController: UIViewController {
    
    static func loadFromStoryBoard() -> LoginViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
    }
        
    override func viewDidLoad() {
        setupLoginField()
        setupPasswordField()
        setupLoginButton()
    }
    
    @IBOutlet weak var login: SkyFloatingLabelTextField!
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        
        guard let login = login.text, !login.isEmpty else {
            Alert.basic(self, title: nil, message: "Podaj login")
            return
        }
        
        guard let password = password.text, !password.isEmpty else {
            Alert.basic(self, title: nil, message: "Podaj hasło")
            return
        }

        UserDefaults.set(userName: login)
        UserDefaults.set(icon: "user2")
        
        NetworkRequests.shared.signIn(username: login) { _ in
            
            NetworkRequests.shared.updateUser(user: User(id: UserDefaults.id, username: login, icon: "user2", description: "", tags: [])) { _ in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func setupLoginField() {
        login.delegate = self
        login.title = ""
        login.placeholder = "Nazwa użytkownika"
        login.textAlignment = .center
        login.textColor = .black
        login.lineColor = UIColor.app.darkGray
        login.selectedTitleColor = .black
        login.selectedLineColor = UIColor.app.yellow
        login.lineHeight = 2.0
        login.selectedLineHeight = 2.0
    }
    
    private func setupPasswordField() {
        
        password.delegate = self
        password.isSecureTextEntry = true
        password.title = ""
        password.placeholder = "Hasło"
        password.textAlignment = .center
        password.textColor = .black
        password.lineColor = UIColor.app.darkGray
        password.selectedTitleColor = .black
        password.selectedLineColor = UIColor.app.yellow
        password.lineHeight = 2.0
        password.selectedLineHeight = 2.0
    }
    
    private func setupLoginButton() {
        loginButton.setTitle("Zaloguj się", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = Font.Nunito.semiBold.with(size: 13)
        loginButton.backgroundColor = UIColor.app.yellow
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 15
        loginButton.contentEdgeInsets.left = 15
        loginButton.contentEdgeInsets.top = 10
        loginButton.contentEdgeInsets.bottom = 10
        loginButton.contentEdgeInsets.right = 15
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
