//
//  MainViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/27/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private var topProfileViewController = TopProfileViewController()
    private var recentSearchView = RecentSearchView()
    private var todaysMovieView = TodaysMovieView()
    
    private var movieList: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()
        
        self.navigationItem.title = "오늘의 영화"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .CustomBlue
        
        view.backgroundColor = .black
        
        todaysMovieView.collectionView.delegate = self
        todaysMovieView.collectionView.dataSource = self
        todaysMovieView.collectionView.register(TodaysMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodaysMovieCollectionViewCell.id)
        
        
        composingView()
    }
    
    
    @objc
    func likeButtonTapped() {
        print(#function)
        UserDefaultsManager.shared.like.toggle()
        todaysMovieView.collectionView.reloadData()
    }
    
    func composingView() {
        view.addSubview(topProfileViewController)
        view.addSubview(recentSearchView)
        view.addSubview(todaysMovieView)
        
        topProfileViewController.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        recentSearchView.snp.makeConstraints { make in
            make.top.equalTo(topProfileViewController.profileButton.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
        
        todaysMovieView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchView.baseView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        todaysMovieView.collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
        }
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaysMovieCollectionViewCell.id, for: indexPath) as! TodaysMovieCollectionViewCell
        cell.backgroundColor = .black

        if let movieList {
            cell.configureData(movieList, indexPath.item)
        } else {
            
        }
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 2, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.result = movieList?.results[indexPath.item]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController {
    func requestData() {
        print(#function)
        NetworkManager.shared.fetchData(api: .getTrending(page: 1), T: Movie.self) { [weak self] value in
            guard let self = self else {  return }
            movieList = value
            todaysMovieView.collectionView.reloadData()
        } errorCompletion: { error in
            print(error)
        }
    }
}
