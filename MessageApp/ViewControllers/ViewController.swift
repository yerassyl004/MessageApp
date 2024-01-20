//
//  ViewController.swift
//  MessageApp
//
//  Created by Ерасыл Еркин on 15.01.2024.
//

import UIKit
import FirebaseAuth

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        } else {
            setupTabs()
        }
    }
    
    private func setupTabs() {
        print("git push")
        let news = createTab(with: "Popular", image: UIImage(systemName: "newspaper.fill"), vc: HomeViewController())
        let explore = createTab(with: "Search", image: UIImage(systemName: "magnifyingglass"), vc: SecondViewController())
        
        viewControllers = [news, explore]
    }
    
    private func createTab(with title: String, image: UIImage?, vc: UIViewController) -> UIViewController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}

