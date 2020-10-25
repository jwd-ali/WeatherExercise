//
//  HourlyCollectionViewCell.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 23/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell, DequeueInitializable {
    
    //MARK:- Views
    private lazy var hourLabel = UILabelFactory.createUILabel(with: .universalColor5, font: UIFont.systemFont(ofSize: 14, weight: .regular), alignment: .center, text: "12")
    
     private lazy var icon = UIImageViewFactory.createImageView(mode: .scaleAspectFit, tintColor:.universalColor3 )
    
    private lazy var tempratureLabel = UILabelFactory.createUILabel(with: .universalColor5, font: UIFont.systemFont(ofSize: 14, weight: .regular), alignment: .center, text: "28°")
    
    private lazy var stack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fill, spacing: 2, arrangedSubviews: [hourLabel, icon, tempratureLabel])
    
    //MARK:- Properties
    private var viewModel: HourlyCollectionViewCellViewModelType?
    
    func config(viewModel: HourlyCollectionViewCellViewModelType) {
        self.viewModel = viewModel
        bind()
    }
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
        setupConstraints()
    }
}

// MARK: View setup

private extension HourlyCollectionViewCell {
    func setupViews() {
        contentView.addSubview(stack)
    }
    
    func setupConstraints() {
       stack
        .alignEdgesWithSuperview([.left, .right, .bottom, .top], constants:[0,0,5,5])
        
       icon
         .height(constant: 20)
         .width(constant: 20)
    }
    
}

private extension HourlyCollectionViewCell {
    
    func bind() {
        
        viewModel?.tempretureBinder.bind({[weak self] temp in DispatchQueue.main.async { self?.tempratureLabel.text = temp }})
        viewModel?.iconBinder.bind({[weak self] icon in DispatchQueue.main.async { self?.icon.image = icon.isEmpty ? nil :  UIImage(named: icon)?.withRenderingMode(.alwaysTemplate) }})
        viewModel?.timeBinder.bind({[weak self] temp in DispatchQueue.main.async { self?.hourLabel.text = temp }})
        
    }
    
}
