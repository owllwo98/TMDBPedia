//
//  ProfileImageViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/25/25.
//

import UIKit

class ProfileImageViewController: UIViewController {
    
    var profileImageDetailView = ProfileImageDetailView()
    
    let viewModel = ProfileImageViewModel()
    
    override func loadView() {
        self.view = profileImageDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "프로필 이미지 설정"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: ""), style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .CustomBlue
        
        profileImageDetailView.collectionView.delegate = self
        profileImageDetailView.collectionView.dataSource = self
        profileImageDetailView.collectionView.register(ProfileImageCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageCollectionViewCell.id)
        
        bindData()
        
    }
    
    override func viewDidLayoutSubviews() {
        profileImageDetailView.selectedProfileButton.layer.cornerRadius = profileImageDetailView.selectedProfileButton.frame.width / 2
    }
    
    func bindData() {
        viewModel.output.IndexPath.bind { value in
            for (collectionView, indexpath) in value {
                guard let indexpath else {
                    return
                }
                
                if self.viewModel.selectedIndex == indexpath {
                    
                    if let previousCell = collectionView?.cellForItem(at: indexpath) as? ProfileImageCollectionViewCell {
                        previousCell.itemImageView.alpha = 50
                        previousCell.itemImageView.layer.borderColor = UIColor.gray.cgColor
                    }
                    
                } else {
                    
                    if let newCell = collectionView?.cellForItem(at: indexpath) as? ProfileImageCollectionViewCell {
                        newCell.itemImageView.layer.borderColor = UIColor.CustomBlue?.cgColor
                        newCell.itemImageView.alpha = 100
                        
                    }
                }
            }
        }
    }
    
}

extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as? ProfileImageCollectionViewCell else { return UICollectionViewCell() }
        
        
        let imageName = "profile_\(indexPath.item)"
        cell.itemImageView.image = UIImage(named: imageName)
        
        viewModel.input.Image.value = imageName

        if imageName == UserDefaultsManager.shared.userProfileImage {
            cell.itemImageView.layer.borderColor = UIColor.CustomBlue?.cgColor
            cell.itemImageView.alpha = 100
            viewModel.selectedIndex = indexPath
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UserDefaultsManager.shared.userProfileImage = "profile_\(indexPath.item)"
        profileImageDetailView.selectedProfileButton.setImage(UIImage(named: UserDefaultsManager.shared.userProfileImage), for: .normal)
        
        viewModel.input.Data.value = [collectionView : indexPath]
        
    }
}

