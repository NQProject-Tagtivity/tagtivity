//
//  NearestEventView.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//


import UIKit

class NearestEventView: UIView {

    func setup(event: Event) {
        addLabel()
        addImage(imageName: event.image)
        addDate(date: event.date)
        addText(text: event.title)
    }
    
    private let image = UIImageView()
    private let date = UILabel()
    private let text = UILabel()
    
    private func addLabel() {
    
        let label = UILabel()
        label.text = "NAJBLIŻSZE WYDARZENIE"
        label.font = Font.Nunito.bold.with(size: 13)
        label.textColor = .black
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(16)
            make.centerX.equalTo(snp.centerX)
        }
        
        let line = UIView()
        
        addSubview(line)
        line.backgroundColor = UIColor.app.darkGray
        
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(label.snp.bottom).offset(8)
        }
    }
    
    private func addImage(imageName: String) {
        
        image.image = UIImage(named: imageName)
        image.layer.cornerRadius = 40
        image.clipsToBounds = true

        image.layer.masksToBounds = true
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.white.cgColor
        let container = UIView()
        container.layer.cornerRadius = 42
        container.clipsToBounds = true
        addSubview(container)
        container.backgroundColor = UIColor.app.yellow
        
        container.snp.makeConstraints { make in
            make.width.equalTo(84)
            make.height.equalTo(84)
            make.left.equalTo(snp.left).offset(16)
            make.top.equalTo(snp.top).offset(64)
        }

        addSubview(image)
        image.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.center.equalTo(container.snp.center)
        }
    }

    private func addDate(date: Date) {
        self.date.tintColor = UIColor.black
        self.date.font = Font.Nunito.bold.with(size: 13)
        self.date.text = Utils.dateFormat(date: date) + " " + Utils.timeFormat(date: date)


        addSubview(self.date)
        self.date.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(image.snp.top)
        }
    }

    private func addText(text: String) {
        self.text.textColor = UIColor.app.darkGray
        self.text.font = Font.Nunito.regular.with(size: 13)
        self.text.text = text
        self.text.numberOfLines = 0

        addSubview(self.text)
        self.text.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(self.date.snp.bottom).offset(10)
        }
    }
}
