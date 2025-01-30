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
        firstVC.tabBarItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis.circle")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")
        let firstNAV = UINavigationController(rootViewController: firstVC)
        
        let secondVC = SearchMovieViewController()
        secondVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "play.square.stack"), selectedImage: UIImage(systemName: "play.square.stack.fill"))
        let secondNav = UINavigationController(rootViewController: secondVC)
        
        let thirdVC = SettingViewController()
        thirdVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
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
