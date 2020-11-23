//
//  EventViewController.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import SwiftDate

class EventViewController: UIViewController {
    
    var event: Event?
    
    static func loadFromStoryBoard() -> EventViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // setup navigation controller
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.barTintColor = UIColor.app.yellow
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func didPressJoinButton() {
        
        guard let event = event else { return }
        
        NetworkRequests.shared.addMember(eventId: event.eventId, userId: UInt64(UserDefaults.id)) { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }

    @objc func didPressBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        
        setupNavigationController()
        setupScrollView()
        appendMainView()
        appendButton()
        appendContent()
    }

    private let mainView = UIView()
    private let clockButton = UIButton()
    private let calendarButton = UIButton()
    private var container = UIView()
    private var scrollView = UIScrollView()

    private func setupNavigationController() {
        self.title = "Wydarzenie"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: Font.Nunito.semiBold.with(size: 17)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

        
        var image = UIImage(named: "arrow")!
        image = Utils.resizeImage(image: image, targetSize: CGSize(width: 30, height: 30))
        self.navigationController?.navigationBar.backIndicatorImage = image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupScrollView() {
        
        print("setupScrollView")
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)

        }
        
        scrollView.addSubview(container)
        
        
        container.snp.makeConstraints { make in
            make.left.equalTo(scrollView.snp.left).offset(0)
            make.right.equalTo(scrollView.snp.right).offset(0)
            make.top.equalTo(scrollView.snp.top).offset(0)
            make.bottom.equalTo(scrollView.snp.bottom).offset(0)
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    private func appendMainView() {
        
        container.addSubview(mainView)
        
        mainView.backgroundColor = .white
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 25
        
        mainView.snp.makeConstraints { make in
            make.left.equalTo(container.snp.left).offset(32)
            make.right.equalTo(container.snp.right).offset(-32)
            make.top.equalTo(container.snp.top).offset(64)
            make.bottom.equalTo(container.snp.bottom).offset(-30)
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
    
    func appendButton() {
        
        guard let event = event else { return }
        let image = UIImageView()
        
        container.addSubview(image)
        
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        image.image = UIImage(named: event.image)
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.app.yellow.cgColor
        
        image.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            
            make.centerX.equalTo(container.snp.centerX)
            make.top.equalTo(container.snp.top).offset(32)
        }
    }
    
    func appendContent() {
        
        guard let event = event else { return }
        
        let textField = UILabel()
        textField.text = event.title
        textField.font = Font.Nunito.semiBold.with(size: 17)
        mainView.addSubview(textField)
        textField.textAlignment = .center
        textField.numberOfLines = 0
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(mainView.snp.top).offset(80)
            make.left.equalTo(view.snp.left).offset(80)
            make.right.equalTo(view.snp.right).offset(-80)
            make.height.equalTo(80)
        }
        
        let calendarIcon = UIImageView()
        calendarIcon.image = UIImage(named: "calendar")
        let clockIcon = UIImageView()
        clockIcon.image = UIImage(named: "clock")
    
        let userIcon = UIImageView()
        userIcon.image = UIImage(named: "friends")

        let members = UILabel()
        members.text = "\(event.members.count)/\(event.maxMembers)"
        members.font = Font.Nunito.regular.with(size: 13)
        
        calendarButton.setTitle(Utils.dateFormat(date: Date()), for: .normal)
        calendarButton.setTitleColor(.black, for: .normal)
//        calendarButton.isEnabled = false
        calendarButton.titleLabel?.font = Font.Nunito.regular.with(size: 13)
        
        clockButton.setTitle(Utils.timeFormat(date: Date()), for: .normal)
        clockButton.setTitleColor(.black, for: .normal)
//        clockButton.isEnabled = false
        clockButton.titleLabel?.font = Font.Nunito.regular.with(size: 13)

        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = Font.Nunito.regular.with(size: 13)
        label.text = event.text
        label.sizeToFit()
        
        mainView.addSubview(calendarIcon)
        mainView.addSubview(clockIcon)
        mainView.addSubview(calendarButton)
        mainView.addSubview(clockButton)
        mainView.addSubview(label)
        
        mainView.addSubview(members)
        mainView.addSubview(userIcon)
        
        calendarIcon.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.left).offset(32)
            make.top.equalTo(textField.snp.bottom).offset(16)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        clockIcon.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.left).offset(32)
            make.top.equalTo(calendarIcon.snp.bottom).offset(16)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        
        calendarButton.snp.makeConstraints { make in
            make.centerY.equalTo(calendarIcon.snp.centerY)
            make.left.equalTo(calendarIcon.snp.right).offset(32)
            
        }
        
        clockButton.snp.makeConstraints { make in
            make.centerY.equalTo(clockIcon.snp.centerY)
            make.left.equalTo(clockIcon.snp.right).offset(32)
        }
        
        members.snp.makeConstraints { make in
            make.centerY.equalTo(userIcon.snp.centerY)
            make.left.equalTo(userIcon.snp.right).offset(32)
        }
        
        
        userIcon.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.left).offset(32)
            make.top.equalTo(clockIcon.snp.bottom).offset(16)
            make.width.equalTo(25)
            make.height.equalTo(25)

        }
                
        label.snp.makeConstraints { make in
            make.left.equalTo(mainView.snp.left).offset(16)
            make.top.equalTo(userIcon.snp.bottom).offset(16)
            make.right.equalTo(mainView.snp.right).offset(-16)
//            make.height.equalTo(200)
        }
        
        let tags = UILabel()
        tags.text = "#" + event.tags.joined(separator:" #")
        tags.textAlignment = .center
        tags.numberOfLines = 0
        tags.font = Font.Nunito.regular.with(size: 13)
        tags.textColor = UIColor.app.darkGray
        mainView.addSubview(tags)
        
        tags.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(16)
            make.left.equalTo(mainView.snp.left).offset(16)
            make.right.equalTo(mainView.snp.right).offset(-16)
            make.height.equalTo(50)
        }
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally

        stack.spacing = 16
        
        mainView.addSubview(stack)
        
        let count = min(event.members.count, 4)
        
        let size = count*50 + (count-1)*16

        for (idx, i) in event.members.prefix(4).enumerated() {
            
            if let image = UIImage(named: i.icon) {
                
                if idx == 3 && event.members.count > 4 {
                    
                    let view = UIView()
                    view.backgroundColor = UIColor.app.darkBlue
                    view.snp.makeConstraints { make in
                        make.height.equalTo(50)
                        make.width.equalTo(50)
                    }

                    view.clipsToBounds = true
                    view.layer.cornerRadius = 25
                    
                    let label = UILabel()
                    label.textAlignment = .center
                    label.textColor = .white
                    label.text = "+\(event.members.count - 3)"
                    label.font = Font.Nunito.bold.with(size: 14)
                    view.addSubview(label)
                    label.snp.makeConstraints { make in
                        make.center.equalTo(view.snp.center)
                    }
                    
                    stack.addArrangedSubview(view)
                    
                } else {
                    let imageView = UIImageView(image: Utils.resizeImage(image: image, targetSize: CGSize(width: 50, height: 50)))
                    imageView.clipsToBounds = true
                    imageView.layer.cornerRadius = 25
                    stack.addArrangedSubview(imageView)
                }
            }
        }
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(tags.snp.bottom).offset(16)
            make.centerX.equalTo(mainView.snp.centerX)
            make.height.equalTo(50)
            make.width.equalTo(size)
        }
        
        let button = UIButton()
        button.setTitle("Dołącz!", for: .normal)
        button.titleLabel?.font = Font.Nunito.bold.with(size: 17)
        mainView.addSubview(button)
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.contentEdgeInsets.left = 15
        button.contentEdgeInsets.top = 10
        button.contentEdgeInsets.bottom = 10
        button.contentEdgeInsets.right = 15
        button.backgroundColor = UIColor.app.yellow
        
        button.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(16)
            make.height.equalTo(35)
            make.centerX.equalTo(mainView.snp.centerX)
            make.bottom.equalTo(mainView.snp.bottom).offset(-16)
        }
        
        button.addTarget(self, action: #selector(didPressJoinButton), for: .touchUpInside)
        
        button.isHidden = false
        
        guard let name = UserDefaults.userName else {
            return
        }
        
        for i in event.members {
            if i.username == name {
                button.isHidden = true
            }
        }
    }
}


