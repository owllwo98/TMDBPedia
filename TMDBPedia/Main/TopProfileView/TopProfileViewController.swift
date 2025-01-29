//
//  TopProfileViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/28/25.
//

import UIKit
import SnapKit

class TopProfileViewController: BaseView {
    
    let profileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        
        return button
    }()
    
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = image.frame.width / 2
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.CustomBlue?.cgColor
        image.image = UIImage(named: "profile_0")
        
        return image
    }()
    
    private let profileNickname: UILabel = {
        let label = UILabel()
        label.text = "달콤한 기모청바지"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        
        return label
        
    }()
    
    private let registrationDate: UILabel = {
        let label = UILabel()
        label.text = "25.01.24 가입"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 8, weight: .semibold)
        
        return label
    }()
    
    private let rightButtonImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .lightGray
        
        return image
    }()
    
    override func configureHierarchy() {
        addSubview(profileButton)
        [profileImage, profileNickname, registrationDate, rightButtonImage].forEach {
            profileButton.addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.size.equalTo(80)
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
    }
    
    override func configureView() {
        
    }

 

}
