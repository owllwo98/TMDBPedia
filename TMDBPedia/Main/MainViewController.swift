//
//  MainViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/27/25.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "TMDBPedia"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .CustomBlue
    }
    

    

}
