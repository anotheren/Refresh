//
//  RefreshComponent.swift
//  Refresh
//
//  Created by 刘栋 on 2018/8/26.
//  Copyright © 2018年 anotheren.com. All rights reserved.
//

import UIKit

public class RefreshComponent: UIView {
    
    public typealias RefreshingHandle = () -> Void
    public typealias BeginRefreshingHandle = () -> Void
    public typealias EndRefreshingHandle = () -> Void
    
    public var state: RefreshState = .idle {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.setNeedsLayout()
            }
        }
    }
    
    var originalInset: UIEdgeInsets = .zero
    weak var scrollView: UIScrollView?
    
    private var pan: UIPanGestureRecognizer?
    
    public var pullingPercent: CGFloat = 0 {
        didSet {
            guard !isRefreshing else { return }
            if isAutomaticallyChangeAlpha {
                alpha = pullingPercent
            }
        }
    }
    
    var refreshingHandle: RefreshingHandle?
    var beginRefreshingHandle: BeginRefreshingHandle?
    var endRefreshingHandle: EndRefreshingHandle?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare() {
        autoresizingMask = .flexibleWidth
        backgroundColor = .clear
    }
    
    override public func layoutSubviews() {
        placeSubviews()
        super.layoutSubviews()
    }
    
    func placeSubviews() {
        fatalError("Please override by subclass")
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        guard let newSuperview = newSuperview, let newScrollView = newSuperview as? UIScrollView, let oldScrollView = scrollView else {
            return
        }
        removeObservers()
        
        refresh.width = newSuperview.refresh.width
        refresh.x = oldScrollView.refresh.insetLeft
        
        scrollView = newScrollView
        newScrollView.alwaysBounceVertical = true
        originalInset = newScrollView.refresh.inset
        
        addObservers()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        if state == .willRefresh {
            state = .refreshing
        }
    }
    
    private func addObservers() {
        let options: NSKeyValueObservingOptions = [.new, .old]
        scrollView?.addObserver(self, forKeyPath: RefreshConst.KeyPath.contentOffset, options: options, context: nil)
        scrollView?.addObserver(self, forKeyPath: RefreshConst.KeyPath.contentSize, options: options, context: nil)
        pan = scrollView?.panGestureRecognizer
        scrollView?.addObserver(self, forKeyPath: RefreshConst.KeyPath.panState, options: options, context: nil)
    }
    
    private func removeObservers() {
        superview?.removeObserver(self, forKeyPath: RefreshConst.KeyPath.contentOffset, context: nil)
        superview?.removeObserver(self, forKeyPath: RefreshConst.KeyPath.contentSize, context: nil)
        pan?.removeObserver(self, forKeyPath: RefreshConst.KeyPath.panState, context: nil)
        pan = nil
    }
    
    func observeValue(for keyPath: String, of object: Any, change: [String: Any], context: () -> Void) {
        guard isUserInteractionEnabled else { return }
        switch keyPath {
        case RefreshConst.KeyPath.contentSize:
            scrollView(contentSize: change)
        case RefreshConst.KeyPath.contentOffset:
            guard !isHidden else { return }
            scrollView(contentOffset: change)
        case RefreshConst.KeyPath.panState:
            guard !isHidden else { return }
            scrollView(panState: change)
        default:
            return
        }
    }
    
    public func scrollView(contentOffset change: [String: Any]) {
        fatalError("Please override by subclass")
    }
    
    public func scrollView(contentSize change: [String: Any]) {
        fatalError("Please override by subclass")
    }
    
    public func scrollView(panState change: [String: Any]) {
        fatalError("Please override by subclass")
    }
    
    public func beginRefreshing() {
        UIView.animate(withDuration: RefreshConst.Animation.fastDuration) {
            self.alpha = 1.0
        }
        pullingPercent = 1.0
        if window != nil {
            state = .refreshing
        } else {
            if state != .refreshing {
                state = .willRefresh
                setNeedsDisplay()
            }
        }
    }
    
    public func beginRefreshing(with handle: @escaping BeginRefreshingHandle) {
        beginRefreshingHandle = handle
        beginRefreshing()
    }
    
    public func endRefreshing() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.state = .idle
        }
    }
    
    public func endRefreshing(with handle: @escaping EndRefreshingHandle) {
        endRefreshingHandle = handle
        endRefreshing()
    }
    
    public var isRefreshing: Bool {
        return state == .refreshing || state == .willRefresh
    }
    
    public var isAutomaticallyChangeAlpha: Bool = true {
        didSet {
            guard !isRefreshing else { return }
            if isAutomaticallyChangeAlpha {
                alpha = pullingPercent
            } else {
                alpha = 1.0
            }
        }
    }
    
    func executeRefreshingCallback() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.refreshingHandle?()
            strongSelf.beginRefreshingHandle?()
        }
    }
}
