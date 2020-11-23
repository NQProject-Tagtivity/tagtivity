//
//  AddEventViewController.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import SwiftDate

class AddEventViewController: UIViewController {
    
    static func loadFromStoryBoard() -> AddEventViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AddEventViewController") as? AddEventViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.barTintColor = UIColor.app.yellow
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func didPressSaveButton() {
        let event = CreateEventModel(host: UInt64(UserDefaults.id), startTime: UInt64(date.timeIntervalSince1970), endTime: UInt64(date.timeIntervalSince1970), title: titleText, description: descriptionText, maxMembers: 5, icon: "activity5", tags: tagText.split(separator: " ").map { String($0) })
        
        NetworkRequests.shared.createEvent(event: event) { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func viewDidLoad() {
        
        setupNavigationController()
        appendMainView()
        appendButton()
        appendContent()
    }
    
    @objc func didPressCalendarButton() {
        DatePickerDialog().show("Ustaw date", doneButtonTitle: "Ok", cancelButtonTitle: "Anuluj", minimumDate: Date(), datePickerMode: .date) { date -> Void in

            guard let date = date else { return }
            self.calendarButton.setTitle(Utils.dateFormat(date: date), for: .normal)
        }
    }
    
    @objc func didPressTimerButton() {
        DatePickerDialog().show("Ustaw czas", doneButtonTitle: "Ok", cancelButtonTitle: "Anuluj", minimumDate: Date(), datePickerMode: .time) { date -> Void in

            guard let date = date else { return }
            self.clockButton.setTitle(Utils.timeFormat(date: date), for: .normal)
            self.date = date
        }
    }
    
    private let mainView = UIView()
    private let textField = SkyFloatingLabelTextField()
    private let tagField = SkyFloatingLabelTextField()
    private let descriptionField = SkyFloatingLabelTextField()
    private let clockButton = UIButton()
    private let calendarButton = UIButton()
    private var date = Date()
    private let saveButton = UIButton()
    private var tagText = ""
    private var descriptionText = ""
    private var titleText = ""
    
    private func setupNavigationController() {
        self.title = "Nowe wydarzenie"
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: Font.Nunito.semiBold.with(size: 17)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        var image = UIImage(named: "arrow")!
        image = Utils.resizeImage(image: image, targetSize: CGSize(width: 30, height: 30))
        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image

        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func appendMainView() {
        view.addSubview(mainView)
        mainView.backgroundColor = .white
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 25
        mainView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(32)
            make.right.equalTo(view.snp.right).offset(-32)
            make.top.equalTo(view.snp.top).offset(64)
            make.bottom.equalTo(view.snp.bottom).offset(-200)

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
    
    private func appendButton() {
        
        let button = UIButton()
        
        view.addSubview(button)
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 50
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = Font.Nunito.semiBold.with(size: 30)
        button.backgroundColor = UIColor.app.yellow
        
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(32)
        }
        
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        button.layer.shadowColor = UIColor.app.darkGray.cgColor
        button.layer.shadowRadius = 6.0
        button.layer.shadowOpacity = 0.5
    }
    
    private func appendContent() {
        
        textField.delegate = self
        textField.title = ""
        textField.placeholder = "Nazwa eventu"
        
        
        textField.textAlignment = .center
        
        textField.textColor = .black
        textField.lineColor = UIColor.app.darkGray
        textField.selectedTitleColor = .black
        textField.selectedLineColor = UIColor.app.yellow

        textField.lineHeight = 2.0
        textField.selectedLineHeight = 2.0
        mainView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).offset(80)
            make.left.equalTo(view.snp.left).offset(80)
            make.right.equalTo(view.snp.right).offset(-80)
            make.height.equalTo(45)
        }
        
        let calendarIcon = UIImageView()
        calendarIcon.image = UIImage(named: "calendar")
        let clockIcon = UIImageView()
        clockIcon.image = UIImage(named: "clock")
        
        
        calendarButton.setTitle(Utils.dateFormat(date: Date()), for: .normal)
        calendarButton.setTitleColor(.black, for: .normal)
        calendarButton.addTarget(self, action: #selector(didPressCalendarButton), for: .touchUpInside)

        
        clockButton.setTitle(Utils.timeFormat(date: Date()), for: .normal)
        clockButton.setTitleColor(.black, for: .normal)
        clockButton.addTarget(self, action: #selector(didPressTimerButton), for: .touchUpInside)

        
        mainView.addSubview(calendarIcon)
        mainView.addSubview(clockIcon)
        mainView.addSubview(calendarButton)
        mainView.addSubview(clockButton)
        mainView.addSubview(tagField)
        
        calendarIcon.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.left).offset(32)
            make.top.equalTo(textField.snp.bottom).offset(32)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        clockIcon.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.left).offset(32)
            make.top.equalTo(calendarIcon.snp.bottom).offset(32)
            make.width.equalTo(35)
            make.height.equalTo(35)
        }
        
        calendarButton.snp.makeConstraints { make in
            make.centerY.equalTo(calendarIcon.snp.centerY)
            make.left.equalTo(calendarIcon.snp.right).offset(32)
            
        }
        
        clockButton.snp.makeConstraints { make in
            make.centerY.equalTo(clockIcon.snp.centerY)
            make.left.equalTo(clockIcon.snp.right).offset(32)

        }
        
        tagField.delegate = self
        tagField.title = ""
        tagField.placeholder = "#tag"
        
        
        tagField.textAlignment = .center
        
        tagField.textColor = .black
        tagField.lineColor = UIColor.app.darkGray
        tagField.selectedTitleColor = .black
        tagField.selectedLineColor = UIColor.app.yellow

        tagField.lineHeight = 2.0
        tagField.selectedLineHeight = 2.0
        mainView.addSubview(tagField)
        
        tagField.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.left).offset(16)
            make.top.equalTo(clockIcon.snp.bottom).offset(16)
            make.right.equalTo(mainView.snp.right).offset(-16)
        }
        
        descriptionField.delegate = self
        descriptionField.title = ""
        descriptionField.placeholder = "Opis"
        
        
        descriptionField.textAlignment = .center
        
        descriptionField.textColor = .black
        descriptionField.lineColor = UIColor.app.darkGray
        descriptionField.selectedTitleColor = .black
        descriptionField.selectedLineColor = UIColor.app.yellow

        descriptionField.lineHeight = 2.0
        descriptionField.selectedLineHeight = 2.0
        mainView.addSubview(descriptionField)
        
        descriptionField.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.left).offset(16)
            make.top.equalTo(tagField.snp.bottom).offset(16)
            make.right.equalTo(mainView.snp.right).offset(-16)
        }
        
        
        saveButton.setTitle("Zapisz", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        
        mainView.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionField.snp.bottom).offset(20)
            make.centerX.equalTo(mainView.snp.centerX)
        }
        
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = 15
        saveButton.contentEdgeInsets.left = 15
        saveButton.contentEdgeInsets.top = 10
        saveButton.contentEdgeInsets.bottom = 10
        saveButton.contentEdgeInsets.right = 15
        
        saveButton.backgroundColor = .gray
        saveButton.isEnabled = false
        
        saveButton.addTarget(self, action: #selector(didPressSaveButton), for: .touchUpInside)

    }
}

extension AddEventViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkText()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        checkText()
    }
    
    func checkText() {
        if tagField.text == nil || textField.text == nil || descriptionField.text == nil {
            saveButton.backgroundColor = .gray
            saveButton.isEnabled = false
            return
        }
        
        if let text = tagField.text, text.isEmpty {
            saveButton.backgroundColor = .gray
            saveButton.isEnabled = false
            return
        }
        
        
        if let text = descriptionField.text, text.isEmpty {
            saveButton.backgroundColor = .gray
            saveButton.isEnabled = false
            return
        }
        
        if let text = textField.text, text.isEmpty {
            saveButton.backgroundColor = .gray
            saveButton.isEnabled = false
            return
        }
        
        
        tagText = tagField.text ?? ""
        descriptionText = descriptionField.text ?? ""
        titleText = textField.text ?? ""
        
        saveButton.backgroundColor = UIColor.app.yellow
        saveButton.isEnabled = true
    }
}

