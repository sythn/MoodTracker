//
//  TimeScaleView.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 22/12/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable
public class TimeScaleView: UIView {
    
    @IBInspectable public var insideScale: CGFloat = 0.3
    @IBInspectable public var minScale: CGFloat = 0.5
    
    public var dataPoints: [TimeScaleDataPoint] = [] {
        didSet {
            updateSlices()
        }
    }
    
    public var circleColor: UIColor?
    
    var chartLayer = CALayer()
    var slices = [CAShapeLayer]()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        updateSlices()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
        updateSlices()
    }
    
    public override func layoutSubviews() {
        updateSlices()
        super.layoutSubviews()
    }
    
    func setUp() {
        self.layer.addSublayer(self.chartLayer)
        self.layer.backgroundColor = UIColor.clearColor().CGColor
        self.backgroundColor = UIColor.clearColor()
        
        let ovalRect = self.bounds.maxSquareRectInside
        fillHoleInTheMiddleWithRect(ovalRect.insetBy(dx: 10, dy: 10))
    }
    
    func updateSlices() {
        self.setNeedsDisplay()
        
        let totalPointsCount = dataPoints.reduce(0, combine: { $0 + $1.value })
        let angleForValue = 360 / totalPointsCount

        var currentAngle: CGFloat = -90
        
        for slice in slices {
            slice.removeFromSuperlayer()
        }
        
        let ovalRect = self.bounds.maxSquareRectInside
        let center = ovalRect.size.CGPointValue / 2
        
        slices = dataPoints.map { point in
            
            let angle = point.value * angleForValue
            let radiusScale = point.scale == 0 ? 0 : point.scale * (1 - minScale) + minScale
            
            let path = UIBezierPath(arcCenter: center, radius: center.x * radiusScale, startAngle: currentAngle.angleInRadian(), endAngle: currentAngle.angleInRadian() + angle.angleInRadian(), clockwise: true)
            path.addLineToPoint(center)
            
            currentAngle += angle
            
            let slice = CAShapeLayer()
            slice.path = path.CGPath
            slice.fillColor = point.color.CGColor
    
            slice.position = ovalRect.origin
            
            self.chartLayer.addSublayer(slice)
            
            return slice
            
        }
        
        punchAHoleInTheMiddleWithRect(ovalRect)
        resetCircleLayerWithRect(ovalRect.insetBy(dx: 20, dy: 20))
    }
    
    var circleLayer: CAShapeLayer!
    func fillHoleInTheMiddleWithRect(rect: CGRect) {
        let center = rect.size.CGPointValue / 2
        circleLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: center, radius: center.x * insideScale, startAngle: 0, endAngle: CGFloat(360).angleInRadian(), clockwise: true)
        circleLayer.path = circlePath.CGPath
        circleLayer.fillColor = UIColor.blueColor().CGColor
        circleLayer.position = rect.origin
        
        self.layer.addSublayer(circleLayer)
    }
    
    func resetCircleLayerWithRect(rect: CGRect) {
        let center = rect.size.CGPointValue / 2
        let circlePath = UIBezierPath(arcCenter: center, radius: center.x * insideScale, startAngle: 0, endAngle: CGFloat(360).angleInRadian(), clockwise: true)
        circleLayer.path = circlePath.CGPath
        circleLayer.position = rect.origin
        
        if let color = circleColor {
            circleLayer.fillColor = color.CGColor
        }
    }
    
    func punchAHoleInTheMiddleWithRect(rect: CGRect) {
        let center = rect.size.CGPointValue / 2
        let midClip = CAShapeLayer()
        let clipPath = UIBezierPath(arcCenter: center, radius: center.x * insideScale, startAngle: 0, endAngle: CGFloat(360).angleInRadian(), clockwise: true)
        clipPath.appendPath(UIBezierPath(rect: layer.bounds))
        midClip.path = clipPath.CGPath
        midClip.position = rect.origin
        midClip.fillRule = kCAFillRuleEvenOdd
        
        self.chartLayer.mask = midClip
    }
    
    
}
