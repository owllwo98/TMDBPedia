//
//  PosterCollectionViewCell.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/31/25.
//

import UIKit
import SnapKit
import Kingfisher

class PosterCollectionViewCell: BaseCollectionViewCell {
    static let id = "PosterCollectionViewCell"
    
    let posterImageView: UIImageView = UIImageView()
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        
    }
    
    func configureData(_ post: PosterDetail?) {
        guard let post else {
            return
        }
        
        let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(post.file_path)")
        posterImageView.kf.setImage(with: posterURL)
        
    }
}
