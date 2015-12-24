//
//  GeometryExtensions.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 23/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import Foundation

extension CGRect {
    var maxSquareRectInside: CGRect {
        let minSize = min(self.width, self.height)
        let widthLeftover = (self.width - minSize)/2
        let heightLeftover = (self.height - minSize)/2
        
        return CGRect(x: widthLeftover, y: heightLeftover, width: minSize, height: minSize)
    }
    
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

extension CGSize {
    var CGPointValue: CGPoint {
        return CGPoint(x: self.width, y: self.height)
    }
}

extension CGPoint {
    var CGSizeValue: CGSize {
        return CGSize(width: self.x, height: self.y)
    }
}

extension CGFloat {
    func angleInRadian() -> CGFloat {
        return self * CGFloat(M_PI)/180
    }
}

func *(left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x * right, y: left.y * right)
}

func /(left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x / right, y: left.y / right)
}

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func /(left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width / right, height: left.height / right)
}

func *(left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
}