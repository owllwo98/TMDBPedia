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
    }
    
    @objc 
    func startButtonTapped() {
        let vc = ProfileNicknameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }



}
