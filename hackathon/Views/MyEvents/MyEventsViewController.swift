//
//  MyEventsViewController.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 20/11/2020.
//

import Foundation
import UIKit
import SnapKit

class MyEventsViewController: UIViewController {

    static func loadFromStoryBoard() -> MyEventsViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "MyEventsViewController") as? MyEventsViewController
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        guard let vc = EventViewController.loadFromStoryBoard() else { return }
        vc.event = events[tag]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NetworkRequests.shared.getEvents() { result in
            
            if !self.shouldReload { return }
            
            guard let events = result?.events else { return }
            let tmp = events.map { Event(title: $0.title, date: Date(timeIntervalSince1970: Double($0.startTime)), text: $0.description, image: $0.icon, tags: $0.tags, members: $0.members, eventId: $0.id, maxMembers: $0.maxMembers)}

            self.events = []
            
            guard let name = UserDefaults.userName else { return }
            
            for i in tmp {
                for j in i.members {
                    if j.username == name {
                        self.events.append(i)
                    }
                }
            }

            self.reload()
            self.shouldReload = true
        }
    }
    
    
    
    override func viewDidLoad() {
        print("[init] MyEventsViewController")
        
        setupView()
        
        NetworkRequests.shared.getEvents() { result in
            guard let events = result?.events else { return }
            let tmp = events.map { Event(title: $0.title, date: Date(timeIntervalSince1970: Double($0.startTime)), text: $0.description, image: $0.icon, tags: $0.tags, members: $0.members, eventId: $0.id, maxMembers: $0.maxMembers)}

            self.events = []
            guard let name = UserDefaults.userName else { return }
            for i in tmp {
                for j in i.members {
                    if j.username == name {
                        self.events.append(i)
                    }
                }
            }

            self.reload()

            self.shouldReload = true
        }
    }
    
    private let container: UIView = UIView()
    private let scrollView: UIScrollView = UIScrollView()
    private var lastAdded: [UIView] = []
    private let labelView = UIView()
    private var shouldReload = false
    private var events: [Event] = []
    
    private func reload() {
        
        lastAdded.forEach{$0.removeFromSuperview()}
        lastAdded = []
        
        for (idx, i) in events.enumerated() {
            appendLine()
            appendEvent(event: i, index: idx)
        }
        
        appendLine(last: true)
    }
    
    private func setupView() {
        appendLabel()
        setupScrollView()
    }
    
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
        
        label.text = "Moje wydarzenia"
        label.font = Font.Nunito.semiBold.with(size: 17)
        label.textColor = UIColor.white
        
        labelView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(labelView.snp.centerX)
            make.top.equalTo(labelView.snp.top).offset(50)
        }
    }
    
    private func setupScrollView() {
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        view.addSubview(scrollView)
        
        
        scrollView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
            make.top.equalTo(view.snp.top).offset(100)
            make.bottom.equalTo(view.snp.bottom).offset(-80)
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
    
    private func appendLine(last: Bool = false) {
        let view = UIView()
        view.backgroundColor = UIColor.app.lightGray
        
        container.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalTo(container.snp.left).offset(24)
            make.right.equalTo(container.snp.right).offset(-24)
            
            if let last = lastAdded.last {
                make.top.equalTo(last.snp.bottom).offset(16)
            } else {
                make.top.equalTo(container.snp.top).offset(16)
            }
            
            if last {
                make.bottom.equalTo(container.snp.bottom).offset(-16)
            }
        }
        
        lastAdded.append(view)
    }
    
    private func appendEvent(event: Event, index: Int) {
        
        let view = EventView()
        view.setup(event: event)
        container.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.left.equalTo(container.snp.left).offset(8)
            make.right.equalTo(container.snp.right).offset(-8)
            
            if let last = lastAdded.last {
                make.top.equalTo(last.snp.bottom).offset(16)
            }
        }
        
        lastAdded.append(view)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
        tap.view?.tag = index
    }
}

