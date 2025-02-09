//
//  ProfileNicknameViewModel.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/8/25.
//

import Foundation

class ProfileNicknameViewModel {
    
    let inputText: Observable<String?> = Observable(nil)
    let inputButton:Observable<[Int: Int]> = Observable([:])
    
    let outputText: Observable<String?> = Observable(nil)
    let outputButton: Observable<[Int: Int]> = Observable([:])
    
    var specialKeywords: [String] = ["@", "#", "$", "%"]
    var numberKeywords: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9",]
    var previousButton: Int? = nil
    var outputNickNameEnabled: Observable<Bool> = Observable(false)
    var outputMbtiEnabled: Observable<Bool> = Observable(false)
    
    
    init() {
        inputText.lazyBind { [weak self] text in
            guard let self = self else { return }
            guard let text else {
                return
            }
            self.validationText(text: text)
        }
        
        inputButton.lazyBind { [weak self] value in
            guard let self = self else { return }
            for (group, tag) in value {
                self.selectButton(groupTag: group, buttonTag: tag)
            }
        }
    }
    
    private func validationText(text: String) {
        if text.count < 2 || text.count > 10 {
            outputText.value = "2글자 이상 10글자 미만으로 설정해주세요"
            outputNickNameEnabled.value = false
        } else if specialKeywords.contains(where: { text.contains($0) }) {
            outputText.value  = "닉네임에 @,#,$,% 는 포함할 수 없어요"
            outputNickNameEnabled.value = false
        } else if numberKeywords.contains(where: { text.contains($0) }) {
            outputText.value  = "닉네임에 숫자는 포함할 수 없어요"
            outputNickNameEnabled.value = false
        } else {
            outputText.value  = "사용할 수 있는 닉네임이에요"
            outputNickNameEnabled.value = true
        }
    }
    
    func selectButton(groupTag: Int, buttonTag: Int) {
        var currentState = inputButton.value
        
        if previousButton == nil {
            previousButton = buttonTag
            currentState[groupTag] = buttonTag
            outputMbtiEnabled.value = true
        } else if buttonTag == previousButton {
            currentState.removeValue(forKey: groupTag)
            previousButton = nil
            outputMbtiEnabled.value = false
        } else {
            currentState[groupTag] = buttonTag
            previousButton = buttonTag
            outputMbtiEnabled.value = true
        }
        
        outputButton.value = currentState
       
    }
}
