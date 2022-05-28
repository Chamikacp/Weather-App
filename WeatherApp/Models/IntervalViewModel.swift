//
//  IntervalViewModel.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import Foundation

// Interval view model
struct IntervalViewModel {
    let interval: Interval.List
    var system: Int
    
    //Static Date Formatter for Date Values
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d, HH:mm"
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
        return celsius
    }
    
    var day: String {
        return Self.dateFormatter.string(from: interval.dt)
    }
    
    var overview: String{
        interval.weather[0].description.capitalized
    }
    
    var temp: String {
        return "\(Self.numberFormatter.string(for: convert(interval.main.temp)) ?? "0")°"
    }
    
    var weatherIconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(interval.weather[0].icon)@2x.png"
        return URL(string: urlString)!
    }
}
