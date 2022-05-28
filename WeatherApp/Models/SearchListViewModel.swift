//
//  SearchListViewModel.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-23.
//

import CoreLocation
import Foundation
import SwiftUI

// Seach list view model
class SearchListViewModel: ObservableObject {
    
    @Published var temperature: String = "__"
    @Published var pressure: String = "__"
    @Published var humidity: String = "__"
    @Published var windSpeed: String = "__"
    @Published var windDirection: String = "__"
    @Published var clouds: String = "__"
    
    struct AppError: Identifiable{
        let id = UUID().uuidString
        let errorString: String
    }
    
    @Published var search: Search?
    var appError: AppError? = nil
    @Published var isLoading: Bool = false
    @AppStorage("searchLocation") var storageSearchLocation: String = ""
    @Published var location = ""
    @AppStorage("system") var system: Int = 0
    
    init() {
        location = storageSearchLocation
        getWeatherForecast()
        search = search
    }
    
    func clear() {
        self.temperature = "__"
        self.pressure = "__"
        self.humidity = "__"
        self.windSpeed = "__"
        self.windDirection = "__"
        self.clouds = "__"
    }
    
    // Get forecastinf data for 5 days
    func getWeatherForecast() {
        storageSearchLocation = location
        UIApplication.shared.endEditing()
        if location != "" {
            isLoading = true
            let apiService = APIService.shared
            CLGeocoder().geocodeAddressString(location) {(placemarks, error) in
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
                    var unit = ""
                    if self.system == 0 {
                        unit = "metric"
                    } else {
                        unit = "imperial"
                    }
                    apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&units=\(unit)&exclude=minutely,hourly,daily,alerts&appid=\(API.API_KEY)", dateDecodingStrategy: .secondsSince1970) {(result: Result<Search, APIService.APIError>) in
                        switch result {
                        case .success(let search):
                            DispatchQueue.main.async {
                                self.isLoading = false
                                self.search = search
                                self.temperature = "\(search.current.temp)"
                                self.pressure = "\(search.current.pressure)"
                                self.humidity = "\(search.current.humidity)"
                                self.windSpeed = "\(search.current.wind_speed)"
                                self.windDirection = "\(search.current.wind_deg)"
                                self.clouds = "\(search.current.clouds)"
                                
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

