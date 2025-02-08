//
//  RecentSearchView.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/29/25.
//

import UIKit
import SnapKit

final class RecentSearchView: BaseView {
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "최근검색어"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        
        return button
    }()
    
    let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 검색어 내역이 없습니다."
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 60, height: 30)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        
        return collectionView
    }()
    
    
    override func configureHierarchy() {
        [sectionLabel, deleteButton, baseView].forEach {
            addSubview($0)
        }
        
        baseView.addSubview(emptyLabel)
        baseView.addSubview(collectionView)
        
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(sectionLabel)
        }
        
        baseView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(60)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(30)
            make.centerY.equalTo(baseView.snp.centerY)
        }
    }
    
    override func configureView() {

    }
}
