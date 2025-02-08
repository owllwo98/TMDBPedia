//
//  UITextField+.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/8/25.
//
import UIKit

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}
