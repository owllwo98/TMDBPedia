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
    lazy var mbtiViewModel = self.profileNicknameDetailView.viewModel
    
    var isNicknameAble = false
    var isMbtiAble = false
    
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
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileNicknameDetailView.profileButton.setImage(UIImage(named: UserDefaultsManager.shared.userProfileImage), for: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        profileNicknameDetailView.profileButton.layer.cornerRadius = profileNicknameDetailView.profileButton.frame.width / 2
    }
    
    func bindData() {
        viewModel.output.Text.bind { text in
            self.profileNicknameDetailView.statusLabel.text = text
        }
        
        viewModel.output.NickNameEnabled.bind { value in
            self.profileNicknameDetailView.statusLabel.textColor = value ? UIColor.customBlue100 : .red
            self.isNicknameAble = value
            
            self.profileNicknameDetailView.completionButton.backgroundColor = self.isNicknameAble && self.isMbtiAble ? UIColor.customBlue100 : .customGray100
            self.profileNicknameDetailView.completionButton.isEnabled = self.isNicknameAble && self.isMbtiAble
            
        }
        
//        mbtiViewModel.output.Button.lazyBind { selectedButtons in
//            print(selectedButtons)
//            let mbtiStack = self.profileNicknameDetailView.stacks
//            
//            for (groupTag, buttonTag) in selectedButtons {
//                let selectedTag = selectedButtons[groupTag]
//                
//                
//                mbtiStack[groupTag].arrangedSubviews.first?.backgroundColor = (buttonTag == mbtiStack[groupTag].arrangedSubviews.first?.tag) ? .customBlue100 : .clear
//                
//                mbtiStack[groupTag].arrangedSubviews.last?.backgroundColor = (buttonTag == mbtiStack[groupTag].arrangedSubviews.last?.tag) ? .customBlue100 : .clear
//
//                
//            }
//            
//        }
        
        let mbtiViewModels = [self.profileNicknameDetailView.energyViewModel, self.profileNicknameDetailView.mindViewModel, self.profileNicknameDetailView.natureViewModel, self.profileNicknameDetailView.tacticsViewModel]
        
        mbtiViewModels.forEach { viewModel in
            viewModel.output.MbtiEnabled.bind { _ in
                self.isMbtiAble = mbtiViewModels.allSatisfy { $0.output.MbtiEnabled.value == true }
                
                self.profileNicknameDetailView.completionButton.backgroundColor = self.isNicknameAble && self.isMbtiAble ? UIColor.customBlue100 : .customGray100
                
                self.profileNicknameDetailView.completionButton.isEnabled = self.isNicknameAble && self.isMbtiAble
            }
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
        viewModel.input.Text.value = profileNicknameDetailView.nicknameTextField.text
    }
}

