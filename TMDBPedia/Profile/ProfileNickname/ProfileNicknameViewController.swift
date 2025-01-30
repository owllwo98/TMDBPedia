//
//  ProfileNicknameViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/25/25.
//

import UIKit

class ProfileNicknameViewController: UIViewController {

    private var profileNicknameDetailView = ProfileNicknameDetailView()
    
    
    override func loadView() {
        self.view = profileNicknameDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "프로필 설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .CustomBlue
        
        profileNicknameDetailView.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        profileNicknameDetailView.completionButton.addTarget(self, action: #selector(completionButtonTapped), for: .touchUpInside)
      
    }
    
    override func viewDidLayoutSubviews() {
        profileNicknameDetailView.profileButton.layer.cornerRadius = profileNicknameDetailView.profileButton.frame.width / 2
    }
    
    @objc
    func completionButtonTapped() {
        UserDefaultsManager.shared.isStart = true
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let tabBarVC = TabBarViewController() 
        window.rootViewController = tabBarVC
        window.makeKeyAndVisible()
    }
    
    @objc
    func profileButtonTapped() {
        let vc = ProfileImageViewController()
        vc.profileImageDetailView.selectedProfileButton.setImage(profileNicknameDetailView.profileButton.image(for: .normal), for: .normal)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    

    

}
