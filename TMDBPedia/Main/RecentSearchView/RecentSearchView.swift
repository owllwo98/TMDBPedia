//
//  RecentSearchView.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/29/25.
//

import UIKit
import SnapKit

class RecentSearchView: BaseView {
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "최근검색어"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
    }()
    
    let deleteLabel: UILabel = {
        let label = UILabel()
        label.text = "전체 삭제"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .bold)
        
        return label
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
        label.font = .systemFont(ofSize: 8, weight: .semibold)
        
        return label
    }()
    
    
    override func configureHierarchy() {
        [sectionLabel, deleteLabel, baseView].forEach {
            addSubview($0)
        }
        
        baseView.addSubview(emptyLabel)
        
    }
    
    override func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
        }
        
        deleteLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(sectionLabel)
        }
        
        baseView.snp.makeConstraints { make in
            make.top.equalTo(sectionLabel.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    override func configureView() {
        
    }
}
