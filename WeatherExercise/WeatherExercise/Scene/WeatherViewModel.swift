//
//  WeatherViewModel.swift
//  WeatherExercise
//
//  Created by Jawad Ali on 22/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation

enum WeatherCellItemType {
    case dailyCell
    case summeryCell
    case detailCell
}

protocol WeatherCellItem {
    var type: WeatherCellItemType { get }
}

protocol WeatherViewModelType {
    var isLoading : Binder<Bool> { get }
    var cityBinder: Binder<String> { get }
    var summeryBinder: Binder<String> { get }
    var tempretureBinder: Binder<String> { get }
    var iconBinder: Binder<String> { get }
    var reloadTableViewBinder: Binder<Void> { get }
    var reloadCollectionViewViewBinder: Binder<Void> { get }
    var openSettings:Binder<Bool?> { get }
    var onShowError:Binder<AppAlert?> { get }
    func numberOfRowsForTableView()-> Int
    func numberOfRowsForCollectionView()->Int
    func tableViewModel(at indexPath: IndexPath)-> WeatherCellItem
    func collectionViewModel(at indexPath: IndexPath)-> HourlyCollectionViewCellViewModel
    func refreshButtonTapped()
}

class WeatherViewModel: WeatherViewModelType {
    
    //MARK:- Propeerties
    private var respostry: WeatherRepositoryType
    private var locationHandler: LocationHandler?
    private var weatherObject: SegregatedWeatherModel?
    private var latitude: Double!
    private var longitude: Double!
    
    
    private  var tableViewModels: [WeatherCellItem] = [] {
        didSet {
            reloadTableViewBinder.set(to: ())
        }
    }
    private  var collectionViewModels: [HourlyCollectionViewCellViewModel] = []{
        didSet {
            reloadCollectionViewViewBinder.set(to: ())
        }
    }
    
    //MARK:- Binders
    var cityBinder = Binder("")
    var summeryBinder = Binder("")
    var tempretureBinder = Binder("")
    var iconBinder = Binder("")
    var reloadTableViewBinder = Binder(())
    var reloadCollectionViewViewBinder = Binder(())
    var isLoading = Binder(false)
    var onShowError = Binder<AppAlert?>(nil)
    var openSettings = Binder<Bool?>(nil)
    
    //MARK:- Initializer
    init(locationHandler: LocationHandler, respostry:WeatherRepositoryType) {
        self.respostry = respostry
        self.locationHandler = locationHandler
        
        isLoading.value = true
        self.locationHandler?.getCurrentLocation {[weak self] (location, error) in
            if let locationError = error {
                
                switch locationError {
                case .accessDeniedByUser, .locationServicesNotEnableOnDevice:
                    let alert =  AppAlert(title: "Access Denied", message: "You need to turn on Location Service to use this app! Please go to Settings and grant Location permission to Weather.", actions: [AlertAction(buttonTitle: "Go to Settings", handler: {self?.openSettings.set(to: (true))})])
                    self?.onShowError.value = alert
                case .failed:
                    let alert =  AppAlert(title: "Please Grant Access", message: "To view your current location weather you need to give me Location permission.", actions: [AlertAction(buttonTitle: "Grant permission", handler: {self?.locationHandler?.requestPermission()})])
                    self?.onShowError.value = alert
                case .notDetermined:
                    self?.locationHandler?.requestPermission()
                }
                
                return
            }
            
            
            if let local = location {
                self?.latitude = local.coordinate.latitude
                self?.longitude = local.coordinate.longitude
                
                self?.getDetails()
            }
        }
        
        commonInit()
    }
    
    init(latitude:Double, longitude:Double, respostry:WeatherRepositoryType) {
        self.respostry = respostry
        self.latitude = latitude
        self.longitude = longitude
        
        getDetails()
        commonInit()
    }
    
    private func commonInit() {
        bindValues()
    }
}

private extension WeatherViewModel {
    func getDetails() {
        self.getWeatherDetails()
        self.fetchAndBindCity()
    }
    
    func getWeatherDetails() {
        self.respostry.getWeatherDetails(latitude: latitude, longitude: (longitude)) { [weak self] (result) in
            self?.isLoading.value = false
            self?.parseResponse(result:result)
        }
    }
    
    func parseResponse(result: Result<WeatherModel,AppError>) {
        switch result {
        case .failure(let error):
            let alert =  AppAlert(title: "Error", message: error.error, actions: [AlertAction(buttonTitle: "OK", handler: nil)])
            self.onShowError.value = alert
        case .success( let model):
            self.weatherObject = model
            bindValues()
            createViewModels()
        }
    }
    
    func fetchAndBindCity()  {
        self.locationHandler?.fetchCityAndCountry(lattitude: latitude, longitude: longitude, completion:  {[weak self] (city, _, error) in if let getCity = city { self?.cityBinder.value = getCity.uppercased() } })
    }
}
private extension WeatherViewModel {
    func bindValues() {
        summeryBinder.value = weatherObject?.currently?.summary?.lowercased() ?? ""
        tempretureBinder.value = ("\(self.weatherObject?.currently?.temperature?.convertFahrenheitToCelsius() ?? 0)°")
        iconBinder.value = weatherObject?.currently?.icon?.rawValue ?? ""
    }
    
}
private extension WeatherViewModel {
    func createViewModels() {
        if let dailydata = weatherObject?.daily?.data {
            tableViewModels = dailydata.map({ DailyTableViewCellViewModel(with: $0) })
        }
        
        if let hourlyData = weatherObject?.hourly?.data {
            collectionViewModels = hourlyData.map({ HourlyCollectionViewCellViewModel(with: $0) })
        }
        
        if let summery = weatherObject?.hourly?.summary {
            tableViewModels.append(SummeryTableViewCellViewModel(with:  summery))
        }
        
        if let details = weatherObject?.daily?.data?.first {
            tableViewModels.append(DetailTableViewCellViewModel(with:  details))
        }
    }
}
extension WeatherViewModel {
    func numberOfRowsForTableView() -> Int {
        tableViewModels.count
    }
    
    func numberOfRowsForCollectionView() -> Int {
        collectionViewModels.count
    }
    
    func tableViewModel(at indexPath: IndexPath) -> WeatherCellItem {
        tableViewModels[indexPath.row]
    }
    
    func collectionViewModel(at indexPath: IndexPath) -> HourlyCollectionViewCellViewModel {
        collectionViewModels[indexPath.row]
    }
}

//MARK:- Actions From controller
extension WeatherViewModel {
    func refreshButtonTapped() {
        getDetails()
        
    }
}
