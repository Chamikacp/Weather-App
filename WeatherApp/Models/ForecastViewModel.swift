//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import Foundation

// Forecast view model
struct ForecastViewModel {
    let forecast: Forecast.Daily
    var system: Int
    
    //Static Date Formatter for Date Values
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MM, d"
        return dateFormatter
    }
    
    //Static Number Formatter for Double Values
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    //Static Number Formatter for Double Values
    private static var numberFormatterPercentage: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    func convert(_ temp: Double) -> Double {
        let celsius = temp - 273.5
        if system == 0 {
            return celsius
        }else{
            return celsius * 9 / 5 + 32
        }
    }
    
    func convertSpeed(_ speed: Double) -> Double {
        if system == 0 {
            return speed
        }else{
            return speed * 2.237
        }
    }
    
    var day: String {
        return Self.dateFormatter.string(from: forecast.dt)
    }
    
    var overview: String{
        forecast.weather[0].description.capitalized
    }
    
    var high: String {
        if system == 0 {
            return "\(Self.numberFormatter.string(for: convert(forecast.temp.max)) ?? "0")°C"
        } else {
            return "\(Self.numberFormatter.string(for: convert(forecast.temp.max)) ?? "0")°F"
        }
    }
    
    var low: String {
        if system == 0 {
            return "\(Self.numberFormatter.string(for: convert(forecast.temp.min)) ?? "0")°C"
        } else {
            return "\(Self.numberFormatter.string(for: convert(forecast.temp.min)) ?? "0")°F"
        }
        
    }
    
    var humidity: String {
        return "\(Self.numberFormatterPercentage.string(for: forecast.humidity) ?? "0%")"
    }
    
    var pressure: String {
        return "\(forecast.pressure) hPa"
    }
    
    var windSpeed: String {
        if system == 0 {
            return "\(Self.numberFormatter.string(for: convertSpeed(forecast.wind_speed)) ?? "0") m/s"
        } else {
            return "\(Self.numberFormatter.string(for: convertSpeed(forecast.wind_speed)) ?? "0") mi/h"
        }
    }
    
    var windDirection: String {
        return "\(forecast.wind_deg) W"
    }
    
    var clouds: String {
        return "\(forecast.clouds) %"
    }
    
    var weatherIconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
        return URL(string: urlString)!
    }
}
