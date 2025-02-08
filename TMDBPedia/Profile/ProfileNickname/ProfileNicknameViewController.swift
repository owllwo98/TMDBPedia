//
//  ProfileNicknameViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/25/25.
//

import UIKit

class ProfileNicknameViewController: UIViewController {

    private var profileNicknameDetailView = ProfileNicknameDetailView()
    
    let viewModel = ProfileNicknameViewModel()
    
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
        
        profileNicknameDetailView.nicknameTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        
        bindData()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileNicknameDetailView.profileButton.setImage(UIImage(named: UserDefaultsManager.shared.userProfileImage), for: .normal)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        UserDefaultsManager.shared.userProfileImage = "profile_\(Int.random(in: 0...11))"
    }
    
    override func viewDidLayoutSubviews() {
        profileNicknameDetailView.profileButton.layer.cornerRadius = profileNicknameDetailView.profileButton.frame.width / 2
    }
    
    func bindData() {
        viewModel.outputText.bind { text in
            self.profileNicknameDetailView.statusLabel.text = text
        }
        
        viewModel.outputButtonTrigger.bind { value in
            self.profileNicknameDetailView.statusLabel.textColor = value ? .customBlue : .red
            self.profileNicknameDetailView.completionButton.backgroundColor = value ? .customBlue : .customGray100
            self.profileNicknameDetailView.completionButton.isEnabled = value
        }
    }
    
    @objc
    func completionButtonTapped() {
        guard let nickname = profileNicknameDetailView.nicknameTextField.text else {
            return
        }
        UserDefaultsManager.shared.isStart = true
        UserDefaultsManager.shared.userNickName = nickname
        UserDefaultsManager.shared.userDate = Date().toDateDayString()
        
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
    
    @objc
    func textFieldDidChanged() {
        viewModel.inputText.value = profileNicknameDetailView.nicknameTextField.text
    }
}

