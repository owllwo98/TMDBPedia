//
//  Color+.swift
//  TMDBPedia
//
//  Created by 변정훈 on 1/25/25.
//

import UIKit

extension UIColor {
    class var CustomBlue: UIColor? { return UIColor(named: "CustomBlue") }
    static let customGray100: UIColor = UIColor(hexCode: "8C8C8C")
    static let customGray200: UIColor = UIColor(hexCode: "9b9b9b")
    static let customBlue100: UIColor = UIColor(hexCode: "186FF2")
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
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

