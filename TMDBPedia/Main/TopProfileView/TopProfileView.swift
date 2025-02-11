//
//  TopProfileViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/28/25.
//

import UIKit
import SnapKit

final class TopProfileView: BaseView {
    
    lazy var profileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.isUserInteractionEnabled = true
        
        return button
    }()
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.CustomBlue?.cgColor
        image.image = UIImage(named: UserDefaultsManager.shared.userProfileImage)
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        
        return image
    }()
    
    let profileNickname: UILabel = {
        let label = UILabel()
        label.text = UserDefaultsManager.shared.userNickName
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
        
    }()
    
    private let registrationDate: UILabel = {
        let label = UILabel()
        label.text = UserDefaultsManager.shared.userDate
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
        label.text = "\(UserDefaultsManager.shared.likedMovies.count)개의 무비박스 보관중"
        label.textColor = .white
        label.backgroundColor = .CustomBlue
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        
        return label
    }()
    
    
    override func configureHierarchy() {
        addSubview(profileButton)
        [profileImage, profileNickname, registrationDate, rightButtonImage, likeMoviewLabel].forEach {
            profileButton.addSubview($0)
            $0.isUserInteractionEnabled = false
        }
    }
    
    override func configureLayout() {
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(8)
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
    
    override func configureView() {
        
    }

}
