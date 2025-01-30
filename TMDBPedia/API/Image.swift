//
//  Image.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/30/25.
//

import Foundation

struct Image: Decodable {
    let backdrops: [BackdropDetail]
    let posters: [PosterDetail]
}

struct BackdropDetail: Decodable {
    let file_path: String
}

struct PosterDetail: Decodable {
    let file_path: String
}
