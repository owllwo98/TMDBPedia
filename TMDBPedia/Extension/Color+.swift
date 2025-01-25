//
//  Color+.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/25/25.
//

import UIKit

extension UIColor {
    class var CustomBlue: UIColor? { return UIColor(named: "CustomBlue") }

//    class var secondary: UIColor? { return UIColor(named: "secondary") }
//
//    class var tertiary: UIColor? { return UIColor(named: "tertiary") }
}

func configureTextField(_ textField: UITextField ) {
    let border = CALayer()
    border.frame = CGRect(x: 0, y: textField.frame.size.height - 1, width: textField.frame.width, height: 1)
    border.backgroundColor = UIColor.gray.cgColor
    
    textField.layer.addSublayer(border)
    textField.textAlignment = .center
    textField.font = .systemFont(ofSize: 20, weight: .bold)
    textField.borderStyle = .none
}
