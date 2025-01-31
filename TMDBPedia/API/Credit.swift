//
//  Credit.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/31/25.
//

import Foundation

struct Credit: Decodable {
    let id: Int
    let cast: [castDetail]
}

struct castDetail: Decodable {
    let name: String
    let profile_path: String?
    let character: String
    let original_name: String
}
