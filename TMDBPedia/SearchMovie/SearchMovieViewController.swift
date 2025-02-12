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
    
    let searchMovieViewModel =  SearchMovieViewModel()
    
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
        
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieCollectionView.reloadData()
    }
    
    func bindData() {
        
        searchMovieViewModel.output.movieList.lazyBind { [weak self] value in
            guard let self = self else { return }
            
            movieCollectionView.isHidden = false
            mainLabel.isHidden = true
            movieCollectionView.reloadData()
        }
        
        searchMovieViewModel.output.emptyMovieList.lazyBind { [weak self] _ in
            guard let self = self else { return }
            movieCollectionView.isHidden = true
            mainLabel.isHidden = false
            mainLabel.text = "원하는 검색결과를 찾지 못했습니다."
        }
        
        searchMovieViewModel.output.moveToTop.lazyBind { [weak self] _ in
            guard let self = self else { return }
            movieCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        
        searchMovieViewModel.output.likeButton.lazyBind {  [weak self] _ in
            guard let self = self else { return }
            movieCollectionView.reloadData()
        }
    }
   
    
    @objc
    func likeButtonTapped(_ sender: UIButton) {        
        searchMovieViewModel.input.likeButton.value = sender.tag
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
        return searchMovieViewModel.output.movieList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMovieCollectionViewCell.id, for: indexPath) as! SearchMovieCollectionViewCell
        
        cell.configureData(searchMovieViewModel.output.movieList.value[indexPath.item])
        
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
        vc.movieDetailViewModel.input.result.value = searchMovieViewModel.output.movieList.value[indexPath.item]
        
        vc.movieDetailViewModel.input.request.value = ()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchMovieViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        searchMovieViewModel.input.indexPath.value = indexPaths
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    private func dissmissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        dissmissKeyboard()
        
        guard let text = searchBar.text else {
            return
        }
        

        
        contents?.searchReceived(value: text)
        
        searchMovieViewModel.input.page.value = 1
        searchMovieViewModel.input.query.value = text
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
