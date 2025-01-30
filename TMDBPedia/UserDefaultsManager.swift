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
            UserDefaults.standard.string(forKey: "userNickName") ?? "NO NAME"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userNickName")
        }
    }
    
    var userBirthday: String {
        get {
            UserDefaults.standard.string(forKey: "userBirthday") ?? "NO DATE"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userBirthday")
        }
    }
    
    var userLevel: String {
        get {
            UserDefaults.standard.string(forKey: "userLevel") ?? "NO LEVEL"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userLevel")
        }
    }
    
    var like: Bool {
        get {
            UserDefaults.standard.bool(forKey: "like")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "like")
        }
    }
}
