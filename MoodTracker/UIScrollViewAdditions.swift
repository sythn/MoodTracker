//
//  UIScrollViewAdditions.swift
//  Horoscope
//
//  Created by Seyithan Teymur on 22/12/14.
//  Copyright (c) 2014 Brokoli. All rights reserved.
//

import UIKit

public extension UIScrollView {
    public func setTopInset(_ inset: CGFloat) {
        setInset(inset, top: true)
    }
    
    public func setBottomInset(_ inset: CGFloat) {
        setInset(inset, top: false)
    }
    
    func setInset(_ inset: CGFloat, top: Bool) {
        var contentInsets = contentInset
        var scrollInsets = scrollIndicatorInsets
        
        if top {
            contentInsets.top = inset
            scrollInsets.top = inset
        } else {
            contentInsets.bottom = inset
            scrollInsets.bottom = inset
        }
        
        contentInset = contentInsets
        scrollIndicatorInsets = scrollInsets
    }
    
    public func scrollToTop(_ animated: Bool = false) {
        scrollRectToVisible(CGRect(x: 0, y: 0, width: 2, height: 2), animated: animated)
    }
    
    public var pageCount: Int {
        let width = bounds.width
        if width == 0 {
            return 0
        }
        return Int(ceil(contentSize.width / width))
    }
    
    public var pageIndex: Int {
        get {
            let width = bounds.width
            let index = round(contentOffset.x / width)
            return Int(index)
        }
        set {
            setPageIndex(pageIndex, animated: false)
        }
    }
    
    public func setPageIndex(_ pageIndex: Int, animated: Bool) {
        let width = bounds.width
        var offset = contentOffset
        offset.x = CGFloat(pageIndex) * width
        setContentOffset(offset, animated: animated)
    }
}
