//
//  DashboardViewController.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 20/11/2020.
//

import Foundation
import UIKit
import SnapKit
import SwiftDate
class DashboardViewController: UIViewController {
    
    static func loadFromStoryBoard() -> DashboardViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController
    }
    
    @objc func didPressAddButton() {
        print("didPressAddButton")
        guard let vc = AddEventViewController.loadFromStoryBoard() else { return }
        
        navigationController?.pushViewController(vc, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if shouldReload {
            NetworkRequests.shared.getEvents() { result in
                guard let events = result?.events else { return }
                self.events = events.map { Event(title: $0.title, date: Date(timeIntervalSince1970: Double($0.startTime)), text: $0.description, image: $0.icon, tags: $0.tags, members: $0.members, eventId: $0.id, maxMembers: $0.maxMembers)}
                self.reload()
                
                self.shouldReload = true
            }
        }
    }

    override func viewDidLoad() {
        
        print("[init] DashboardViewController")
        
        appendLabel()

        createView()
        
        appendAddButton()
        
        NetworkRequests.shared.getEvents() { result in
            guard let events = result?.events else { return }
            self.events = events.map { Event(title: $0.title, date: Date(timeIntervalSince1970: Double($0.startTime)), text: $0.description, image: $0.icon, tags: $0.tags, members: $0.members, eventId: $0.id, maxMembers: $0.maxMembers)}
            self.reload()
            
            self.shouldReload = true
        }
    }
    
    private var events: [Event] = []
    private let container: UIView = UIView()
    private let scrollView: UIScrollView = UIScrollView()
    private var lastAdded: [UIView] = []
    private let button = UIButton()
    private let labelView = UIView()
    private var shouldReload = false
    
    private func reload() {

        if events.isEmpty { return }
        
        lastAdded.forEach { $0.removeFromSuperview() }
        lastAdded = []
        
        let nearestEventView = NearestEventView()
        nearestEventView.setup(event: events[0 % events.count])
        appendComponent(view: nearestEventView, size: 160, index: 0)
        
        let notMarkedCell = NotMarkedCell()
        notMarkedCell.setup(event: events[1 % events.count])
        appendComponent(view: notMarkedCell, size: 210, index: 1)
        
        let lookEventView = LookEventView()
        lookEventView.setup(event: events[2 % events.count])
        appendComponent(view: lookEventView, size: 220, index: 2, last: true)

    }
    
    private func createView() {
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        view.addSubview(scrollView)
        
        
        scrollView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
            make.top.equalTo(labelView.snp.bottom).offset(0)
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
        
        label.text = "Jaki plan na dzisiaj?"
        label.font = Font.Nunito.semiBold.with(size: 17)
        label.textColor = .white
        
        labelView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(labelView.snp.centerX)
            make.top.equalTo(labelView.snp.top).offset(50)
        }
    }
    
    private func appendAddButton() {
        button.setTitle("+  DODAJ NOWE WYDARZENIE", for: .normal)
        button.backgroundColor = UIColor.app.yellow
        button.titleLabel?.font = Font.Nunito.bold.with(size: 13)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        button.contentEdgeInsets.left = 15
        button.contentEdgeInsets.top = 15
        button.contentEdgeInsets.bottom = 15
        button.contentEdgeInsets.right = 15
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(didPressAddButton), for: .touchUpInside)

        container.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.left.equalTo(container.snp.left).offset(16)
            make.right.equalTo(container.snp.right).offset(-16)
            make.top.equalTo(container.snp.top).offset(32)
        }
        
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        button.layer.shadowColor = UIColor.app.darkGray.cgColor
        button.layer.shadowRadius = 6.0
        button.layer.shadowOpacity = 0.5
    }
    
    private func appendComponent(view: UIView, size: Int, index: Int, last: Bool = false) {
        
        container.addSubview(view)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.backgroundColor = .white

        view.snp.makeConstraints { make in
            
            make.height.equalTo(size)
            if let last = lastAdded.last {
                make.top.equalTo(last.snp.bottom).offset(16)
            } else {
                make.top.equalTo(button.snp.bottom).offset(16)
            }
            
            make.left.equalTo(container.snp.left).offset(16)
            make.right.equalTo(container.snp.right).offset(-16)
            
            if last {
                make.bottom.equalTo(container.snp.bottom).offset(-16)
            }
        }
        
        lastAdded.append(view)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
        tap.view?.tag = index
        
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        view.layer.shadowColor = UIColor.app.darkGray.cgColor
        view.layer.shadowRadius = 6.0
        view.layer.shadowOpacity = 0.5

        let backgroundCGColor = view.backgroundColor?.cgColor
        view.backgroundColor = nil
        view.layer.backgroundColor = backgroundCGColor

    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        guard let vc = EventViewController.loadFromStoryBoard() else { return }
        vc.event = events[tag % events.count]
        navigationController?.pushViewController(vc, animated: true)
    }
}
