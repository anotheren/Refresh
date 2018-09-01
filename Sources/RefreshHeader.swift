//
//  RefreshHeader.swift
//  Refresh
//
//  Created by 刘栋 on 2018/9/1.
//  Copyright © 2018年 anotheren.com. All rights reserved.
//

import UIKit

public class RefreshHeader: RefreshComponent {
    
    public var lastUpdatedTimeKey: String = RefreshConst.Header.lastUpdateTimeKey
    public var lastUpdatedTime: Date?
    public var ignoredScrollViewContentInsetTop: CGFloat = 0 {
        didSet {
            refresh.y = -refresh.height - ignoredScrollViewContentInsetTop
        }
    }
    
    public override var state: RefreshState {
        didSet {
            guard state != oldValue else { return }
            if state == .idle {
                guard oldValue == .refreshing else { return }
                
                UserDefaults.standard.set(Date(), forKey: lastUpdatedTimeKey)
                
                UIView.animate(withDuration: RefreshConst.Animation.slowDuration, animations: {
                    self.scrollView?.refresh.insetTop += self.insetTopDelta
                }) { finished in
                    self.pullingPercent = 0
                    self.endRefreshingHandle?()
                }
            } else if state == .refreshing {
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    UIView.animate(withDuration: RefreshConst.Animation.fastDuration, animations: {
                        guard let scrollView = strongSelf.scrollView else { return }
                        let top: CGFloat = strongSelf.originalInset.top + strongSelf.refresh.height
                        scrollView.refresh.insetTop = top
                        var offset: CGPoint = scrollView.contentOffset
                        offset.y = -top
                        scrollView.setContentOffset(offset, animated: false)
                    }, completion: { finished in
                        strongSelf.executeRefreshingCallback()
                    })
                }
            }
        }
    }
    
    private var insetTopDelta: CGFloat = 0
    
    public init(refreshing: @escaping RefreshingHandle) {
        super.init(frame: .zero)
        refreshingHandle = refreshing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        refresh.height = RefreshConst.Header.height
    }
    
    override func placeSubviews() {
        refresh.y = refresh.height - ignoredScrollViewContentInsetTop
    }
    
    public override func scrollView(contentOffset change: [String : Any]) {
        guard let scrollView = self.scrollView else { return }
        if state == .refreshing {
            guard window != nil else { return }
            
            var insetTop: CGFloat = -scrollView.refresh.offsetY > self.originalInset.top ? -scrollView.refresh.offsetY : originalInset.top
            if insetTop > refresh.height + originalInset.top {
                insetTop = refresh.height + originalInset.top
            }
            scrollView.refresh.insetTop = insetTop
            
            insetTopDelta = originalInset.top - insetTop
            return
        }
        
        originalInset = scrollView.refresh.inset
        
        let offsetY: CGFloat = scrollView.refresh.offsetY
        let happenOffsetY: CGFloat = -originalInset.top
        
        if offsetY > happenOffsetY { return }
        
        let normalToPullingOffsetY: CGFloat = happenOffsetY - refresh.height
        let pullingPercent: CGFloat = (happenOffsetY - offsetY) / refresh.height
        
        if scrollView.isDragging {
            self.pullingPercent = pullingPercent
            if state == .idle && offsetY < normalToPullingOffsetY {
                state = .pulling
            } else if state == .pulling && offsetY >= normalToPullingOffsetY {
                state = .idle
            }
        } else if state == .pulling {
            beginRefreshing()
        } else if pullingPercent < 1 {
            self.pullingPercent = pullingPercent
        }
    }
}
