//
//  IntervalModel.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import Foundation
import CoreLocation

// interval model
struct Interval: Codable {
    struct List: Codable{
        let dt: Date
        struct Main: Codable{
            let temp: Double
        }
        let main: Main
        struct Weather: Codable{
            let id: Int
            let description: String
            let icon: String
        }
        let weather: [Weather]
    }
    let list: [List]
}

