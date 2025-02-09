//
//  OnboardingViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/25/25.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {

    private var onboardingDetailView = OnboardingDetailView()
    
    override func loadView() {
        self.view = onboardingDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        onboardingDetailView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .CustomBlue
    }
    
    @objc 
    func startButtonTapped() {
        let vc = ProfileNicknameViewController()
        UserDefaultsManager.shared.userProfileImage = "profile_\(Int.random(in: 0...11))"
        navigationController?.pushViewController(vc, animated: true)
    }



}
