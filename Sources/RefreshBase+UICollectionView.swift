//
//  RefreshBase+UICollectionView.swift
//  Refresh
//
//  Created by 刘栋 on 2018/9/1.
//  Copyright © 2018年 anotheren.com. All rights reserved.
//

import UIKit

// MARK: - UICollectionView + Header

private var collectionViewHeaderKey: UInt8 = 0

extension RefreshBase where Base: UICollectionView {
    
    public var header: RefreshHeader? {
        get {
            return objc_getAssociatedObject(base, &collectionViewHeaderKey) as? RefreshHeader
        }
        nonmutating set {
            if header != newValue {
                header?.removeFromSuperview()
                if let newValue = newValue {
                    base.insertSubview(newValue, at: 0)
                }
                objc_setAssociatedObject(base, &collectionViewHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN)
                UICollectionView.swizzleReloadData
            }
        }
    }
}

// MARK: - UICollectionView + Footer

private var collectionViewFooterKey: UInt8 = 0

extension RefreshBase where Base: UICollectionView {
    
    public var footer: RefreshFooter? {
        get {
            return objc_getAssociatedObject(base, &collectionViewFooterKey) as? RefreshFooter
        }
        nonmutating set {
            if footer != newValue {
                footer?.removeFromSuperview()
                if let newValue = newValue {
                    base.insertSubview(newValue, at: 0)
                }
                objc_setAssociatedObject(base, &collectionViewFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}

// MARK: - UICollectionView + Helper

extension RefreshBase where Base: UICollectionView {
    
    var totalCount: Int {
        var totalCount: Int = 0
        for section in 0..<base.numberOfSections {
            totalCount += base.numberOfItems(inSection: section)
        }
        return totalCount
    }
}

