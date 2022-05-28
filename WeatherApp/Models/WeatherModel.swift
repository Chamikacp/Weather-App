//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import Foundation

// Weather model
public struct Weather {
    let city: String
    let temprature: String
    let description: String
    let iconName: String
    let pressure: String
    let humidity: String
    let windSpeed: String
    let windDirection: String
    let country: String
    let sunrise: Date
    let sunset: Date
    
    init(response: APIResponse) {
        city = response.name
        temprature = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
        pressure = "\(Int(response.main.pressure))"
        humidity = "\(Int(response.main.humidity))"
        windSpeed = "\(Int(response.wind.speed))"
        windDirection = "\(Int(response.wind.deg))"
        country = response.sys.country
        sunrise = response.sys.sunrise
        sunset = response.sys.sunset
    }
}

struct APIResponse: Decodable{
    let name: String
    let main: APIMain
    let wind: APIWind
    let sys: APISys
    let weather: [APIWeather]
}

struct APIMain: Decodable {
    let temp: Double
    let pressure: Int
    let humidity: Int
}

struct APIWind: Decodable {
    let speed: Double
    let deg: Int
}

struct APISys: Decodable {
    let country: String
    let sunrise: Date
    let sunset: Date
}

struct APIWeather: Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    }
}
