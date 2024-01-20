import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create view controllers
        
        // Set titles and images for tab bar items (optional)
        //        firstViewController.tabBarItem = UITabBarItem(title: "First", image: nil, tag: 0)
        //        secondViewController.tabBarItem = UITabBarItem(title: "Second", image: nil, tag: 1)
        
        // Set view controllers for the tab bar controlle
        setupTabs()
    }
    
    private func setupTabs() {
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

