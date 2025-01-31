//
//  SearchMovieCollectionViewCell.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/31/25.
//

import UIKit
import SnapKit
import Kingfisher

class SearchMovieCollectionViewCell: BaseCollectionViewCell {
    static let id = "SearchMovieCollectionViewCell"
    
    let posterImageView: UIImageView = UIImageView()
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    let releaseDate: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UserDefaultsManager.shared.like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(title)
        contentView.addSubview(releaseDate)
        contentView.addSubview(likeButton)
        contentView.addSubview(separatorView)
    }
    
    override func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(4)
            make.leading.equalToSuperview()
            make.width.equalTo(90)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(5)
            make.leading.equalTo(posterImageView.snp.trailing).inset(-8)
        }
        
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).inset(-4)
            make.leading.equalTo(posterImageView.snp.trailing).inset(-8)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(4)
            make.trailing.equalToSuperview().inset(12)
        }
        
        separatorView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(1)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    override func configureView() {
        posterImageView.contentMode = .scaleAspectFit
    
    }
    
    func configureData(_ search: Result) {
        let URL = URL(string: "https://image.tmdb.org/t/p/w500\(search.poster_path ?? "")")
        posterImageView.kf.setImage(with: URL)
        
        title.text = search.title
        releaseDate.text = search.release_date
    }
}
