//
//  ProfileImageViewModel.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/9/25.
//

import UIKit

class ProfileImageViewModel {
    let inputData: Observable<[UICollectionView? : IndexPath?]> = Observable([nil : nil])
    
    let inputIndexPath: Observable<String> = Observable(UserDefaultsManager.shared.userProfileImage)
    
    let inputImage: Observable<String?> = Observable(nil)
    
    let outputIndexPath:  Observable<[UICollectionView? : IndexPath?]> = Observable([nil : nil])
    
    let outputImage: Observable<Void?> = Observable(nil)
   
    var selectedIndex: IndexPath?
    
    init() {
        inputData.bind { value in
            self.radioCell(value: value)
        }
        
        inputImage.bind { value in
            self.setCell()
        }
    }
    
    private func radioCell(value: [UICollectionView? : IndexPath?]) {
        for (collectionView, newIndexPath) in value {
            if let previousIndexPath = self.selectedIndex {
                self.outputIndexPath.value = [collectionView : previousIndexPath]
            }
      
            if let newIndexPath = newIndexPath {
                self.outputIndexPath.value = [collectionView : newIndexPath]
            }

            self.selectedIndex = newIndexPath
        }
    }
    
    private func setCell() {
        if inputImage.value == UserDefaultsManager.shared.userProfileImage {
            outputImage.value = ()
        }
    }
    
}
