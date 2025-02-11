//
//  RecentSearchViewModel.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/11/25.
//

import Foundation

class RecentSearchViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let removeAll: Observable<Void?> = Observable(nil)
        let searchList: Observable<String> = Observable("")
        let searchListTag: Observable<Int> = Observable(0)
    }
    
    struct Output {
//        let removeAll: Observable<Void?> = Observable(nil)
        let searchList: Observable<[String]> = Observable([])
    }
    
   
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }

    func transform() {
        input.searchList.lazyBind { [weak self] value in
            guard let self = self else { return }
            addCell()
        }
        
        input.removeAll.lazyBind { [weak self] _ in
            guard let self = self else { return }
            removeAllCell()
        }
        
        input.searchListTag.lazyBind { [weak self] value in
            guard let self = self else { return }
            removeCell()
        }
    }
    
    private func addCell() {
        
        
        output.searchList.value.append(input.searchList.value)
    }
    
    private func removeAllCell() {
        output.searchList.value.removeAll()
    }
    
    private func removeCell() {
        output.searchList.value.remove(at: input.searchListTag.value)
    }
}
