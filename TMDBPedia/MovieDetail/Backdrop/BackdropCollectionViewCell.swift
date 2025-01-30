//
//  BackdropCollectionViewCell.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/30/25.
//

import UIKit
import SnapKit
import Kingfisher

final class BackdropCollectionViewCell: BaseCollectionViewCell {
    static let id = "BackdropCollectionViewCell"
    
    let backDropImage: UIImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(backDropImage)
    }
    
    override func configureLayout() {
        backDropImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        
    }
    
    func configureData(_ back: BackdropDetail) {
        let backUrl = URL(string: "https://image.tmdb.org/t/p/w500\(back.file_path)")
        backDropImage.kf.setImage(with: backUrl)
    }
}
