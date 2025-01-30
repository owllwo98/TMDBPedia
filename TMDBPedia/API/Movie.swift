//
//  Movie.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/30/25.
//

import Foundation

struct Movie: Decodable {
    let page: Int
    let results: [Result]
    let total_pages, total_results: Int
}

struct Result: Decodable {
    let backdrop_path: String
    let id: Int
    let title, original_title, overview, poster_path: String
    let media_type: String
    let adult: Bool
    let original_language: String
    let genre_ids: [Int]
    let popularity: Double
    let release_date: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}

