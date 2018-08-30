//
//  RefreshCompatible.swift
//  Refresh
//
//  Created by 刘栋 on 2018/8/26.
//  Copyright © 2018年 anotheren.com. All rights reserved.
//

import Foundation

public protocol RefreshCompatible {
    
    associatedtype CompatibleType
    
    static var refresh: RefreshBase<CompatibleType>.Type { get }
    
    var refresh: RefreshBase<CompatibleType> { get }
}

extension RefreshCompatible {
    
    public static var refresh: RefreshBase<Self>.Type {
        get {
            return RefreshBase<Self>.self
        }
        
    }
    
    public var refresh: RefreshBase<Self> {
        get {
            return RefreshBase(base: self)
        }
    }
}
