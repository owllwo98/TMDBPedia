//
//  TodaysMovieView.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/28/25.
//

import UIKit
import SnapKit

class TodaysMovieView: BaseView {
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 영화"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 2, height: UIScreen.main.bounds.width / 1.5)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    override func configureHierarchy() {
        addSubview(sectionLabel)
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    override func configureView() {

    }
}
