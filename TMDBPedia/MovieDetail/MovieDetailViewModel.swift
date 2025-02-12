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
        let moreButton: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let movieImageData: Observable<Image?> = Observable(nil)
        let result: Observable<Result?> = Observable(nil)
        let creditData: Observable<Credit?> = Observable(nil)
        let likeButton: Observable<Void?> = Observable(nil)
        let genre: Observable<[String]> = Observable([])
        let moreButton: Observable<Bool> = Observable(false)
        let SynopsisLine: Observable<Int> = Observable(3)
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
            validationGenre()
        }
        
        input.result.bind { value in
            self.output.result.value = value
        }
        
        input.movieData.lazyBind { [weak self] value in
            guard let self = self else { return }
            fetchPosterData()
            fetchCastData()
            validationGenre()
        }
        
        input.likeButton.lazyBind { [weak self] _ in
            guard let self = self else { return }
            likeButtonTapped()
        }
        
        input.moreButton.lazyBind { [weak self] _ in
            guard let self = self else { return }
            moreButtonTapped()
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
        switch output.result.value?.genre_ids.count {
        case 0:
            output.genre.value = []
        case 1:
            let genre1 = Genre(rawValue: output.result.value?.genre_ids[0] ?? 0)?.name
            guard let genre1 else {
                return
            }
            output.genre.value.append(genre1)
        default:
            let genre1 = Genre(rawValue: output.result.value?.genre_ids[0] ?? 0)?.name
            let genre2 = Genre(rawValue: output.result.value?.genre_ids[1] ?? 0)?.name
            guard let genre1, let genre2 else {
                return
            }
            output.genre.value.append(genre1)
            output.genre.value.append(genre2)
        }
        
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
    
    private func moreButtonTapped() {
        output.moreButton.value.toggle()
    }
}
