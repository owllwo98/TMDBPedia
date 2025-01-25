//
//  OnboardingDetailView.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/25/25.
//

import UIKit
import SnapKit


final class OnboardingDetailView: BaseView {
    
    private let onBoardingImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Onboarding"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "당신만의 영화 세상,\n TMDMPedia를 시작해보세요."
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.customBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.CustomBlue?.cgColor
        
        return button
    }()
    
    override func configureHierarchy() {
        [onBoardingImageView, titleLabel, subTitleLabel, startButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureView() {
        backgroundColor = .black
        
        onBoardingImageView.image = UIImage(named: "onboarding")
    }
    
    override func configureLayout() {
        onBoardingImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(64)
            make.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(onBoardingImageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-32)
            make.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).inset(-32)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
