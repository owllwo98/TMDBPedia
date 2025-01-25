//
//  ProfileNicknameDetailView.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/25/25.
//

import UIKit
import SnapKit

final class ProfileNicknameDetailView : BaseView {
    
    lazy var profileButton: UIButton = {
        let button = UIButton()
        
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.CustomBlue?.cgColor
        button.setImage(UIImage(named: "profile_\(Int.random(in: 0...11))"), for: .normal)
        button.clipsToBounds = true
    
        return button
    }()
    
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = .white
        textField.tintColor = .white
        
        return textField
    }()
    
    let underLine: UIView = UIView()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .CustomBlue
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.text = "닉네임에 숫자는 포함할 수 없어요"
        
        return label
    }()
    
    let completionButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.customBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.CustomBlue?.cgColor
        
        return button
    }()
    
    override func configureHierarchy() {
        [profileButton, nicknameTextField, underLine, statusLabel, completionButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureView() {
        backgroundColor = .black
        
        underLine.backgroundColor = .white
        
    }
    
    override func configureLayout() {
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(80)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom).inset(-32)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        underLine.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).inset(-1)
            make.horizontalEdges.equalTo(nicknameTextField)
            make.height.equalTo(1)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(underLine.snp.bottom).inset(-8)
            make.leading.equalToSuperview().inset(8)
        }
        
        completionButton.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
    }
}
