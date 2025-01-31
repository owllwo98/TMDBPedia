//
//  MovieDetailViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/30/25.
//

import UIKit
import Alamofire
import SnapKit

class MovieDetailViewController: UIViewController {
    
    var result: Result?
    
    var movieTitle: String?
    var id: Int?
    var release_date: String?
    var vote_average: Double?
    
    var image: Image?
    var backDropList: [BackdropDetail] = []
    var posterList: [PosterDetail]?
    var cast: Credit?
    
    lazy var releaseDate: UILabel = {
        let label = UILabel()
        UILabel.addImageLabel(label, result?.release_date ?? "", "calendar")

        return label
    }()
    
    lazy var voteaverage: UILabel = {
        let label = UILabel()
        UILabel.addImageLabel(label, result?.vote_average.formatted() ?? "", "star.fill")
        
        return label
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
    
    let verticalScrollView: UIScrollView = UIScrollView()
    let contentView = UIView()
    
    lazy var backDropCollectionView: UICollectionView = createBackDropCollectionView()
    lazy var castCollectionView: UICollectionView = createCastCollectionView()
    lazy var posterCollectionView: UICollectionView = createPosterCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        requestData()
        
        self.navigationItem.title = result?.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UserDefaultsManager.shared.like ? "heart.fill" : "heart"), style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .CustomBlue
        
        configureHierarchy()
        configureLayout()
    }
    
    func configureHierarchy() {
        view.addSubview(verticalScrollView)
        verticalScrollView.addSubview(contentView)
        
        [backDropCollectionView, releaseDate, voteaverage, castLabel, castCollectionView, posterLabel, posterCollectionView].forEach {
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
            make.leading.equalToSuperview().inset(32)
        }
        
        voteaverage.snp.makeConstraints { make in
            make.top.equalTo(backDropCollectionView.snp.bottom).inset(-8)
            make.leading.equalTo(releaseDate.snp.trailing).inset(-8)
        }
        
        castLabel.snp.makeConstraints { make in
            make.top.equalTo(voteaverage.snp.bottom).inset(-8)
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
            return min(backDropList.count, 5)
        } else if collectionView == castCollectionView {
            return cast?.cast.count ?? 0
        } else {
            return posterList?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == backDropCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.id, for: indexPath) as! BackdropCollectionViewCell
            cell.configureData(backDropList[indexPath.item])
            return cell
        } else if collectionView == castCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CastCollectionViewCell.id, for: indexPath) as! CastCollectionViewCell
            if let cast {
                cell.configureData(cast.cast[indexPath.item])
            } else{
                
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
            if let posterList {
                cell.configureData(posterList[indexPath.item])
            } else{
                
            }
            return cell
        }
    }
}

extension MovieDetailViewController {
    func requestData() {
        NetworkManager.shared.fetchData(api: .getMovieImages(movieId: result?.id ?? 12345), T: Image.self) { [weak self] value in
            guard let self = self else { return }
            image = value
            backDropList = value.backdrops
            posterList = value.posters
            
            backDropCollectionView.reloadData()
            posterCollectionView.reloadData()
        } errorCompletion: { error in
            print(error)
        }
        
        NetworkManager.shared.fetchData(api: .getMovieCredits(movieId: result?.id ?? 12345), T: Credit.self) { [weak self] value in
            guard let self = self else { return }
            cast = value
            
            castCollectionView.reloadData()
        } errorCompletion: { error in
            print(error)
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
}
