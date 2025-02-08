//
//  RecentSearchCollectionViewCell.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/1/25.
//

import UIKit
import SnapKit

class RecentSearchCollectionViewCell: BaseCollectionViewCell {
    static let id = "RecentSearchCollectionViewCell"
    
    let keywordLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    let deleteKeywordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        
        return button
    }()

    override func configureHierarchy() {
        contentView.addSubview(keywordLabel)
        contentView.addSubview(deleteKeywordButton)
    }
    
    override func configureLayout() {
        keywordLabel.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(2)
            make.width.equalTo(40)
        }
        
        deleteKeywordButton.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview().inset(2)
        }
    }
    
    override func configureView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        clipsToBounds = true
        
        keywordLabel.isUserInteractionEnabled = true
    }
    
    func configureData(_ keyword: String) {
        keywordLabel.text = keyword
    }
}
