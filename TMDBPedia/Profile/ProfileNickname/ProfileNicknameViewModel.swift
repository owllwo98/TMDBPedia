//
//  ProfileNicknameViewModel.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/8/25.
//

import Foundation

class ProfileNicknameViewModel {
    
    let inputText: Observable<String?> = Observable(nil)
    
    let outputText: Observable<String?> = Observable(nil)
    let outputButtonTrigger: Observable<Bool> = Observable(false)
    
    var specialKeywords: [String] = ["@", "#", "$", "%"]
    var numberKeywords: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9",]
    
    init() {
        inputText.lazyBind { text in
            guard let text else {
                return
            }
            self.validationText(text: text)
        }
    }
    
    private func validationText(text: String) {
        if text.count < 2 || text.count > 10 {
            outputText.value = "2글자 이상 10글자 미만으로 설정해주세요"
            outputButtonTrigger.value = false
        } else if specialKeywords.contains(where: { text.contains($0) }) {
            outputText.value  = "닉네임에 @,#,$,% 는 포함할 수 없어요"
            outputButtonTrigger.value = false
        } else if numberKeywords.contains(where: { text.contains($0) }) {
            outputText.value  = "닉네임에 숫자는 포함할 수 없어요"
            outputButtonTrigger.value = false
        } else {
            outputText.value  = "사용할 수 있는 닉네임이에요"
            outputButtonTrigger.value = true
        }
    }
}
