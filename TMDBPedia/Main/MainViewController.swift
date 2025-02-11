//
//  MainViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/27/25.
//

import UIKit
import SnapKit

protocol searchDelegate {
    func searchReceived(value: String)
}

final class MainViewController: UIViewController {
    
    private let topProfileView = TopProfileView()
    private let recentSearchView = RecentSearchView()
    private let todaysMovieView = TodaysMovieView()
    
    let recentSearchViewModel = RecentSearchViewModel()
    let todaysMovieViewModel = TodaysMovieViewModel()
    
    override func loadView() {
        self.view = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "오늘의 영화"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .CustomBlue
        
        view.backgroundColor = .black
        
        configureHierarchy()
        configureLayout()
        
        
        topProfileView.profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        recentSearchView.deleteButton.addTarget(self, action: #selector(deleteAllButtonTapped), for: .touchUpInside)
        
        bindData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if recentSearchViewModel.output.searchList.value.isEmpty {
            recentSearchView.emptyLabel.isHidden = false
            recentSearchView.collectionView.isHidden = true
        } else {
            recentSearchView.emptyLabel.isHidden = true
            recentSearchView.collectionView.isHidden = false
        }
        
        
        topProfileView.likeMoviewLabel.text = "\(UserDefaultsManager.shared.likedMovies.count)개의 무비박스 보관중"
        recentSearchView.collectionView.reloadData()
        todaysMovieView.collectionView.reloadData()
    }
    
    func bindData() {
        recentSearchViewModel.output.searchList.bind { [weak self] value in
            guard let self = self else { return }
            
            if recentSearchViewModel.output.searchList.value.isEmpty {
                recentSearchView.emptyLabel.isHidden = false
                recentSearchView.collectionView.isHidden = true
            } else {
                recentSearchView.emptyLabel.isHidden = true
                recentSearchView.collectionView.isHidden = false
            }
            
            recentSearchView.collectionView.reloadData()
        }
        
        todaysMovieViewModel.output.movieData.bind { [weak self] value in
            guard let self = self else { return }
            todaysMovieView.collectionView.reloadData()
        }
        
        todaysMovieViewModel.output.likeButton.bind { [weak self] _ in
            guard let self = self else { return }
            topProfileView.likeMoviewLabel.text = "\(UserDefaultsManager.shared.likedMovies.count)개의 무비박스 보관중"
            todaysMovieView.collectionView.reloadData()
        }
        
    }
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        todaysMovieViewModel.input.likeButton.value = sender.tag
    }
    
    @objc
    func deleteButtonTapped(_ sender: UIButton) {
        recentSearchViewModel.input.searchListTag.value = sender.tag
    }
    
    @objc
    func rightBarButtonItemTapped() {
        let vc = SearchMovieViewController()
        vc.contents = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func profileButtonTapped() {
        let vc = ProfileNicknameViewController()
        let navVC = UINavigationController(rootViewController: vc)
        
        present(navVC, animated: true)
    }
    
    @objc
    func deleteAllButtonTapped() {
        recentSearchViewModel.input.removeAll.value = ()
    }
    
    func configureHierarchy() {
        view.addSubview(topProfileView)
        view.addSubview(recentSearchView)
        view.addSubview(todaysMovieView)
        
        recentSearchView.collectionView.delegate = self
        recentSearchView.collectionView.dataSource = self
        recentSearchView.collectionView.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.id)
        
        todaysMovieView.collectionView.delegate = self
        todaysMovieView.collectionView.dataSource = self
        todaysMovieView.collectionView.register(TodaysMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodaysMovieCollectionViewCell.id)
    }
    
    func configureLayout() {
        topProfileView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(topProfileView.profileButton)
        }
        
        recentSearchView.snp.makeConstraints { make in
            make.top.equalTo(topProfileView.profileButton.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(80)
        }
        
        recentSearchView.collectionView.snp.makeConstraints { make in
            make.height.equalTo(30)
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
    
    func configureView() {
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recentSearchView.collectionView {
            return recentSearchViewModel.output.searchList.value.count
        } else {
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == recentSearchView.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.id, for: indexPath) as! RecentSearchCollectionViewCell
            cell.configureData(recentSearchViewModel.output.searchList.value[indexPath.item])
            cell.deleteKeywordButton.tag = indexPath.item
            cell.deleteKeywordButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaysMovieCollectionViewCell.id, for: indexPath) as! TodaysMovieCollectionViewCell
            cell.backgroundColor = .black
            
            if let movieList = todaysMovieViewModel.output.movieData.value {
                cell.configureData(movieList, indexPath.item)
                cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
                cell.likeButton.tag = indexPath.item
            } else {
                
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == recentSearchView.collectionView {
            return CGSize(width: 60, height: 30)
        } else {
            return CGSize(width: UIScreen.main.bounds.width / 2 - 2, height: collectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        if collectionView == recentSearchView.collectionView {
            let vc = SearchMovieViewController()
            vc.searchMovieViewModel.input.query.value = recentSearchViewModel.output.searchList.value[indexPath.item]
            vc.searchBar.text = recentSearchViewModel.output.searchList.value[indexPath.item]
            
            navigationController?.pushViewController(vc, animated: true)
            
        }  else if collectionView == todaysMovieView.collectionView {
            let vc = MovieDetailViewController()
            vc.result = todaysMovieViewModel.output.movieData.value?.results[indexPath.item]
            vc.movieTitle = todaysMovieViewModel.output.movieData.value?.results[indexPath.item].title
            vc.id = todaysMovieViewModel.output.movieData.value?.results[indexPath.item].id
            vc.vote_average = todaysMovieViewModel.output.movieData.value?.results[indexPath.item].vote_average
            vc.release_date = todaysMovieViewModel.output.movieData.value?.results[indexPath.item].release_date
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MainViewController: searchDelegate {
    func searchReceived(value: String) {
        recentSearchViewModel.input.searchList.value = value
        print(#function)
    }
}


