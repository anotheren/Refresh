//
//  RefreshState.swift
//  Refresh
//
//  Created by 刘栋 on 2018/8/26.
//  Copyright © 2018年 anotheren.com. All rights reserved.
//

import Foundation

public enum RefreshState {
    
    case idle
    case pulling
    case refreshing
    case willRefresh
    case noMoreData
}

extension RefreshState: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .idle:
            return "Idle"
        case .pulling:
            return "Pulling"
        case .refreshing:
            return "Refreshing"
        case .willRefresh:
            return "Will Refresh"
        case .noMoreData:
            return "No More Data"
        }
    }
}
