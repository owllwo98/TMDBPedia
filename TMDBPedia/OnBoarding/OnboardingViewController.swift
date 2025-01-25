//
//  OnboardingViewController.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/25/25.
//

import UIKit
import Alamofire
import SnapKit
import Kingfisher

final class OnboardingViewController: UIViewController {

    private var onboardingDetailView = OnboardingDetailView()
    
    override func loadView() {
        self.view = onboardingDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    



}
