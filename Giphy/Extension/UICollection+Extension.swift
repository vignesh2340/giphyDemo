//
//  UICollection+Extension.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import UIKit

extension UICollectionView {
    
    func register(_ cellClass: String) {
        register(UINib(nibName: cellClass, bundle: nil), forCellWithReuseIdentifier: cellClass)
    }
    
}
