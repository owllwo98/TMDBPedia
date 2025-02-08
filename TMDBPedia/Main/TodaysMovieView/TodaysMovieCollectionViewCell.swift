//
//  TodaysMovieCollectionViewCell.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/29/25.
//

import UIKit
import SnapKit
import Kingfisher

class TodaysMovieCollectionViewCell: BaseCollectionViewCell {
    static let id = "TodaysMovieCollectionViewCell"
    
    
    private let todayMovieImageView: UIImageView = UIImageView()
    private let movieTitleLabel: UILabel = UILabel()
    var likeButton: UIButton = UIButton()
    private let moviePlotLabel: UILabel = UILabel()
    
    override func configureHierarchy() {
        [todayMovieImageView, movieTitleLabel, likeButton, moviePlotLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        todayMovieImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(todayMovieImageView.snp.bottom).inset(-8)
            make.leading.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(todayMovieImageView.snp.bottom).inset(-8)
            make.trailing.equalToSuperview()
        }
        
        moviePlotLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        movieTitleLabel.font = .systemFont(ofSize: 12, weight: .bold)
        movieTitleLabel.textColor = .white
        
        moviePlotLabel.textColor = .white
        moviePlotLabel.numberOfLines = 2
        moviePlotLabel.font = .systemFont(ofSize: 8, weight: .bold)
        
        todayMovieImageView.layer.cornerRadius = 8
        todayMovieImageView.clipsToBounds = true
    }
    
    func configureData(_ list: Movie,_ indexPath: Int) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(list.results[indexPath].poster_path ?? "")")
        todayMovieImageView.kf.setImage(with: url)
        
        movieTitleLabel.text = list.results[indexPath].title
        moviePlotLabel.text = list.results[indexPath].overview == "" ? "영화 줄거리가 \n 없어요" : list.results[indexPath].overview

        let movieId = list.results[indexPath].id
        let likedMovies = UserDefaultsManager.shared.likedMovies
        let isLiked = likedMovies[String(movieId)] ?? false
        
        let buttonImage = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(buttonImage, for: .normal)
    }
}
