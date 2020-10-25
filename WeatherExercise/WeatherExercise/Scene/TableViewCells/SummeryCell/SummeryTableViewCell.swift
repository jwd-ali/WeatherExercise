//
//  SummeryTableViewCell.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 24/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//


import UIKit

class SummeryTableViewCell: UITableViewCell, DequeueInitializable {
    
    //MARK:- Views
    private lazy var summeryLabel = UILabelFactory.createUILabel(with: .universalColor6, font: UIFont.systemFont(ofSize: 18, weight: .regular), alignment: .center, numberOfLines : 0, lineBreakMode: .byWordWrapping,text: " ")
    
    private lazy var upperSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.universalColor6.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var lowerSeperator: UIView = {
           let view = UIView()
        view.backgroundColor = UIColor.universalColor6.withAlphaComponent(0.5)
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    //MARK:- Properties
    private var viewModel: SummeryTableViewCellViewModelType?
    
    func config(viewModel: SummeryTableViewCellViewModelType?) {
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

private extension SummeryTableViewCell {
    func setupViews() {
        contentView.addSubview(upperSeperator)
        contentView.addSubview(summeryLabel)
        contentView.addSubview(lowerSeperator)
    }
    
    func setupConstraints() {
        
        upperSeperator
            .alignEdgesWithSuperview([.top, .right, .left], constants:[30,20,20])
            .height(constant: 1)
        
        summeryLabel
            .toBottomOf(upperSeperator, constant:20)
            .alignEdgesWithSuperview([.right, .left], constants:[20,20])
        
        lowerSeperator
            .toBottomOf(summeryLabel, constant:20)
            .alignEdgesWithSuperview([.right, .left, .bottom], constants:[20,20,0])
            .height(constant: 1)
        
    }
    
}
private extension SummeryTableViewCell {
    
    func bind() {
        viewModel?.summeryBinder.bind({[weak self] summery in DispatchQueue.main.async { self?.summeryLabel.text = summery }})
    }
    
}
