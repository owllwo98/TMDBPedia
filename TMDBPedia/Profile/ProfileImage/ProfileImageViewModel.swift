//
//  ProfileImageViewModel.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/9/25.
//

import UIKit

class ProfileImageViewModel: BaseViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let Data: Observable<[UICollectionView? : IndexPath?]> = Observable([nil : nil])
        
        let IndexPath: Observable<String> = Observable(UserDefaultsManager.shared.userProfileImage)
        
        let Image: Observable<String?> = Observable(nil)
    }
    
    struct Output {
        let IndexPath:  Observable<[UICollectionView? : IndexPath?]> = Observable([nil : nil])
        
        let Image: Observable<Void?> = Observable(nil)
    }
    
    var selectedIndex: IndexPath?
    
    init() {
        input = Input()
        output = Output()
       
        transform()
    }
    
    func transform() {
        input.Data.bind { value in
            self.radioCell(value: value)
        }
        
        input.Image.bind { value in
            self.setCell()
        }
    }
    
    private func radioCell(value: [UICollectionView? : IndexPath?]) {
        for (collectionView, newIndexPath) in value {
            if let previousIndexPath = self.selectedIndex {
                self.output.IndexPath.value = [collectionView : previousIndexPath]
            }
      
            if let newIndexPath = newIndexPath {
                self.output.IndexPath.value = [collectionView : newIndexPath]
            }

            self.selectedIndex = newIndexPath
        }
    }
    
    private func setCell() {
        if input.Image.value == UserDefaultsManager.shared.userProfileImage {
            output.Image.value = ()
        }
    }
    
}
