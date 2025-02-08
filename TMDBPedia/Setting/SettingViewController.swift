//
//  SettingViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/30/25.
//

import UIKit
import SnapKit

class SettingViewController: UIViewController {

    lazy var profileButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        
        return button
    }()
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 3
        image.layer.borderColor = UIColor.CustomBlue?.cgColor
        image.image = UIImage(named: UserDefaultsManager.shared.userProfileImage)
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        
        return image
    }()
    
    private let profileNickname: UILabel = {
        let label = UILabel()
        label.text = UserDefaultsManager.shared.userNickName
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        
        return label
        
    }()
    
    private let registrationDate: UILabel = {
        let label = UILabel()
        label.text = UserDefaultsManager.shared.userDate
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    private let rightButtonImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .lightGray
        
        return image
    }()
    
    let likeMoviewLabel: UILabel = {
        let label = UILabel()
        label.text = "\(UserDefaultsManager.shared.likedMovies.count)개의 무비박스 보관중"
        label.textColor = .white
        label.backgroundColor = .CustomBlue
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy private var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 60
        view.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.id)
        return view
    }()
    
    var list = ["자주 묻는 질문", "1:1 문의", "알림 설정", "탈퇴하기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "프로필 설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .CustomBlue
        
        configureHierarchy()
        configureLayout()
        
        tableView.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        likeMoviewLabel.text = "\(UserDefaultsManager.shared.likedMovies.count)개의 무비박스 보관중"
    }
    
    func configureHierarchy() {
        view.addSubview(profileButton)
        [profileImage, profileNickname, registrationDate, rightButtonImage, likeMoviewLabel].forEach {
            profileButton.addSubview($0)
        }
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        profileButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            make.horizontalEdges.equalToSuperview().inset(8)
        }
        
        profileImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(8)
            make.size.equalTo(50)
        }
        
        profileNickname.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalTo(profileImage.snp.trailing).inset(-8)
        }
        
        registrationDate.snp.makeConstraints { make in
            make.top.equalTo(profileNickname.snp.bottom).inset(-4)
            make.leading.equalTo(profileImage.snp.trailing).inset(-8)
        }
        
        rightButtonImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(profileImage.snp.centerY)
        }
        
        likeMoviewLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(profileButton.snp.bottom).inset(-8)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.id, for: indexPath) as! SettingTableViewCell
        
        cell.configureData(list[indexPath.row])
        cell.backgroundColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        present(UIViewController.customAlert(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row <= 2  {
            return nil
        }
        return indexPath
    }
    
    
}
