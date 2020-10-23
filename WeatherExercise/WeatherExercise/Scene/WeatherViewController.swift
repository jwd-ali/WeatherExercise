//
//  ViewController.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 20/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Views
    private var curvedView: CurvedView = {
       let curve = CurvedView()
        curve.color = .universalColor5
        curve.translatesAutoresizingMaskIntoConstraints = false
        return curve
    }()
    
    private lazy var cityLabel = UILabelFactory.createUILabel(with: .universalColor2, font: UIFont.systemFont(ofSize: 30, weight: .heavy), alignment: .center, text: "SAN FRANCISCO")
    
    private lazy var summeryLabel = UILabelFactory.createUILabel(with: .universalColor2, font: UIFont.systemFont(ofSize: 18, weight: .regular), alignment: .center, text: "Clear")
    
    private lazy var stack = UIStackViewFactory.createStackView(with: .horizontal, alignment: .center, distribution: .fill, spacing: 5, arrangedSubviews: [icon, degreeLabel])
    
    private lazy var degreeLabel = UILabelFactory.createUILabel(with: .universalColor2, font: UIFont.systemFont(ofSize: 80, weight: .semibold), alignment: .center, text: "12°")
    
    private lazy var icon = UIImageViewFactory.createImageView(mode: .scaleAspectFit, image: #imageLiteral(resourceName: "rain").withRenderingMode(.alwaysTemplate), tintColor:.universalColor2 )
    
    // MARK: - Properties
   private var viewModel: WeatherViewModelType
    
    // MARK: - Init
    init(viewModel: WeatherViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setup()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .universalColor2
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

//MARK:- Setup View
private extension WeatherViewController {
    func setup() {
        setupViews()
        setupConstraints()
    }
    
     func setupViews() {
        view.addSubview(curvedView)
        
        curvedView.addSubview(cityLabel)
        curvedView.addSubview(summeryLabel)
        curvedView.addSubview(stack)
    }
    
    func setupConstraints() {
        
        curvedView
            .alignEdgesWithSuperview([.top, .right, .left])
            .height(constant: 300)
        
        cityLabel
            .alignEdgeWithSuperviewSafeArea(.top, constant:5)
            .alignEdgesWithSuperview([.right, .left], constant:20)
        
        summeryLabel
            .toBottomOf(cityLabel)
            .alignEdges([.left, .right], withView: cityLabel)
        
        stack
            .toBottomOf(summeryLabel, constant:10)
            .centerHorizontallyInSuperview()
        
    }
    
    func bind() {
    }
}
