//
//  ProfileImageCollectionViewCell.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/25/25.
//

import UIKit
import SnapKit


class ProfileImageCollectionViewCell: BaseCollectionViewCell {
    static let id = "ProfileImageCollectionViewCell"
    
    var itemImageView: UIImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(itemImageView)
    }
    
    override func configureView() {
        itemImageView.clipsToBounds = true
        DispatchQueue.main.async {
            self.itemImageView.layer.cornerRadius = self.itemImageView.frame.width / 2
        }
        itemImageView.layer.borderWidth = 2
        itemImageView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    override func configureLayout() {
        itemImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureData() {
        
    }

}
