//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import Foundation
import CoreLocation

// Forecast Model
struct Forecast: Codable {
    struct Daily: Codable{
        let dt: Date
        struct Temp: Codable {
            let min: Double
            let max: Double
        }
        let temp: Temp
        let pressure: Int
        let humidity: Int
        let wind_speed: Double
        let wind_deg: Int
        struct Weather: Codable{
            let id: Int
            let description: String
            let icon: String
        }
        let weather: [Weather]
        let clouds: Int
        let pop: Double
    }
    let daily: [Daily]
}

