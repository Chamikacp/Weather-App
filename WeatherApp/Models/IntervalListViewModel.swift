//
//  IntervalListViewModel.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import CoreLocation
import Foundation
import SwiftUI

// Intnal list view model
class IntervalListViewModel: ObservableObject {
    
    struct AppError: Identifiable{
        let id = UUID().uuidString
        let errorString: String
    }
    
    @Published var intervals: [IntervalViewModel] = []
    var appError: AppError? = nil
    @Published var isLoading: Bool = false
    @AppStorage("locationInterval") var storageLocationInterval: String = ""
    @Published var locationInterval = ""
    @AppStorage("system") var system: Int = 0 {
        didSet {
            for i in 0..<intervals.count{
                intervals[i].system = system
            }
        }
    }
    
    init() {
        locationInterval = storageLocationInterval
        getWeatherForecast()
    }
    
    // Get data for evry 3 hours
    func getWeatherForecast() {
        storageLocationInterval = locationInterval
        UIApplication.shared.endEditing()
        if locationInterval == "" {
            intervals = []
        } else {
            isLoading = true
            let apiService = APIService.shared
            CLGeocoder().geocodeAddressString(locationInterval) {(placemarks, error) in
                if let error = error as? CLError {
                    switch error.code {
                        case .locationUnknown, .geocodeFoundNoResult, .geocodeFoundPartialResult:
                            self.appError = AppError(errorString: NSLocalizedString("Unable to find the location!", comment: ""))
                        case .network:
                            self.appError = AppError(errorString: NSLocalizedString("Check network connection!", comment: ""))
                        default:
                            self.appError = AppError(errorString: error.localizedDescription)
                    }
                    self.isLoading = false
                    print(error.localizedDescription)
                }
                if let lat = placemarks?.first?.location?.coordinate.latitude,
                   let lon = placemarks?.first?.location?.coordinate.longitude {
                    apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(API.API_KEY)", dateDecodingStrategy: .secondsSince1970) { (result: Result<Interval,APIService.APIError>) in
                        switch result {
                        case .success(let interval):
                            DispatchQueue.main.async {
                                self.isLoading = false
                                self.intervals = interval.list.map {IntervalViewModel(interval: $0, system: self.system)}
                            }
                        case .failure(let apiError):
                            switch apiError{
                            case .error(let errorString):
                                self.isLoading = false
                                self.appError = AppError(errorString: errorString)
                                print(errorString)
                            }
                        }
                    }
                }
            }
        }
    }
}


