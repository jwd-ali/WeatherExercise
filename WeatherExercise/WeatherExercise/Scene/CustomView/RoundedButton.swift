//
//  RoundedButton.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 24/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit
class RoundedButton: UIButton {
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.universalColor3.cgColor
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }

  

    func updateCornerRadius() {
        layer.cornerRadius = bounds.maxY / 2
    }
}
