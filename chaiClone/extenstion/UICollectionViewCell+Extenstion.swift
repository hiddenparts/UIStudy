//
//  UICollectionViewCell+Extenstion.swift
//  chaiClone
//
//  Created by sangsun on 2021/07/15.
//

import UIKit

extension UICollectionViewCell {
    class var identifier: String {
        get {
            return String(describing: self)
        }
    }
}
