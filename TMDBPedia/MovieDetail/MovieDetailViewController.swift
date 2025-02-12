//
//  MovieDetailViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/30/25.
//

import UIKit
import Alamofire
import SnapKit

final class MovieDetailViewController: UIViewController {
    
    let movieDetailViewModel = MovieDetailViewModel()

    
    lazy var releaseDate: UILabel = {
        let label = UILabel()
        UILabel.addImageLabel(label, movieDetailViewModel.output.result.value?.release_date ?? "", "calendar")

        return label
    }()
    
    lazy var voteaverage: UILabel = {
        let label = UILabel()
        UILabel.addImageLabel(label, movieDetailViewModel.output.result.value?.vote_average.formatted() ?? "", "star.fill")
        
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        
        if movieDetailViewModel.output.result.value?.genre_ids.count ?? 0 == 0 {
            UILabel.addImageLabel(label, "", "film.fill")
            return label
        } else if movieDetailViewModel.output.result.value?.genre_ids.count ?? 0 == 1 {
            let genre1 = Genre(rawValue: movieDetailViewModel.output.result.value?.genre_ids[0] ?? 0)?.name
            UILabel.addImageLabel(label, (genre1 ?? ""), "film.fill")
            return label
        } else {
            let genre1 = Genre(rawValue: movieDetailViewModel.output.result.value?.genre_ids[0] ?? 0)?.name
            let genre2 = Genre(rawValue: movieDetailViewModel.output.result.value?.genre_ids[1] ?? 0)?.name
    
            UILabel.addImageLabel(label, (genre1 ?? "") + "," + (genre2 ?? ""), "film.fill")
            return label
        }
    }()
    
    let castLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
    let posterLabel: UILabel = {
        let label = UILabel()
        label.text = "Poster"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        
        return label
    }()
    
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
    
    private lazy var Synopsis: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        
        return label
    }()
    
    private let backPage: UIPageControl = {
        let pc = UIPageControl()
        
        
        return pc
    }()
    
    let verticalScrollView: UIScrollView = UIScrollView()
    let contentView = UIView()
    
    lazy var backDropCollectionView: UICollectionView = createBackDropCollectionView()
    lazy var castCollectionView: UICollectionView = createCastCollectionView()
    lazy var posterCollectionView: UICollectionView = createPosterCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: #selector(likeButtonTapped))
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .CustomBlue
        
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        
        configureHierarchy()
        configureLayout()
        
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLikeButton()
    }
    
    func bindData() {
        movieDetailViewModel.output.result.bind { [weak self] value in
            guard let self = self else { return }
            Synopsis.text = value?.overview
            navigationItem.title = value?.title
            
        }
        
        movieDetailViewModel.output.movieImageData.bind { [weak self] value in
            guard let self = self else { return }
    
            backDropCollectionView.reloadData()
            posterCollectionView.reloadData()
            castCollectionView.reloadData()
        }
    }
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        movieDetailViewModel.input.likeButton.value = sender.tag
        updateLikeButton()
    }
    
    @objc
    func moreButtonTapped() {
        Synopsis.numberOfLines = 5
    }
    
    func configureHierarchy() {
        view.addSubview(verticalScrollView)
        verticalScrollView.addSubview(contentView)
        
        [backDropCollectionView, releaseDate, voteaverage, genreLabel, sectionLabel, moreButton, Synopsis, castLabel, castCollectionView, posterLabel, posterCollectionView].forEach {
            contentView.addSubview($0)
        }
        
        backDropCollectionView.delegate = self
        backDropCollectionView.dataSource = self
        backDropCollectionView.register(BackdropCollectionViewCell.self, forCellWithReuseIdentifier: BackdropCollectionViewCell.id)
        
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.register(CastCollectionViewCell.self, forCellWithReuseIdentifier: CastCollectionViewCell.id)
        
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        posterCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
    }
    
    func configureLayout() {
        
        verticalScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(verticalScrollView)
            make.width.equalTo(verticalScrollView.snp.width)
        }
        
        backDropCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 3)
        }
        
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(backDropCollectionView.snp.bottom).inset(-8)
            make.trailing.equalTo(voteaverage.snp.leading).inset(-8)
        }
        
        voteaverage.snp.makeConstraints { make in
            make.top.equalTo(backDropCollectionView.snp.bottom).inset(-8)
            make.centerX.equalToSuperview()
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(backDropCollectionView.snp.bottom).inset(-8)
            make.leading.equalTo(voteaverage.snp.trailing).inset(-8)
        }
        
        sectionLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDate.snp.bottom).inset(-8)
            make.leading.equalToSuperview().inset(8)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerY.equalTo(sectionLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(8)
        }
        
        Synopsis.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        castLabel.snp.makeConstraints { make in
            make.top.equalTo(Synopsis.snp.bottom).inset(-8)
            make.leading.equalToSuperview().inset(8)
        }
        
        castCollectionView.snp.makeConstraints { make in
            make.top.equalTo(castLabel.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 6)
        }
        
        posterLabel.snp.makeConstraints { make in
            make.top.equalTo(castCollectionView.snp.bottom).inset(-8)
            make.leading.equalToSuperview().inset(8)
        }
        
        posterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(posterLabel.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 3)
            make.bottom.equalToSuperview()
            
        }
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == backDropCollectionView {
            return min(movieDetailViewModel.output.movieImageData.value?.backdrops.count ?? 0, 5)
        } else if collectionView == castCollectionView {
            return movieDetailViewModel.output.creditData.value?.cast.count ?? 0
        } else {
            return movieDetailViewModel.output.movieImageData.value?.posters.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == backDropCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.id, for: indexPath) as! BackdropCollectionViewCell
            cell.configureData(movieDetailViewModel.output.movieImageData.value?.backdrops[indexPath.item])
            return cell
        } else if collectionView == castCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.id, for: indexPath) as! CastCollectionViewCell
            if let cast = movieDetailViewModel.output.creditData.value?.cast {
                cell.configureData(cast[indexPath.item])
            } else{
                
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
            if let posterList = movieDetailViewModel.output.movieImageData.value?.posters {
                cell.configureData(posterList[indexPath.item])
            } else{
                
            }
            return cell
        }
    }
}


extension MovieDetailViewController {
    
    private func createBackDropCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        
        collectionView.isPagingEnabled = true
        return collectionView
    }
    
    private func createCastCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 13)
        layout.minimumLineSpacing = 40
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        
        return collectionView
    }
    
    private func createPosterCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3.5, height: UIScreen.main.bounds.height / 3)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }
    
    private func updateLikeButton() {
        let movieId = movieDetailViewModel.output.result.value?.id ?? 0
        let heartImage = UIImage(systemName: UserDefaultsManager.shared.likedMovies[String(movieId)] == true ? "heart.fill" : "heart")
        self.navigationItem.rightBarButtonItem?.image = heartImage
    }
}
