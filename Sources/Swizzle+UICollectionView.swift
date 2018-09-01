//
//  Swizzle+UICollectionView.swift
//  Refresh
//
//  Created by 刘栋 on 2018/9/1.
//  Copyright © 2018年 anotheren.com. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    static let swizzleReloadData: () = {
        let originalSelector = #selector(UICollectionView.reloadData)
        let swizzledSelector = #selector(UICollectionView.refreshReloadData)
        SwizzleHelper.swizzleMethod(for: UICollectionView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    @objc private func refreshReloadData() {
        refreshReloadData()
    }
}
