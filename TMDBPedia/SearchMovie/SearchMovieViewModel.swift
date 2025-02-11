//
//  SearchMovieViewModel.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/11/25.
//

import Foundation
import Alamofire

class SearchMovieViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let query: Observable<String> = Observable("")
        let page: Observable<Int> = Observable(1)
        let isEnd: Observable<Bool> = Observable(false)
        
        let indexPath: Observable<[IndexPath]> = Observable([])
        let likeButton: Observable<Int> = Observable(0)
    }
    
    struct Output {
        let query: Observable<String> = Observable("")
        let page: Observable<Int> = Observable(1)
        let isEnd: Observable<Bool> = Observable(false)
        let movieList: Observable<[Result]> = Observable([])
        let emptyMovieList: Observable<Void?> = Observable(nil)
        let moveToTop: Observable<Void?> = Observable(nil)
        
        let likeButton: Observable<Void?> = Observable(nil)
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.query.lazyBind { [weak self] value in
            guard let self = self else { return }
            fetchData()
        }
        
        input.page.lazyBind { [weak self] value in
            guard let self = self else { return }
            fetchData()
        }
        
        input.likeButton.lazyBind { [weak self] _ in
            guard let self = self else { return }
            likeButtonTapped()
        }
        
        input.indexPath.lazyBind { [weak self] _ in
            guard let self = self else { return }
            prefetchCell()
        }
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchData(api: .getSearchMovie(keyword: input.query.value, page: input.page.value), T: Movie.self) { [weak self] value in
            guard let self = self else { return }

            if value.total_pages <= input.page.value {
                output.isEnd.value.toggle()
            } else {
                output.isEnd.value = false
            }
            
            if value.results.isEmpty {
                output.emptyMovieList.value = ()
            } else {
                if input.page.value == 1 {
                    output.movieList.value = value.results
                } else {
                    output.movieList.value.append(contentsOf: value.results)
                }
            }
            
            DispatchQueue.main.async {
                if self.input.page.value == 1 && !self.output.movieList.value.isEmpty {
                    self.output.moveToTop.value = ()
                }
            }
            
        } errorCompletion: { error in
            print(error)
        }
    }
    
    private func likeButtonTapped() {
        let movieId = output.movieList.value[input.likeButton.value].id
        
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
        output.likeButton.value = ()
    }
    
    private func prefetchCell() {
        for item in input.indexPath.value {
            if output.movieList.value.count - 5 == item.item && !output.isEnd.value {
                input.page.value += 1
                fetchData()
            }
        }
    }

}
