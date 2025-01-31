//
//  CastCollectionViewCell.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/31/25.
//

import UIKit
import SnapKit
import Kingfisher

class CastCollectionViewCell: BaseCollectionViewCell {
    static let id = "CastCollectionViewCell"
    
    let castImage: UIImageView = UIImageView()
    
    let name: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    let originalName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .gray
        
        return label
    }()
    
    override func configureHierarchy() {
        [castImage, name, originalName].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        castImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.size.equalTo(contentView.snp.height)
        }
        
        name.snp.makeConstraints { make in
            make.bottom.equalTo(castImage.snp.centerY).inset(4)
            make.leading.equalTo(castImage.snp.trailing).inset(-8)
        }
        
        originalName.snp.makeConstraints { make in
            make.top.equalTo(castImage.snp.centerY).inset(-4)
            make.leading.equalTo(castImage.snp.trailing).inset(-8)
        }
    }
    
    override func configureView() {
        DispatchQueue.main.async {
            self.castImage.layer.cornerRadius = self.castImage.frame.width / 2
            self.castImage.clipsToBounds = true
        }
    }
    
    func configureData(_ cast: castDetail) {
        let castURL = URL(string: "https://image.tmdb.org/t/p/w500\(cast.profile_path ?? "star")")
        castImage.kf.setImage(with: castURL)
        
        name.text = cast.name
        originalName.text = cast.original_name
    }
}
