//
//  RefreshBase+UIView.swift
//  Refresh
//
//  Created by 刘栋 on 2018/8/26.
//  Copyright © 2018年 anotheren.com. All rights reserved.
//

import UIKit

extension RefreshBase where Base: UIView {
    
    public var x: CGFloat {
        get {
            return base.frame.origin.x
        }
        nonmutating set {
            base.frame.origin.x = newValue
        }
    }
    
    public var y: CGFloat {
        get {
            return base.frame.origin.y
        }
        nonmutating set {
            base.frame.origin.y = newValue
        }
    }
    
    public var width: CGFloat {
        get {
            return base.frame.size.width
        }
        nonmutating set {
            base.frame.size.width = newValue
        }
    }
    
    public var height: CGFloat {
        get {
            return base.frame.size.height
        }
        nonmutating set {
            base.frame.size.height = newValue
        }
    }
    
    public var size: CGSize {
        get {
            return base.frame.size
        }
        nonmutating set {
            base.frame.size = newValue
        }
    }
    
    public var origin: CGPoint {
        get {
            return base.frame.origin
        }
        nonmutating set {
            base.frame.origin = newValue
        }
    }
}
