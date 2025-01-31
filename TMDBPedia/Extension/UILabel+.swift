//
//  UILabel+.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/30/25.
//

import UIKit

extension UILabel {
    static func addImageLabel(_ label: UILabel, _ text: String,_ image: String) {
        let text: String = text
        let space: String = " "
        
        let attributedString = NSMutableAttributedString(string: "")
        
        let imageAttachment = NSTextAttachment()
        let originalImage = UIImage(systemName: image)
        let tintedImage = originalImage?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        imageAttachment.image = tintedImage
        
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: text))
        attributedString.append(NSAttributedString(string: space))
        
        label.attributedText = attributedString
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 8, weight: .semibold)
    }
}
