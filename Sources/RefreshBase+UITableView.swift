//
//  RefreshBase+UITableView.swift
//  Refresh
//
//  Created by 刘栋 on 2018/9/1.
//  Copyright © 2018年 anotheren.com. All rights reserved.
//

import UIKit

// MARK: - UITableView + Header

private var tableViewHeaderKey: UInt8 = 0

extension RefreshBase where Base: UITableView {
    
    public var header: RefreshHeader? {
        get {
            return objc_getAssociatedObject(base, &tableViewHeaderKey) as? RefreshHeader
        }
        nonmutating set {
            if header != newValue {
                header?.removeFromSuperview()
                if let newValue = newValue {
                    base.insertSubview(newValue, at: 0)
                }
                objc_setAssociatedObject(base, &tableViewHeaderKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}

// MARK: - UITableView + Footer

private var tableViewFooterKey: UInt8 = 0

extension RefreshBase where Base: UITableView {
    
    public var footer: RefreshFooter? {
        get {
            return objc_getAssociatedObject(base, &tableViewFooterKey) as? RefreshFooter
        }
        nonmutating set {
            if footer != newValue {
                footer?.removeFromSuperview()
                if let newValue = newValue {
                    base.insertSubview(newValue, at: 0)
                }
                objc_setAssociatedObject(base, &tableViewFooterKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}

// MARK: - UITableView + Helper

extension RefreshBase where Base: UITableView {
    
    var totalCount: Int {
        var totalCount: Int = 0
        for section in 0..<base.numberOfSections {
            totalCount += base.numberOfRows(inSection: section)
        }
        return totalCount
    }
}
