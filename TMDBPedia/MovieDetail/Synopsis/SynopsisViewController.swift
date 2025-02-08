//
//  SynopsisViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/1/25.
//

import UIKit
import SnapKit

class SynopsisViewController: BaseView {

    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Synopsis"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("More", for: .normal)
        button.setTitleColor(.CustomBlue, for: .normal)
        
        return button
    }()
    
    override func configureHierarchy() {
        [sectionLabel, moreButton].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(sectionLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(8)
        }
    }
    
    override func configureView() {
        
    }
}
