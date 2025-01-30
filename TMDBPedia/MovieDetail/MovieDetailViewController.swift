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
    
    var images: Image?
    var backDropList: [BackdropDetail]?
    var posterList: [PosterDetail]?
    
    var releaseDate: UILabel = {
        let label = UILabel()
        
        return label
    }()
    var voteaverage: Int?
    
    lazy var backDropCollectionnView: UICollectionView = createHorizontalCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        requestData()
        
        
        self.navigationItem.title = result?.title
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: UserDefaultsManager.shared.like ? "heart.fill" : "heart"), style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .CustomBlue
        
        backDropCollectionnView.delegate = self
        backDropCollectionnView.dataSource = self
        backDropCollectionnView.register(BackdropCollectionViewCell.self, forCellWithReuseIdentifier: BackdropCollectionViewCell.id)
        
        configureHierarchy()
        configureLayout()
    }
    
    func configureHierarchy() {
        view.addSubview(backDropCollectionnView)
    }
    
    func configureLayout() {
        backDropCollectionnView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 3)
        }
    }
    
    private func createHorizontalCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        
        collectionView.isPagingEnabled = true
        return collectionView
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.id, for: indexPath) as! BackdropCollectionViewCell
                
        if let backDropList {
            cell.configureData(backDropList[indexPath.item])
        } else{
            
        }
        
        return cell
    }
}

extension MovieDetailViewController {
    func requestData() {
        print(#function)
        NetworkManager.shared.fetchData(api: .getMovieImages(movieId: result?.id ?? 1241982), T: Image.self) { [weak self] value in
            guard let self = self else {  return }
            backDropList = value.backdrops
            posterList = value.posters

            backDropCollectionnView.reloadData()
        } errorCompletion: { error in
            print(error)
        }
    }
}
