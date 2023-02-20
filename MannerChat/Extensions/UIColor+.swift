//
//  UIColor+.swift
//  MannerChat
//
//  Created by Victor Lee on 2023/02/12.
//

import Foundation
import UIKit

extension UIColor {
    convenience init?(hex: String) {
        let r, g, b: CGFloat

        if hex.hasPrefix("#") {
            let idx = hex.index(hex.startIndex, offsetBy: 1)
            let hexString = String(hex[idx...])

            if hexString.count == 6 {
                let scanner = Scanner(string: hexString)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255

                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }
        return nil
    }
}