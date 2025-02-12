//
//  MovieDetailViewModel.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/12/25.
//

import Foundation

class MovieDetailViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let result: Observable<Result?> = Observable(nil)
        let movieData: Observable<Movie?> = Observable(nil)
        let request: Observable<Void?> = Observable(nil)
        let likeButton: Observable<Int> = Observable(0)
    }
    
    struct Output {
        let movieImageData: Observable<Image?> = Observable(nil)
        let result: Observable<Result?> = Observable(nil)
        let creditData: Observable<Credit?> = Observable(nil)
        let likeButton: Observable<Void?> = Observable(nil)
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        
        input.request.lazyBind {  [weak self] _ in
            guard let self = self else { return }
            fetchPosterData()
            fetchCastData()
        }
        
        input.result.bind { value in
            self.output.result.value = value
        }
        
        input.movieData.lazyBind { [weak self] value in
            guard let self = self else { return }
            fetchPosterData()
            fetchCastData()
        }
        
        input.likeButton.lazyBind { [weak self] _ in
            guard let self = self else { return }
            likeButtonTapped()
        }
    }
    
    
    private func fetchPosterData() {
        NetworkManager.shared.fetchData(api: .getMovieImages(movieId: input.result.value?.id ?? 12345), T: Image.self) { [weak self] value in
            guard let self = self else { return }
            
            output.movieImageData.value = value
            
        } errorCompletion: { error in
            print(error)
        }
    }
    
    private func fetchCastData() {
        NetworkManager.shared.fetchData(api: .getMovieCredits(movieId: input.result.value?.id ?? 12345), T: Credit.self) { [weak self] value in
            guard let self = self else { return }
            
            output.creditData.value = value
            
        } errorCompletion: { error in
            print(error)
        }
    }
    
    private func validationGenre() {
    }
    
    private func likeButtonTapped() {
        let movieId = input.result.value?.id ?? 0
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
