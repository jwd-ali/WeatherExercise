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
    var cityBinder: Binder<String> { get }
    var summeryBinder: Binder<String> { get }
    var tempretureBinder: Binder<String> { get }
    var iconBinder: Binder<String> { get }
    var reloadTableViewBinder: Binder<Void> { get }
    var reloadCollectionViewViewBinder: Binder<Void> { get }
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
    
    //MARK:- Initializer
    init(locationHandler: LocationHandler, respostry:WeatherRepositoryType) {
        self.respostry = respostry
        self.locationHandler = locationHandler
        
        self.locationHandler?.getCurrentLocation {[weak self] (location, error) in
            if let locationError = error {
                print(locationError)
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
            self?.parseResponse(result:result)
        }
    }
    
    func parseResponse(result: Result<WeatherModel,AppError>) {
        switch result {
        case .failure(let error):
            print("error:\(error)")
        case .success( let model):
            self.weatherObject = model
            bindValues()
            createViewModels()
        }
    }
    
    func fetchAndBindCity()  {
        self.locationHandler?.fetchCityAndCountry(lattitude: latitude, longitude: longitude, completion:  {[weak self] (city, _, error) in if let getCity = city { self?.cityBinder.value = getCity } })
    }
}
private extension WeatherViewModel {
     func bindValues() {
        summeryBinder.value = weatherObject?.currently?.summary ?? ""
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
