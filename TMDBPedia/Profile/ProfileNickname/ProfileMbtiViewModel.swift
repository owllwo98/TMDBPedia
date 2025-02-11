//
//  ProfileMbtiViewModel.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/10/25.
//

import Foundation

class ProfileMbtiViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let Button:Observable<[Int: Int]> = Observable([:])
    }
    
    struct Output {
        let Button: Observable<[Int: Int]> = Observable([:])
        var MbtiEnabled: Observable<Bool> = Observable(false)
    }
    
    
    var previousButton: Observable<[Int: Int]> = Observable([:])
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    func transform() {
        input.Button.bind { [weak self] value in
            guard let self = self else { return }
            for (group, tag) in value {
                self.selectButton(groupTag: group, buttonTag: tag)
            }
        }
    }
    
    
    private func selectButton(groupTag: Int, buttonTag: Int) {
        var currentState = input.Button.value
        
        if previousButton.value == [:] {
            previousButton.value = [groupTag : buttonTag]
            currentState[groupTag] = buttonTag
            output.MbtiEnabled.value = true
        } else if buttonTag == previousButton.value[groupTag] {
            currentState.removeValue(forKey: groupTag)
            previousButton.value = [:]
            output.MbtiEnabled.value = false
        } else {
            currentState[groupTag] = buttonTag
            previousButton.value[groupTag] = buttonTag
            output.MbtiEnabled.value = true
        }
        
        output.Button.value = currentState
       
    }
}
