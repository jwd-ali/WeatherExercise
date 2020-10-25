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
    
    private lazy var cityLabel = UILabelFactory.createUILabel(with: .universalColor2, font: UIFont.systemFont(ofSize: 30, weight: .heavy), alignment: .center)
    
    private lazy var summeryLabel = UILabelFactory.createUILabel(with: .universalColor2, font: UIFont.systemFont(ofSize: 12, weight: .medium), alignment: .center)
    
    private lazy var stack = UIStackViewFactory.createStackView(with: .horizontal, alignment: .center, distribution: .fill, spacing: 5, arrangedSubviews: [icon, tempretureLabel])
    
    private lazy var tempretureLabel = UILabelFactory.createUILabel(with: .universalColor2, font: UIFont.systemFont(ofSize: 80, weight: .semibold), alignment: .center)
    
    private lazy var icon = UIImageViewFactory.createImageView(mode: .scaleAspectFit, image: #imageLiteral(resourceName: "rain").withRenderingMode(.alwaysTemplate), tintColor:.universalColor2 )
    
     private lazy var forcastLabel = UILabelFactory.createUILabel(with: .universalColor5, font: UIFont.systemFont(ofSize: 20, weight: .medium), alignment: .center, text: "Hourly forcast")
    
    private lazy var refreshButton: UIButton = {
        let button = RoundedButton(type: .custom)
        button.backgroundColor = .universalColor2
        let largeRefresh = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
        let largeBoldRefresh = UIImage(systemName: "arrow.clockwise", withConfiguration: largeRefresh)
        button.setImage(largeBoldRefresh, for: .normal)
        button.tintColor = .universalColor5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var upperSeperator: UIView = {
           let view = UIView()
           view.backgroundColor = UIColor.universalColor6.withAlphaComponent(0.5)
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
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
        view.backgroundColor = .universalColor1
        super.viewDidLoad()
    }
    
    @objc func refreshFeed() {
        viewModel.refreshButtonTapped()
    }
}

//MARK:- Setup View
private extension WeatherViewController {
    func setup() {
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.reuseableIdentifier)
        
        tableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.reuseableIdentifier)
        tableView.register(SummeryTableViewCell.self, forCellReuseIdentifier: SummeryTableViewCell.reuseableIdentifier)
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.reuseableIdentifier)
        
        refreshButton.addTarget(self, action: #selector(refreshFeed), for: .touchUpInside)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubview(curvedView)
        view.addSubview(refreshButton)
        view.addSubview(forcastLabel)
        view.addSubview(collectionView)
        view.addSubview(tableView)
        view.addSubview(upperSeperator)
        
        curvedView.addSubview(cityLabel)
        curvedView.addSubview(summeryLabel)
        curvedView.addSubview(stack)
        
    }
    
    func setupConstraints() {
        
        curvedView
            .alignEdgesWithSuperview([.top, .right, .left])
            .height(constant: 300)
        
        refreshButton
            .alignEdge(.bottom, withView: curvedView, constant: -14)
            .alignEdgeWithSuperview(.left, constant:50)
            .height(constant: 50)
            .width(constant: 50)
        
        cityLabel
            .alignEdgeWithSuperviewSafeArea(.top, constant:5)
            .alignEdgesWithSuperview([.right, .left], constant:20)
        
        summeryLabel
            .toBottomOf(cityLabel)
            .alignEdges([.left, .right], withView: cityLabel)
        
        stack
            .toBottomOf(summeryLabel, constant:25)
            .centerHorizontallyInSuperview()
        
       forcastLabel
        .toBottomOf(curvedView, constant:15)
        .alignEdgesWithSuperview([.left, .right], constant: 20)
        
        
        collectionView
            .toBottomOf(forcastLabel, constant:5)
            .height(constant: 70)
            .alignEdgesWithSuperview([.left, .right])
        
        tableView
            .toBottomOf(upperSeperator, constant:20)
            .alignEdgesWithSuperview([.left, .right])
            .alignEdgeWithSuperviewSafeArea(.bottom)
        
        upperSeperator
            .toBottomOf(collectionView, constant:10)
            .alignEdgesWithSuperview([.right, .left], constants:[20,20])
            .height(constant: 1)
        
        
    }
    
    func bind() {
        viewModel.cityBinder.bind({ [weak self] city in DispatchQueue.main.async { self?.cityLabel.text = city }})
        viewModel.tempretureBinder.bind({[weak self] temp in DispatchQueue.main.async { self?.tempretureLabel.text = temp }})
        viewModel.summeryBinder.bind({[weak self] summery in DispatchQueue.main.async { self?.summeryLabel.text = summery }})
        viewModel.iconBinder.bind({[weak self] icon in DispatchQueue.main.async { self?.icon.image = icon.isEmpty ? nil :  UIImage(named: icon)?.withRenderingMode(.alwaysTemplate) }})
        viewModel.reloadCollectionViewViewBinder.bind({ [weak self] in DispatchQueue.main.async { self?.collectionView.reloadData() }})
        viewModel.reloadTableViewBinder.bind({ [weak self] in DispatchQueue.main.async { self?.tableView.reloadData() }})
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsForTableView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     let vm = viewModel.tableViewModel(at: indexPath)
        
        switch vm.type {
        case .dailyCell:
            let cell = DailyTableViewCell.dequeue(tableView: tableView)
            cell.config(viewModel: viewModel.tableViewModel(at: indexPath) as? DailyTableViewCellViewModel)
            return cell
        case .summeryCell:
            let cell = SummeryTableViewCell.dequeue(tableView: tableView)
            cell.config(viewModel: viewModel.tableViewModel(at: indexPath) as? SummeryTableViewCellViewModelType)
            return cell
        case .detailCell:
            let cell = DetailTableViewCell.dequeue(tableView: tableView)
            cell.config(viewModel: viewModel.tableViewModel(at: indexPath) as? DetailTableViewCellViewModelType)
            return cell
        }
        
       
    }
    
    
}

extension WeatherViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRowsForCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = HourlyCollectionViewCell.dequeue(collectionView: collectionView, indexPath: indexPath)
        cell.config(viewModel: viewModel.collectionViewModel(at: indexPath))
        return cell
    }
    
    
}
extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: collectionView.bounds.height)
    }
}

//MARK:- DarkMood
extension WeatherViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
               curvedView.color = .universalColor5
           }
}
