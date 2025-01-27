//
//  ProfileImageViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/25/25.
//

import UIKit

class ProfileImageViewController: UIViewController {

    var profileImageDetailView = ProfileImageDetailView()
    
    var selectedCell: IndexPath?
    
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
        
    }
    
    override func viewDidLayoutSubviews() {
        profileImageDetailView.selectedProfileButton.layer.cornerRadius = profileImageDetailView.selectedProfileButton.frame.width / 2
    }

}

extension ProfileImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageCollectionViewCell.id, for: indexPath) as? ProfileImageCollectionViewCell else { return UICollectionViewCell() }
        
        cell.itemImageView.image = UIImage(named: "profile_\(indexPath.item)")
        
        if profileImageDetailView.selectedProfileButton.image(for: .normal) == cell.itemImageView.image {
            cell.itemImageView.layer.borderColor = UIColor.CustomBlue?.cgColor
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = profileImageDetailView.collectionView.cellForItem(at: indexPath) as? ProfileImageCollectionViewCell else {
            return
        }
        
        
        
        cell.itemImageView.layer.borderColor = UIColor.CustomBlue?.cgColor
    }
    
}
