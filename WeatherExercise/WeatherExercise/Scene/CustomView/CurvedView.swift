//
//  CurvedView.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 22/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

class CurvedView: UIView {
    
    //MARK:- Layers
    private var shapeLayer : CAShapeLayer = {
        let shape = CAShapeLayer()
        return shape
    }()
    
    //MARK:- public properties
    public var color: UIColor = .blue {
        didSet {
            shapeLayer.fillColor = color.cgColor
        }
    }
    
    //MARK:- Initialisers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayer.path = drawPath()
    }
    
    private func commonInit() {
        layer.addSublayer(shapeLayer)
        
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 20
        layer.shadowColor = UIColor.black.cgColor
    }
    
    private func drawPath()-> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        
        bezierPath.addLine(to: CGPoint(x: 0, y: bounds.maxY - bounds.maxY * 0.2))
        bezierPath.addCurve(to: CGPoint(x: bounds.maxX, y: bounds.maxY - bounds.maxY * 0.1), controlPoint1: CGPoint(x: bounds.midX * 0.8, y: bounds.maxY * 1.4), controlPoint2: CGPoint(x: bounds.maxX * 0.8, y: bounds.midY * 0.6))
        bezierPath.addLine(to: CGPoint(x: bounds.maxX, y: 0))
        bezierPath.close()
        return bezierPath.cgPath
    }
}
