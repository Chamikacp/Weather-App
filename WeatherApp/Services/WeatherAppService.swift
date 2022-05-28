//
//  WeatherAppService.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import CoreLocation
import Foundation

// Weather api service
public final class WeatherAppService: NSObject {
    
    private let locationManager = CLLocationManager()
    private var completionHandler: ((Weather) -> Void)?
    
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)) {
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D){
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API.API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { return }
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data){
                self.completionHandler?(Weather(response: response))
            }
        }.resume()
    }
}

extension WeatherAppService: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        guard let location = locations.first else { return }
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("Something Went Wrong: \(error.localizedDescription)")
    }
}
