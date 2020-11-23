//
//  EventView.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//

import UIKit

class EventView: UIView {
    
    let image = UIImageView()
    let title = UILabel()
    let date = UILabel()
    let tags = UILabel()


    
    func setup(title: String, date: String, tags: String, image: String) {
        addImage(imageName: image)
        addTitle(title: title)
        addDate(date: date)
        addTag(tags: tags)
    }
    
    private func addImage(imageName: String) {
        image.image = UIImage(named: imageName)
        image.imageColor = UIColor.app.yellow
        addSubview(image)
        image.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.left.equalTo(snp.left).offset(16)
            make.top.equalTo(snp.top).offset(16)
        }
    }
    
    private func addTitle(title: String) {
        self.title.tintColor = UIColor.black
        self.title.font = Typography.h2
        self.title.text = title
        self.title.numberOfLines = 0
        
        addSubview(self.title)
        self.title.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(snp.top).offset(16)
        }
    }
    
    private func addDate(date: String) {
        self.date.tintColor = UIColor.black
        self.date.font = Typography.h3
        self.date.text = date
        
        addSubview(self.date)
        self.date.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(self.title.snp.bottom).offset(16)
        }
    }
    
    private func addTag(tags: String) {
        self.tags.tintColor = UIColor.gray
        self.tags.font = Typography.h4
        self.tags.text = tags
        
        addSubview(self.tags)
        self.tags.snp.makeConstraints { make in
            make.left.equalTo(snp.left).offset(16)
            make.right.equalTo(snp.right).offset(-16)
            make.top.equalTo(self.image.snp.bottom).offset(10)
        }
    }

}
