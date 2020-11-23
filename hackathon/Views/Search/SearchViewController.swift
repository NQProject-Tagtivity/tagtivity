//
//  SearchViewController.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 20/11/2020.
//

import Foundation
import UIKit
import SnapKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var search: UILabel!
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        guard let vc = EventViewController.loadFromStoryBoard() else { return }
        vc.event = events[tag]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        
        guard let text = searchBar.text?.lowercased() else { return }
        
        NetworkRequests.shared.searchEvents(tags: text) { events in
            
            self.events = []
            
            if let events = events?.events {
                self.events = events.map { Event(title: $0.title, date: Date(timeIntervalSince1970: Double($0.startTime)), text: $0.description, image: $0.icon, tags: $0.tags, members: $0.members, eventId: $0.id, maxMembers: $0.maxMembers)}
            }
            
            self.reload()
        }
    }

    static func loadFromStoryBoard() -> SearchViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
  
    override func viewDidLoad() {
        setupView()
        
        NetworkRequests.shared.searchEvents(tags: "") { result in
            guard let events = result?.events else { return }
            self.events = events.map { Event(title: $0.title, date: Date(timeIntervalSince1970: Double($0.startTime)), text: $0.description, image: $0.icon, tags: $0.tags, members: $0.members, eventId: $0.id, maxMembers: $0.maxMembers)}
            self.reload()            
        }
    }
    
    private func reload() {
        
        lastAdded.forEach{$0.removeFromSuperview()}
        lastAdded = []
        
        for (idx, i) in events.enumerated() {
            appendLine()
            appendEvent(event: i, index: idx)
        }
        
        appendLine(last: true)
    }
    
    private let container: UIView = UIView()
    private let scrollView: UIScrollView = UIScrollView()
    private var lastAdded: [UIView] = []
    private let label = UILabel()
    private let labelView = UIView()
    private let searchBar = UISearchBar()
    private var events: [Event] = []

    private func setupView() {
        appendLabel()
        appendSearchBar()
        setupScrollView()
    }
    
    @objc func didPressSearchItem() {
    }
    
    private func appendSearchBar() {
        view.addSubview(searchBar)
                
        searchBar.barStyle = .default
        searchBar.backgroundColor = .clear
        searchBar.barTintColor = UIColor.app.yellow
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()

        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(labelView.snp.bottom)
            make.left.equalTo(view.snp.left).offset(16)
            make.right.equalTo(view.snp.right).offset(-80)
            make.height.equalTo(45)
        }
        
        let imageView = UIImageView()

        let tap = UITapGestureRecognizer(target: self, action: #selector(didPressSearchItem))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
        view.addSubview(imageView)

        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true

        imageView.image = Utils.resizeImage(image: UIImage(named: "calendar_yellow")!, targetSize: CGSize(width: 65, height: 65))

        imageView.snp.makeConstraints { make in
            make.width.equalTo(65)
            make.height.equalTo(65)
            make.right.equalTo(view.snp.right).offset(-20)
            make.centerY.equalTo(searchBar.snp.centerY)
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
        
        label.text = "Aktualne wydarzenia"
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
            make.top.equalTo(searchBar.snp.bottom).offset(16)
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
        view.backgroundColor = UIColor.app.darkGray
        
        container.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.equalTo(container.snp.left).offset(16)
            make.right.equalTo(container.snp.right).offset(-16)
            
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
            make.left.equalTo(container.snp.left).offset(16)
            make.right.equalTo(container.snp.right).offset(-16)
            
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

