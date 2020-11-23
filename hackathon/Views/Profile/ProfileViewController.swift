//
//  ProfileViewController.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 20/11/2020.
//

import Foundation
import UIKit
import SwiftDate

class ProfileViewController: UIViewController {
    
    static func loadFromStoryBoard() -> ProfileViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        
        navigationController?.navigationBar.barTintColor = UIColor.app.yellow
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func didPressEditButton() {
        tag.isEnabled = true
        text.isEnabled = true
    }
    
    @objc func didPressSaveButton() {
        NetworkRequests.shared.updateUser(user: User(id: UserDefaults.id, username: UserDefaults.userName ?? "", icon: "user2", description: descriptionText, tags: tagText.split(separator: " ").map { String($0) })) { result in
            self.tag.isEnabled = true
            self.text.isEnabled = true
            self.saveButton.backgroundColor = .gray
            self.saveButton.isEnabled = false
        }
    }
    

    override func viewDidLoad() {
        appendLabel()
        appendMainView()
        appendButton()
        appendContent()
        appendSettingsButton()
    }
    
    // todo
    @objc func didPressJoinButton() { }
    
    private let mainView = UIView()
    private let clockButton = UIButton()
    private let calendarButton = UIButton()
    private let button = UIButton()
    private let labelView = UIView()
    private let tag = UILabel()
    private let text = UILabel()
    private let saveButton = UIButton()
    private var tagText = ""
    private var descriptionText = ""

    private func appendLabel() {
        
        labelView.backgroundColor = UIColor.app.yellow
        view.addSubview(labelView)
        
        labelView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(0)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(100)
        }
        
        let label = UILabel()
        
        label.text = "Mój profil"
        label.font = Font.Nunito.semiBold.with(size: 18)
        label.textColor = UIColor.white
        
        labelView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(labelView.snp.centerX)
            make.top.equalTo(labelView.snp.top).offset(50)
        }
    }
    
    private func appendMainView() {
        
        view.addSubview(mainView)
        mainView.backgroundColor = .white
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 25
        mainView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(32)
            make.right.equalTo(view.snp.right).offset(-32)
            make.top.equalTo(labelView.snp.bottom).offset(100)
        }
        
        mainView.layer.masksToBounds = false
        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 12.0)
        mainView.layer.shadowColor = UIColor.app.darkGray.cgColor
        mainView.layer.shadowRadius = 12.0
        mainView.layer.shadowOpacity = 0.2

        let backgroundCGColor = view.backgroundColor?.cgColor
        mainView.backgroundColor = nil
        mainView.layer.backgroundColor = backgroundCGColor
    }
    
    private func appendButton() {

        view.addSubview(button)
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 75
        if let icon = UserDefaults.icon {
            button.setImage(UIImage(named: icon), for: .normal)
        }
        button.backgroundColor = UIColor.app.yellow
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.app.yellow.cgColor
        
        button.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(150)
            
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(labelView.snp.bottom).offset(100-75)
        }
        
        button.addTarget(self, action: #selector(didPressSaveButton), for: .touchUpInside)
    }
    
    private func appendContent() {
        let editIcon = UIImageView()
        editIcon.image = UIImage(named: "edit")
        editIcon.imageColor = UIColor.app.yellow
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didPressEditButton))
        editIcon.addGestureRecognizer(tap)
        editIcon.isUserInteractionEnabled = true

        
        mainView.addSubview(editIcon)
        
        editIcon.snp.makeConstraints { make in
            make.right.equalTo(mainView.snp.right).offset(-16)
            make.top.equalTo(mainView.snp.top).offset(16)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        let nick = UILabel()
        nick.textAlignment = .center
        nick.font = Font.Nunito.semiBold.with(size: 17)
            
        
        text.textAlignment = .center
        text.font = Font.Nunito.regular.with(size: 13)
        text.text = "Uzupełnij informacje o sobie"

        tag.text = "Uzupełnij swoje tagi"
        tag.textAlignment = .center
        tag.font = Font.Nunito.regular.with(size: 13)
        tag.textColor = UIColor.app.darkGray
        
        

        saveButton.setTitle("Zapisz", for: .normal)
        saveButton.titleLabel?.font = Font.Nunito.bold.with(size: 18)
        saveButton.backgroundColor = UIColor.app.darkGray
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 15
        saveButton.contentEdgeInsets.left = 15
        saveButton.contentEdgeInsets.top = 10
        saveButton.contentEdgeInsets.bottom = 10
        saveButton.contentEdgeInsets.right = 15
        
        mainView.addSubview(nick)
        mainView.addSubview(text)
        mainView.addSubview(tag)
        mainView.addSubview(saveButton)
        
        nick.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.left)
            make.right.equalTo(mainView.snp.right)
            make.top.equalTo(editIcon.snp.bottom).offset(64)
            make.height.equalTo(20)
        }
        
        text.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.left).offset(16)
            make.right.equalTo(mainView.snp.right).offset(-16)
            make.top.equalTo(nick.snp.bottom).offset(16)
        }

        tag.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.left).offset(16)
            make.right.equalTo(mainView.snp.right).offset(-16)
            make.top.equalTo(text.snp.bottom).offset(16)
        }

        saveButton.snp.makeConstraints { make in
            make.centerX.equalTo(mainView.snp.centerX)
            make.top.equalTo(tag.snp.bottom).offset(16)
            make.height.equalTo(40)
            make.bottom.equalTo(mainView.snp.bottom).offset(-16)
        }
        
        mainView.layer.masksToBounds = false
        mainView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        mainView.layer.shadowColor = UIColor.app.darkGray.cgColor
        mainView.layer.shadowRadius = 6.0
        mainView.layer.shadowOpacity = 0.5

        let backgroundCGColor = view.backgroundColor?.cgColor
        mainView.backgroundColor = nil
        mainView.layer.backgroundColor = backgroundCGColor

    }
    
    private func appendSettingsButton() {
        let button = UIButton()
        button.setTitle("Ustawienia", for: .normal)
        button.titleLabel?.font = Font.Nunito.bold.with(size: 13)
        button.backgroundColor = UIColor.app.yellow
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.contentEdgeInsets.left = 15
        button.contentEdgeInsets.top = 10
        button.contentEdgeInsets.bottom = 10
        button.contentEdgeInsets.right = 15
        
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(mainView.snp.bottom).offset(57)
            make.height.equalTo(40)
        }
        
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        button.layer.shadowColor = UIColor.app.darkGray.cgColor
        button.layer.shadowRadius = 6.0
        button.layer.shadowOpacity = 0.5
    }
}




