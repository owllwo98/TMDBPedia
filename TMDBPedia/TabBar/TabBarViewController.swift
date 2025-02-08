//
//  TabBarViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/27/25.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBarController()
        setupTabBarAppearance()
        
    }
    
    func configureTabBarController() {
        let firstVC = MainViewController()
        firstVC.title = "CINEMA"
        firstVC.tabBarItem.image = UIImage(systemName: "popcorn")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "popcorn.fill")
        let firstNAV = UINavigationController(rootViewController: firstVC)
        
        let secondVC = SearchMovieViewController()
        secondVC.tabBarItem = UITabBarItem(title: "UPCOMING", image: UIImage(systemName: "film.stack"), selectedImage: UIImage(systemName: "film.stack.fill"))
        let secondNav = UINavigationController(rootViewController: secondVC)
        
        let thirdVC = SettingViewController()
        thirdVC.tabBarItem = UITabBarItem(title: "PROFILE", image: UIImage(systemName: "person.crop.circle"), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        setViewControllers([firstNAV, secondNav, thirdNav], animated: true)
    }
    
    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .black
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .CustomBlue
    }
    

}
