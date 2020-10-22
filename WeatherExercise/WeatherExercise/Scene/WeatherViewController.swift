//
//  ViewController.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 20/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - Properties
    var viewModel: WeatherViewModelType
    
    // MARK: - Init
    init(viewModel: WeatherViewModelType) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

