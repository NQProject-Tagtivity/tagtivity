//
//  ViewController.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 20/11/2020.
//

import UIKit
import SnapKit
import Tabman
import Pageboy

class ViewController: TabmanViewController, TMBarDataSource, PageboyViewControllerDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        let item = TMBarItem(title: "")
        item.image = UIImage(named: icons[index])

        return item
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLogin()
        loadViewController()
        setupPagingview()
    }
    
    // - Private ---------------------------------------------------------------------

    private let icons: [String] = ["columns", "search", "calendar_star", "user"]

    private var viewControllers: [UIViewController] = []
    
    private func setupPagingview() {
        dataSource = self

        let tabBar = TMBar.TabBar()
        let barView = UIView()
        barView.backgroundColor = .clear
        
        tabBar.backgroundView.style = .custom(view: barView)
        tabBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        tabBar.layout.transitionStyle = .none
        
        addBar(tabBar, dataSource: self, at: .bottom)
        
        tabBar.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom).offset(-30)
        }
    }
    
    private func loadViewController() {
        
        guard let myEvents = MyEventsViewController.loadFromStoryBoard() else { return }
        guard let dashboard = DashboardViewController.loadFromStoryBoard() else { return }
        guard let search = SearchViewController.loadFromStoryBoard() else { return }
        guard let profile = ProfileViewController.loadFromStoryBoard() else { return }
        
        viewControllers = [dashboard, search, myEvents, profile]
    }
    
    private func checkLogin() {
        UserDefaults.set(userName: "")
        guard let username = UserDefaults.userName, !username.isEmpty else {
            presentLogin()
            return
        }
    }
        
    private func presentLogin() {
        guard let vc = LoginViewController.loadFromStoryBoard() else { return }
        navigationController?.pushViewController(vc, animated: false)
    }
}
