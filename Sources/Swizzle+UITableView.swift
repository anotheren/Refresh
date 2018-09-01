//
//  Swizzle+UITableView.swift
//  Refresh
//
//  Created by 刘栋 on 2018/9/1.
//  Copyright © 2018年 anotheren.com. All rights reserved.
//

import UIKit

extension UITableView {
    
    static let swizzleReloadData: () = {
        let originalSelector = #selector(UITableView.reloadData)
        let swizzledSelector = #selector(UITableView.refreshReloadData)
        SwizzleHelper.swizzleMethod(for: UITableView.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    
    @objc private func refreshReloadData() {
        refreshReloadData()
        
    }
}
