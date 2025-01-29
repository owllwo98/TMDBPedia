//
//  MainViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/27/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    private let topProfileViewController = TopProfileViewController()
    private let recentSearchView = RecentSearchView()
    private let todaysMovieView = TodaysMovieView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "TMDBPedia"
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
            make.bottom.equalToSuperview()
        }
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaysMovieCollectionViewCell.id, for: indexPath)
        cell.backgroundColor = .white
        
        return cell
    }
    
    
}
