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
    let total_pages: Int
    let total_results: Int
}

struct Result: Decodable {
    let backdrop_path: String?
    let id: Int
    let title: String
    let original_title: String
    let overview: String
    let poster_path: String?
    let media_type: String?
    let original_language: String
    let genre_ids: [Int]
    let release_date: String
    let vote_average: Double
}


