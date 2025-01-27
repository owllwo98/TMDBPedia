//
//  ProfileImageDetailView.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/25/25.
//

import UIKit
import SnapKit

final class ProfileImageDetailView: BaseView {
    
    lazy var selectedProfileButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.CustomBlue?.cgColor
        button.clipsToBounds = true
        
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let insect: CGFloat = 16
        let spacing: CGFloat = 16
        
        let cellWidth = UIScreen.main.bounds.width - (insect * 2) - (spacing * 3)
        
        layout.itemSize = CGSize(width: cellWidth / 4, height: cellWidth / 4)
        layout.sectionInset = .init(top: 0, left: insect, bottom: 0, right: insect)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func configureHierarchy() {
        addSubview(selectedProfileButton)
        addSubview(collectionView)
    }
    
    override func configureView() {
        backgroundColor = .black

        collectionView.backgroundColor = .black
    }
    
    override func configureLayout() {
        selectedProfileButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo((UIScreen.main.bounds.width - (16 * 2) - (16 * 3)) / 4)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(selectedProfileButton.snp.bottom).inset(-32)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
