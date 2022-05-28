//
//  SearchModel.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-23.
//

import Foundation
import CoreLocation

// Search model
struct Search: Codable {
    struct Current: Codable {
        let dt: Date
        let temp: Double
        let pressure: Int
        let humidity: Int
        let clouds: Int
        let wind_speed: Double
        let wind_deg: Int
        struct Weather: Codable {
            let id: Int
            let description: String
            let icon: String
            var weatherIconURL: URL {
                let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
                return URL(string: urlString)!
            }
        }
        let weather: [Weather]
    }
    let current: Current
}
