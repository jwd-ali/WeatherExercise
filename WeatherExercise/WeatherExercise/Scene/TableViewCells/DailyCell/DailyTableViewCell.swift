//
//  DailyTableViewCell.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 23/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell, DequeueInitializable {
    
    //MARK:- Views
     private lazy var dayLabel = UILabelFactory.createUILabel(with: .universalColor6, font: UIFont.systemFont(ofSize: 20, weight: .regular), alignment: .left)
    
    private lazy var icon = UIImageViewFactory.createImageView(mode: .scaleAspectFit, tintColor:.universalColor6 )
    
    private lazy var maxTemperatureLabel = UILabelFactory.createUILabel(with: .universalColor6, font: UIFont.systemFont(ofSize: 16, weight: .regular), alignment: .center)
    
    private lazy var minTemperatureLabel = UILabelFactory.createUILabel(with: .universalColor6, font: UIFont.systemFont(ofSize: 16, weight: .regular), alignment: .center)
    
    private lazy var tempratureStack = UIStackViewFactory.createStackView(with: .horizontal, alignment: .center, distribution: .fillEqually, spacing: 5, arrangedSubviews: [maxTemperatureLabel, minTemperatureLabel])
    
    //MARK:- Properties
    private var viewModel: DailyTableViewCellViewModelType?
    
    func config(viewModel: DailyTableViewCellViewModelType?) {
        self.viewModel = viewModel
        bind()
    }
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        selectionStyle = .none
        
        setupViews()
        setupConstraints()
    }
    
}

private extension DailyTableViewCell {
    func setupViews() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(icon)
        contentView.addSubview(tempratureStack)
    }
    
    func setupConstraints() {
        dayLabel
            .alignEdgesWithSuperview([.bottom, .top, .left], constants:[10, 10, 20])
        
        icon
          .centerInSuperView()
          .height(constant: 30)
          .width(constant: 30)
        
        tempratureStack
            .alignEdgesWithSuperview([.top, .bottom, .right], constants:[5, 5, 20])
        
    }
    
}
private extension DailyTableViewCell {
    
    func bind() {
        viewModel?.minTempretureBinder.bind({[weak self] temp in DispatchQueue.main.async { self?.minTemperatureLabel.text = temp }})
        viewModel?.maxTempretureBinder.bind({[weak self] temp in DispatchQueue.main.async { self?.maxTemperatureLabel.text = temp }})
        viewModel?.iconBinder.bind({[weak self] icon in DispatchQueue.main.async { self?.icon.image = icon.isEmpty ? nil :  UIImage(named: icon)?.withRenderingMode(.alwaysTemplate) }})
        viewModel?.timeBinder.bind({[weak self] temp in DispatchQueue.main.async { self?.dayLabel.text = temp }})
        
    }
    
}
