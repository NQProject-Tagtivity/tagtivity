//
//  EventView.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//

import UIKit

class Event {
    
    let title: String
    let date: Date
    let text: String
    let image: String
    let tags: [String]
    let members: [EventUserModel]
    let eventId: UInt64
    let maxMembers: Int
    
    init(title: String, date: Date, text: String, image: String, tags: [String], members: [EventUserModel], eventId: UInt64, maxMembers: Int) {
        self.title = title
        self.date = date
        self.text = text
        self.image = image
        self.tags = tags
        self.members = members
        self.eventId = eventId
        self.maxMembers = maxMembers
    }
}

class EventView: UIView {
    
    func setup(event: Event) {
        
        addImage(imageName: event.image)
        addTitle(title: event.title)
        addDateLabel(date: event.date)
        addText(tags: event.text)
    }
    
    private let image = UIImageView()
    private let title = UILabel()
    private let date = UILabel()
    private let tags = UILabel()
    
    private func addImage(imageName: String) {

        image.image = UIImage(named: imageName)
        image.layer.cornerRadius = 40
        image.clipsToBounds = true

        image.layer.masksToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        
        let secondBorder = UIView()
        secondBorder.layer.cornerRadius = 42
        secondBorder.clipsToBounds = true
        addSubview(secondBorder)
        secondBorder.backgroundColor = UIColor.app.yellow
        
        secondBorder.snp.makeConstraints { make in
            make.width.equalTo(84)
            make.height.equalTo(84)
            make.left.equalTo(snp.left).offset(16)
            make.top.equalTo(snp.top).offset(16)
        }

        addSubview(image)
        image.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.center.equalTo(secondBorder.snp.center)
        }
    }
    
    private func addTitle(title: String) {
        self.title.tintColor = UIColor.black
        self.title.font = Font.Nunito.bold.with(size: 13)
        self.title.text = title
        self.title.numberOfLines = 0
        
        addSubview(self.title)
        self.title.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(snp.top).offset(16)
        }
    }
    
    private func addDateLabel(date: Date) {
        self.date.tintColor = UIColor.app.darkGray
        self.date.font = Font.Nunito.regular.with(size: 13)
        self.date.text = Utils.dateFormat(date: date) + " " + Utils.timeFormat(date: date)
        
        
        let icon = UIImageView()
        icon.image = UIImage(named: "calendar")
        
        addSubview(icon)
        icon.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(16)
            make.top.equalTo(self.title.snp.bottom).offset(16)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        addSubview(self.date)
        self.date.snp.makeConstraints { make in
            make.left.equalTo(icon.snp.right).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.centerY.equalTo(icon.snp.centerY)
        }
    }
    
    private func addText(tags: String) {
        self.tags.tintColor = UIColor.app.darkGray
        self.tags.font = Font.Nunito.regular.with(size: 13)
        self.tags.text = tags
        self.tags.numberOfLines = 2
        
        addSubview(self.tags)
        self.tags.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(self.image.snp.bottom).offset(10)
        }
    }
}
