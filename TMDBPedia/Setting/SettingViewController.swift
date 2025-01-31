//
//  SettingViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/30/25.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {

    lazy var profileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.CustomBlue?.cgColor
        image.image = UIImage(named: "profile_0")
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        
        return image
    }()
    
    private let profileNickname: UILabel = {
        let label = UILabel()
        label.text = "달콤한 기모청바지"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
        
    }()
    
    private let registrationDate: UILabel = {
        let label = UILabel()
        label.text = "25.01.24 가입"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    private let rightButtonImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .lightGray
        
        return image
    }()
    
    let likeMoviewLabel: UILabel = {
        let label = UILabel()
        label.text = "0개의 무비박스 보관중"
        label.textColor = .white
        label.backgroundColor = .CustomBlue
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "프로필 설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .CustomBlue
        
        configureHierarchy()
        configureLayout()
    }
    
    func configureHierarchy() {
        view.addSubview(profileButton)
        [profileImage, profileNickname, registrationDate, rightButtonImage, likeMoviewLabel].forEach {
            profileButton.addSubview($0)
        }
    }
    
    func configureLayout() {
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.size.equalTo(50)
        }
        
        profileNickname.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalTo(profileImage.snp.trailing).inset(-8)
        }
        
        registrationDate.snp.makeConstraints { make in
            make.top.equalTo(profileNickname.snp.bottom).inset(-4)
            make.leading.equalTo(profileImage.snp.trailing).inset(-8)
        }
        
        rightButtonImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(profileImage.snp.centerY)
        }
        
        likeMoviewLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
    }
}

//extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//    
//    
//}
