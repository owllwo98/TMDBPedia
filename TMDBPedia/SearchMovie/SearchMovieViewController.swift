//
//  SearchMovieViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/30/25.
//

import UIKit
import Alamofire
import SnapKit

class SearchMovieViewController: UIViewController {
    
    var query: String = ""
    var page: Int = 1
    var isEnd: Bool = false
    var contents: searchDelegate?
    
    var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.backgroundColor = .black
        search.searchTextField.backgroundColor = .gray
        search.tintColor = .white
        search.placeholder = "영화를 검색해보세요"
        search.barTintColor = .black
        search.searchTextField.textColor = .white
        
        return search
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .bold)
        
        return label
    }()
    
    let titleView: UIView = UIView()
    
    lazy var movieCollectionView = createSearchMovieCollectionView()
    
    var movieList: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "영화 검색"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .CustomBlue
        
        view.backgroundColor = .black
        
        configureHierarchy()
        configureLayout()
        
        mainLabel.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieCollectionView.reloadData()
    }
   
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {
        let movieId = movieList[sender.tag].id
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

        movieCollectionView.reloadData()
    }
    
    func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(titleView)
        
        [movieCollectionView, mainLabel].forEach {
            titleView.addSubview($0)
        }
        
        searchBar.delegate = self
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register(SearchMovieCollectionViewCell.self, forCellWithReuseIdentifier: SearchMovieCollectionViewCell.id)
        movieCollectionView.keyboardDismissMode = .onDrag
        movieCollectionView.prefetchDataSource = self
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom
            ).inset(-4)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        movieCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
    
    }
}

extension SearchMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMovieCollectionViewCell.id, for: indexPath) as! SearchMovieCollectionViewCell
        
        cell.configureData(movieList[indexPath.item])
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        cell.likeButton.tag = indexPath.item
        
        DispatchQueue.main.async {
            cell.genreLabel1.layer.cornerRadius = 4
            cell.genreLabel1.clipsToBounds = true
            cell.genreLabel2.layer.cornerRadius = 4
            cell.genreLabel2.clipsToBounds = true
            cell.posterImageView.layer.cornerRadius = 8
            cell.posterImageView.clipsToBounds = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.result = movieList[indexPath.item]
        vc.id = movieList[indexPath.item].id
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchMovieViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if movieList.count - 5 == item.item && !isEnd {
                page += 1
                requestData()
            }
        }
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    private func dissmissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dissmissKeyboard()
        
        guard let text = searchBar.text else {
            return
        }
        
        guard let search = searchBar.text else {
            return
        }
        contents?.searchReceived(value: search)
        
        page = 1
        query = text
        requestData()
    }
}

extension SearchMovieViewController {
    func requestData() {
        NetworkManager.shared.fetchData(api: .getSearchMovie(keyword: query, page: page), T: Movie.self) { [weak self] value in
            guard let self = self else { return }

            if value.total_pages <= page {
                isEnd.toggle()
            } else {
                isEnd = false
            }
            
            if value.results.isEmpty {
                mainLabel.isHidden = false
                mainLabel.text = "원하는 검색결과를 찾지 못했습니다."
                movieList = value.results
                movieCollectionView.reloadData()
            } else {
                if page == 1 {
                    movieList = value.results
                } else {
                    movieList.append(contentsOf: value.results)
                }
                mainLabel.isHidden = true
            }
            
            DispatchQueue.main.async {
                if self.page == 1 && !self.movieList.isEmpty {
                    self.movieCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }
            }
            
            movieCollectionView.reloadData()
            
        } errorCompletion: { error in
            print(error)
        }
    }
}

extension SearchMovieViewController {
    private func createSearchMovieCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 6.5)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black

        return collectionView
    }
}
