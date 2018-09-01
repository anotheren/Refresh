//
//  RefreshBase+UIScrollView.swift
//  Refresh
//
//  Created by 刘栋 on 2018/8/26.
//  Copyright © 2018年 anotheren.com. All rights reserved.
//

import UIKit

extension RefreshBase where Base: UIScrollView {
    
    public var inset: UIEdgeInsets {
        get {
            if #available(iOS 11.0, *) {
                return base.adjustedContentInset
            } else {
                return base.contentInset
            }
        }
    }
    
    public var insetTop: CGFloat {
        get {
            return inset.top
        }
        nonmutating set {
            var inset = base.contentInset
            inset.top = newValue
            if #available(iOS 11.0, *) {
                inset.top -= (base.adjustedContentInset.top - base.contentInset.top)
            }
            base.contentInset = inset
        }
        
    }
    
    public var insetBottom: CGFloat {
        get {
            return inset.bottom
        }
        nonmutating set {
            var inset = base.contentInset
            inset.bottom = newValue
            if #available(iOS 11.0, *) {
                inset.bottom -= (base.adjustedContentInset.bottom - base.contentInset.bottom)
            }
            base.contentInset = inset
        }
    }
    
    public var insetLeft: CGFloat {
        get {
            return inset.left
        }
        nonmutating set {
            var inset = base.contentInset
            inset.left = newValue
            if #available(iOS 11.0, *) {
                inset.left -= (base.adjustedContentInset.left - base.contentInset.left)
            }
            base.contentInset = inset
        }
    }
    
    public var insetRight: CGFloat {
        get {
            return inset.right
        }
        nonmutating set {
            var inset = base.contentInset
            inset.right = newValue
            if #available(iOS 11.0, *) {
                inset.right -= (base.adjustedContentInset.right - base.contentInset.right)
            }
            base.contentInset = inset
        }
    }
    
    public var offsetX: CGFloat {
        get {
            return base.contentOffset.x
        }
        nonmutating set {
            base.contentOffset.x = newValue
        }
    }
    
    public var offsetY: CGFloat {
        get {
            return base.contentOffset.y
        }
        nonmutating set {
            base.contentOffset.y = newValue
        }
    }
    
    public var contentWidth: CGFloat {
        get {
            return base.contentSize.width
        }
        nonmutating set {
            base.contentSize.width = newValue
        }
    }
    
    public var contentHeight: CGFloat {
        get {
            return base.contentSize.height
        }
        nonmutating set {
            base.contentSize.height = newValue
        }
    }
}
