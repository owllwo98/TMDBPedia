//
//  UIViewController+.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/31/25.
//

import UIKit

extension UIViewController {
    static func customAlert() -> UIAlertController {
        let saveAlert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?" , preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { action in
            UserDefaultsManager.shared.isStart = false
            UserDefaultsManager.shared.likedMovies.removeAll()
            UserDefaultsManager.shared.userNickName = ""
            UserDefaultsManager.shared.userDate = ""
            UserDefaultsManager.shared.userProfileImage = "profile_\(Int.random(in: 0...11))"
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            
            let nav = UINavigationController(rootViewController: OnboardingViewController())
            window.rootViewController = nav
            window.makeKeyAndVisible()
            
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { action in
            
        }
        
        saveAlert.addAction(okAction)
        saveAlert.addAction(cancelAction)

        return saveAlert
    }
}
