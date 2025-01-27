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

    }
    
    func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }
    

}
