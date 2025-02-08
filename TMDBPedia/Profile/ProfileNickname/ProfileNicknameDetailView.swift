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
        button.setImage(UIImage(named: UserDefaultsManager.shared.userProfileImage), for: .normal)
        button.clipsToBounds = true
        
        return button
    }()
    
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = .white
        textField.tintColor = .white
        textField.text = UserDefaultsManager.shared.userNickName
        textField.placeholder = "닉네임을 입력해주세요"
        textField.setPlaceholder(color: .customGray200)
        textField.font = .systemFont(ofSize: 12, weight: .bold)
        
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
    
    let MbtiLabel: UILabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    let completionButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        
        return button
    }()
    
    lazy var stackView = createRadioButton(firstText: "E", secondText: "I")
    
    override func configureHierarchy() {
        [profileButton, nicknameTextField, underLine, statusLabel, MbtiLabel, completionButton].forEach {
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
            make.top.equalTo(nicknameTextField.snp.bottom).inset(-8)
            make.horizontalEdges.equalTo(nicknameTextField)
            make.height.equalTo(1)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(underLine.snp.bottom).inset(-8)
            make.leading.equalToSuperview().inset(8)
        }
        
        MbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).inset(-16)
            make.leading.equalToSuperview().inset(8)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).inset(-16)
            make.leading.equalTo(MbtiLabel.snp.trailing).inset(-16)
        }
        
        completionButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).inset(-16)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
    }
    
    func createRadioButton(firstText: String, secondText: String) -> UIStackView {
        lazy var firstButton: UIButton = {
            let button = UIButton()
            button.setTitle(firstText, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 20
            button.layer.borderColor = UIColor.customGray100.cgColor
            button.layer.borderWidth = 1
            button.clipsToBounds = true
            
            return button
        }()
        
        lazy var secondButton: UIButton = {
            let button = UIButton()
            button.setTitle(secondText, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 20
            button.layer.borderColor = UIColor.customGray100.cgColor
            button.layer.borderWidth = 1
            button.clipsToBounds = true
            
            return button
        }()
        
        let stack : UIStackView = {
            let stack = UIStackView(arrangedSubviews: [firstButton, secondButton])
            stack.axis = .vertical
            stack.spacing = 4
            
            return stack
        }()
        
        addSubview(stack)
                
        firstButton.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        secondButton.snp.makeConstraints { make in
            make.size.equalTo(40)
        }
        
        return stack
    }
}
