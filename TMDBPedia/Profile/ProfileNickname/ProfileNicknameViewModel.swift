//
//  ProfileNicknameViewModel.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/8/25.
//

import Foundation

class ProfileNicknameViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let Text: Observable<String?> = Observable(nil)
    }
    
    struct Output {
        let Text: Observable<String?> = Observable(nil)
        var NickNameEnabled: Observable<Bool> = Observable(false)
    }
    
    var specialKeywords: [String] = ["@", "#", "$", "%"]
    var numberKeywords: [String] = ["0" ,"1", "2", "3", "4", "5", "6", "7", "8", "9",]
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.Text.lazyBind { [weak self] text in
            guard let self = self else { return }
            guard let text else {
                return
            }
            self.validationText(text: text)
        }
    }
    
    private func validationText(text: String) {
        if text.count < 2 || text.count > 10 {
            output.Text.value = "2글자 이상 10글자 미만으로 설정해주세요"
            output.NickNameEnabled.value = false
        } else if specialKeywords.contains(where: { text.contains($0) }) {
            output.Text.value  = "닉네임에 @,#,$,% 는 포함할 수 없어요"
            output.NickNameEnabled.value = false
        } else if numberKeywords.contains(where: { text.contains($0) }) {
            output.Text.value  = "닉네임에 숫자는 포함할 수 없어요"
            output.NickNameEnabled.value = false
        } else {
            output.Text.value  = "사용할 수 있는 닉네임이에요"
            output.NickNameEnabled.value = true
        }
    }
    
}
