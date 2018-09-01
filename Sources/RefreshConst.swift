//
//  RefreshConst.swift
//  Refresh
//
//  Created by 刘栋 on 2018/8/29.
//  Copyright © 2018年 anotheren.com. All rights reserved.
//

import UIKit

struct RefreshConst {
    
    struct KeyPath {
        
        static let contentOffset = "contentOffset"
        static let contentInset = "contentInset"
        static let contentSize = "contentSize"
        static let panState = "state"
    }
    
    struct Animation {
        
        static let fastDuration: TimeInterval = 0.25
        static let slowDuration: TimeInterval = 0.40
    }
    
    struct Header {
        
        static let height: CGFloat = 54
        
        static let lastUpdateTimeKey: String = "RefreshHeaderLastUpdatedTimeKey"
        
        static let idleText: String = "RefreshHeaderIdleText"
        static let pullingtext: String = "RefreshHeaderPullingText"
        static let refreshingText: String = "RefreshHeaderRefreshingText"
        
        static let lastTimeText: String = "RefreshHeaderLastTimeText"
        static let dateTodayText: String = "RefreshHeaderDateTodayText"
        static let noneLastDateText: String = "RefreshHeaderNoneLastDateText"
    }
    
    struct Footer {
        
        static let height: CGFloat = 44
    }
}
