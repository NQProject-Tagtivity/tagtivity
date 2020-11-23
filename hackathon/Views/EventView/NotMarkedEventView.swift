//
//  NotMarkedCell.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//

import Foundation
import UIKit

class NotMarkedCell: UIView {
    
    let image = UIImageView()
    let date = UILabel()
    let text = UILabel()
    let labelView = UIView()

    func setup(event: Event) {
        addLabel()
        addImage(imageName: event.image)
        addText(text: event.title)
        addDateLabel(date: event.date)
        appendIcon()
    }
    
    private func addLabel() {
        
        let label = UILabel()
        label.text = "CO SĄDZISZ O TYM WYDARZENIU?"
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
        let secondBorder = UIView()
        secondBorder.layer.cornerRadius = 42
        secondBorder.clipsToBounds = true
        addSubview(secondBorder)
        secondBorder.backgroundColor = UIColor.app.yellow
        
        secondBorder.snp.makeConstraints { make in
            make.width.equalTo(84)
            make.height.equalTo(84)
            make.left.equalTo(snp.left).offset(16)
            make.top.equalTo(snp.top).offset(64)
        }

        addSubview(image)
        image.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.center.equalTo(secondBorder.snp.center)
        }
    }

    private func addDateLabel(date: Date) {
        
        self.date.textColor = UIColor.app.darkGray
        self.date.font = Font.Nunito.regular.with(size: 13)
        self.date.text = Utils.dateFormat(date: date) + " " + Utils.timeFormat(date: date)

        addSubview(self.date)
        self.date.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(self.text.snp.bottom).offset(16)
        }
    }

    private func addText(text: String) {
        
        self.text.textColor = UIColor.black
        self.text.font = Font.Nunito.bold.with(size: 13)
        self.text.text = text
        self.text.numberOfLines = 0

        addSubview(self.text)
        self.text.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(image.snp.top).offset(10)
        }
    }
    
    func appendIcon() {
        
        let container = UIView()
        container.backgroundColor = .clear
        
        let discard = UIImageView()
        let like = UIImageView()
        
        let discardImage = UIImage(named: "x")!
        discard.image = Utils.resizeImage(image: discardImage, targetSize: CGSize(width: 24, height: 24))
        discard.imageColor = UIColor.app.yellow
        
        let likeImage = UIImage(named: "like")!
        like.image = Utils.resizeImage(image: likeImage, targetSize: CGSize(width: 30, height: 30))
        like.imageColor = UIColor.app.yellow
        
        addSubview(container)
        container.addSubview(discard)
        container.addSubview(like)
        
        container.snp.makeConstraints { make in
            make.centerX.equalTo(snp.centerX)
            make.top.equalTo(self.date.snp.bottom).offset(12)
        }
        
        discard.snp.makeConstraints { make in
            make.left.equalTo(container.snp.left)
            make.top.equalTo(container.snp.top)
        }
        
        like.snp.makeConstraints { make in
            make.right.equalTo(container.snp.right)
            make.centerY.equalTo(discard.snp.centerY)
            make.left.equalTo(discard.snp.right).offset(100)
        }
        
        let likeLabel = UILabel()
        likeLabel.text = "Super!"
        likeLabel.font = Font.Nunito.regular.with(size: 11)
        
        let discardLabel = UILabel()
        discardLabel.text = "Odrzuć"
        discardLabel.font = Font.Nunito.regular.with(size: 11)

        container.addSubview(likeLabel)
        container.addSubview(discardLabel)
        
        
        discardLabel.snp.makeConstraints { make in
            make.centerX.equalTo(discard.snp.centerX)
            make.top.equalTo(discard.snp.bottom).offset(5)
        }
        
        likeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(discardLabel.snp.centerY)
            make.centerX.equalTo(like.snp.centerX)
        }
    }
}

