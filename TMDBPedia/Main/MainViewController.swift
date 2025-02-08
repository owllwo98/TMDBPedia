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
    
    private var movieList: Movie?
    
    var searchList: [String] = []
    
    override func loadView() {
        self.view = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()
        
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
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if searchList.isEmpty {
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
    
    // MARK: 뭔가 계속 중복되는 코드여서 프로토콜을 통해 줄일 수 있지 않을까 생각했는데 마무리 짓지는 못했습니다.
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        let movieId = movieList?.results[sender.tag].id ?? 0
        var likedMovies = UserDefaultsManager.shared.likedMovies
        
        if let currentLikeStatus = likedMovies[String(movieId)] {
            if currentLikeStatus {
                likedMovies[String(movieId)] = nil
            } else {
                likedMovies[String(movieId)] = true
            }
        } else {
            likedMovies[String(movieId)] = true
        }
        
        UserDefaultsManager.shared.likedMovies = likedMovies
        
        topProfileView.likeMoviewLabel.text = "\(UserDefaultsManager.shared.likedMovies.count)개의 무비박스 보관중"
        todaysMovieView.collectionView.reloadData()
    }
    
    @objc
    func deleteButtonTapped(_ sender: UIButton) {
        searchList.remove(at: sender.tag)
        recentSearchView.collectionView.reloadData()
    }
    
    @objc
    func rightBarButtonItemTapped() {
        let vc = SearchMovieViewController()
        vc.contents = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func profileButtonTapped() {
        print(#function)
        let vc = ProfileNicknameViewController()
        let navVC = UINavigationController(rootViewController: vc)
        
        present(navVC, animated: true)
    }
    
    @objc
    func deleteAllButtonTapped() {
        searchList.removeAll()
        
        recentSearchView.emptyLabel.isHidden = false
        recentSearchView.collectionView.isHidden = true
        recentSearchView.collectionView.reloadData()
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
            return searchList.count
        } else {
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == recentSearchView.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.id, for: indexPath) as! RecentSearchCollectionViewCell
            cell.configureData(searchList[indexPath.item])
            cell.deleteKeywordButton.tag = indexPath.item
            cell.deleteKeywordButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodaysMovieCollectionViewCell.id, for: indexPath) as! TodaysMovieCollectionViewCell
            cell.backgroundColor = .black

            if let movieList {
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
            vc.query = searchList[indexPath.item]
            vc.searchBar.text = searchList[indexPath.item]
            vc.requestData()
            
            navigationController?.pushViewController(vc, animated: true)
            
        }  else if collectionView == todaysMovieView.collectionView {
            let vc = MovieDetailViewController()
            vc.result = movieList?.results[indexPath.item]
            
            vc.movieTitle = movieList?.results[indexPath.item].title
            vc.id = movieList?.results[indexPath.item].id
            vc.vote_average = movieList?.results[indexPath.item].vote_average
            vc.release_date = movieList?.results[indexPath.item].release_date
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MainViewController: searchDelegate {
    func searchReceived(value: String) {
        searchList.append(value)
    }
}

extension MainViewController {
    func requestData() {
        NetworkManager.shared.fetchData(api: .getTrending(page: 1), T: Movie.self) { [weak self] value in
            guard let self = self else { return }
            movieList = value
            todaysMovieView.collectionView.reloadData()
        } errorCompletion: { error in
            print(error)
        }
    }
}
