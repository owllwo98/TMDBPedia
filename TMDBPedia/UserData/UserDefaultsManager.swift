//
//  UserDefaultsManager.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/30/25.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    var isStart: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isStart")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isStart")
        }
    }
    
    var userNickName: String {
        get {
            UserDefaults.standard.string(forKey: "userNickName") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userNickName")
        }
    }
    
    var userProfileImage: String {
        get {
            UserDefaults.standard.string(forKey: "userProfileImage") ?? "profile_\(Int.random(in: 0...11))"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userProfileImage")
        }
    }
    
    var userDate: String {
        get {
            UserDefaults.standard.string(forKey: "userDate") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userDate")
        }
    }
    
    var likedMovies: [String: Bool] {
        get {
            guard let savedData = UserDefaults.standard.dictionary(forKey: "likedMovies") as? [String: Bool] else {
                return [:]
            }
            return savedData
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "likedMovies")
        }
    }
}
