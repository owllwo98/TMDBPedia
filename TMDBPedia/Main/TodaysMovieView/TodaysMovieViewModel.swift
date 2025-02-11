//
//  TodaysMovieViewModel.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/11/25.
//

import Foundation
import Alamofire

class TodaysMovieViewModel: BaseViewModel {
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let requestData: Observable<Void?> = Observable(nil)
        let likeButton: Observable<Int> = Observable(0)
    }
    
    struct Output {
        let movieData: Observable<Movie?> = Observable(nil)
        let likeButton: Observable<Void?> = Observable(nil)
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.requestData.bind { [weak self] _ in
            guard let self = self else { return }
            fetchData()
        }
        
        input.likeButton.lazyBind { [weak self] _ in
            guard let self = self else { return }
            likeButtonTapped()
        }
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchData(api: .getTrending(page: 1), T: Movie.self) { [weak self] value in
            guard let self = self else { return }
            output.movieData.value = value
        } errorCompletion: { error in
            print(error)
        }
    }
    
    private func likeButtonTapped() {
        let movieId = output.movieData.value?.results[input.likeButton.value].id ?? 0
        
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

}
