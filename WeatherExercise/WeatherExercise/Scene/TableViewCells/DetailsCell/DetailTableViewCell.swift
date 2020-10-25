//
//  DetailTableViewCell.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 24/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
import UIKit

class DetailTableViewCell: UITableViewCell, DequeueInitializable {
    
    //MARK:- Views
    private lazy var sunriseLabel = UILabelFactory.createUILabel(with: .universalColor3, font: UIFont.systemFont(ofSize: 18, weight: .regular), alignment: .center)
    
    private lazy var sunsetLabel = UILabelFactory.createUILabel(with: .universalColor3, font: UIFont.systemFont(ofSize: 18, weight: .regular), alignment: .center)
    
    private lazy var chanceOfRainLabel = UILabelFactory.createUILabel(with: .universalColor3, font: UIFont.systemFont(ofSize: 18, weight: .regular), alignment: .center)
    
    private lazy var humidityLabel = UILabelFactory.createUILabel(with: .universalColor3, font: UIFont.systemFont(ofSize: 18, weight: .regular), alignment: .center)
    
    private lazy var windLabel = UILabelFactory.createUILabel(with: .universalColor3, font: UIFont.systemFont(ofSize: 18, weight: .regular), alignment: .center)
    
    private lazy var presureLabel = UILabelFactory.createUILabel(with: .universalColor3, font: UIFont.systemFont(ofSize: 18, weight: .regular), alignment: .center)
    
    private lazy var visibilityLabel = UILabelFactory.createUILabel(with: .universalColor3, font: UIFont.systemFont(ofSize: 18, weight: .regular), alignment: .center)
    
    private lazy var uvIndexLabel = UILabelFactory.createUILabel(with: .universalColor3, font: UIFont.systemFont(ofSize: 18, weight: .regular), alignment: .center, numberOfLines : 0, lineBreakMode: .byWordWrapping,text: " ")
    
    private lazy var timingStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fillEqually, spacing: 0, arrangedSubviews: [sunriseLabel,sunsetLabel])
    
    private lazy var rainStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fillEqually, spacing: 0, arrangedSubviews: [chanceOfRainLabel,humidityLabel])
    
    private lazy var windStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fillEqually, spacing: 0, arrangedSubviews: [windLabel,presureLabel])
    
    private lazy var visibilityStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fillEqually, spacing: 0, arrangedSubviews: [visibilityLabel,uvIndexLabel])
    
    
    private lazy var mainStack = UIStackViewFactory.createStackView(with: .vertical, alignment: .center, distribution: .fill, spacing: 20, arrangedSubviews: [timingStack, rainStack, windStack, visibilityStack])
    
    
    
    //MARK:- Properties
    private var viewModel: DetailTableViewCellViewModelType?
    
    func config(viewModel: DetailTableViewCellViewModelType?) {
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

private extension DetailTableViewCell {
    func setupViews() {
        contentView.addSubview(mainStack)
    }
    
    func setupConstraints() {
        mainStack
            .alignEdgesWithSuperview([.left, .right, .top, .bottom], constant:20)
    }
    
}
private extension DetailTableViewCell {
    
    func bind() {
        viewModel?.sunriseBinder.bind({[weak self] val in DispatchQueue.main.async { self?.sunriseLabel.text = val }})
        viewModel?.sunsetBinder.bind({[weak self] val in DispatchQueue.main.async { self?.sunsetLabel.text = val }})
        viewModel?.chanceOfRainBinder.bind({[weak self] val in DispatchQueue.main.async { self?.chanceOfRainLabel.text = val }})
        viewModel?.humidityBinder.bind({[weak self] val in DispatchQueue.main.async { self?.humidityLabel.text = val }})
        viewModel?.windBinder.bind({[weak self] val in DispatchQueue.main.async { self?.windLabel.text = val }})
        viewModel?.pressureBinder.bind({[weak self] val in DispatchQueue.main.async { self?.presureLabel.text = val }})
        viewModel?.visibilityBinder.bind({[weak self] val in DispatchQueue.main.async { self?.visibilityLabel.text = val }})
        viewModel?.uvIndexBinder.bind({[weak self] val in DispatchQueue.main.async { self?.uvIndexLabel.text = val }})
    }
    
}
