//
//  WeatherViewModelTests.swift
//  WeatherExerciseTests
//
//  Created by Jawad Ali on 26/10/2020.
//  Copyright © 2020 Jawad Ali. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherExercise
class WeatherViewModelTests: XCTestCase {
    var sut: WeatherViewModelType!
    var repository: WeatherRepositoryType!
    var location: LocationHandler!
    
    override func setUpWithError() throws {
        repository = WeatherRepositoryMocked()
        location = MockLocationManager()
        sut = WeatherViewModel(locationHandler: location, respostry: repository)
    }
    
    override func tearDownWithError() throws {
        repository = nil
        sut = nil
        location = nil
    }
    
    func test_view_model_creation_success() {
        sut.refreshButtonTapped()
        XCTAssertEqual(sut.numberOfRowsForTableView(),3)
    }
    
    func test_collection_view_creation_success() {
           sut.refreshButtonTapped()
           XCTAssertEqual(sut.numberOfRowsForCollectionView(),1)
       }
    
    func test_location_handler_return_expected_location() {
        location.getCurrentLocation { (location, error) in
            XCTAssertEqual(location?.coordinate.latitude, 37.3317)
            XCTAssertEqual(location?.coordinate.longitude, -122.0325086)
            
        }
    }
    
    func test_table_model_exists_at_indexpath() {
        XCTAssertNotNil(sut.tableViewModel(at: IndexPath(item: 0, section: 0)))
    }
    
    func test_collection_model_exists_at_indexpath() {
           XCTAssertNotNil(sut.collectionViewModel(at: IndexPath(item: 0, section: 0)))
       }
}
