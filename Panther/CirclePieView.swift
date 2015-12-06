//
//  CirclePieView.swift
//  CirclePieViewExample
//
//  Created by Mark Jackson on 10/8/15.
//  Copyright © 2015 Mark Jackson. All rights reserved.
//

import UIKit

@IBDesignable class CirclePieView: UIView {
    
    var baseColor : UIColor = Constants.Colors.BASE_COLOR
    
    //Values for each segment
    private var segmentValues : [Float]
    //Total for each segment
    private var segmentTotals : [Float]
    //Color for each segment
    private var segmentColors : [UIColor]
    //Sum of each segmentTotals element
    private var segmentTotalAll : Float
    
    //When creating the view in code
    override init(frame: CGRect) {
        segmentValues = []
        segmentTotals = []
        segmentColors = []
        segmentTotalAll = 0
        super.init(frame: frame)
    }
    
    //When creating the view in IB
    required init?(coder aDecoder: NSCoder) {
        segmentValues = []
        segmentTotals = []
        segmentColors = []
        segmentTotalAll = 0
        super.init(coder: aDecoder)
    }
    
    //Sets all the segment members in order to draw each segment
    func setSegmentValues(values : [ParkingLevel]){
        //Set the colors
        segmentColors = []
        segmentTotalAll = 0
        for i in 0...values.count - 1 {
            segmentTotalAll += Float(values[i].total)
            segmentTotals.append(Float(values[i].total))
            segmentValues.append(Float(values[i].available))
            let percentage = Float(values[i].available) / Float(values[i].total)
            if(1 - percentage >= 0.85){
                segmentColors.append(Constants.Colors.RED_COLOR)
            }else if(1 - percentage >= 0.55){
                segmentColors.append(Constants.Colors.YELLOW_COLOR)
            }else{
                segmentColors.append(Constants.Colors.GREEN_COLOR)
            }

        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        //Base circle
        baseColor.setFill()
        let outerPath = UIBezierPath(ovalInRect: rect)
        outerPath.fill()

        
        //Semicircles
        //self.frame isn't defined yet, so we can't use self.center
        let viewCenter = CGPointMake(rect.width / 2, rect.height / 2);
        var i = 0
        var lastAngle :Float = 0.0
        let baseCircleRadius = rect.width / 2
        let centerCircleRadius = rect.width / 2 * 0.55

        //value : current number
        for value in segmentValues {
            //total : total number
            let total = segmentTotals[safe: i]!
            
            //offsetTotal : difference between Base Circle and Center Circle
            let offset =  baseCircleRadius - centerCircleRadius
            
            //radius : radius of segment
            let radius = CGFloat(value / total) * offset + centerCircleRadius
            //startAngle : start angle of this segment
            let startAngle = lastAngle
            //endAngle : end angle of this segment
            let endAngle = lastAngle + total / segmentTotalAll * 360.0
            //color : color of the segment
            let color = segmentColors[safe: i]!
            color.setFill()
            
            let midPath = UIBezierPath()
            midPath.moveToPoint(viewCenter)
            
            midPath.addArcWithCenter(viewCenter, radius: CGFloat(radius), startAngle: startAngle.degreesToRadians, endAngle: endAngle.degreesToRadians, clockwise: true)
            
            midPath.closePath()
            midPath.fill()
            
            lastAngle = endAngle
            ++i
        }
        
        //Center circle
        UIColor.whiteColor().setFill()
        let centerPath = UIBezierPath(ovalInRect:
            CGRectInset(rect,
                centerCircleRadius,
                centerCircleRadius))
        centerPath.fill()
        
        UIColor(red: 234.0/255, green:  234.0/255, blue: 234.0/255, alpha: 1).setStroke()
        let lineLength = centerCircleRadius * 0.5
        let strokePath = UIBezierPath()
        strokePath.lineWidth = 2
        strokePath.moveToPoint(CGPointMake(viewCenter.x - lineLength / 2, viewCenter.y))
        strokePath.addLineToPoint(CGPointMake(viewCenter.x + lineLength / 2, viewCenter.y))
        strokePath.stroke()
    }
}

extension Float {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * CGFloat(M_PI) / 180.0
    }
}
