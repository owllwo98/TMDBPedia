//
//  SettingTableViewCell.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/31/25.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    
    static let id = "SettingTableViewCell"
    
    
    let titleLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .left
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
       
    }

    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    func configureData(_ text: String) {
        titleLabel.text = text
    }
}
