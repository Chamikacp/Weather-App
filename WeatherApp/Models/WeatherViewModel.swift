//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import Foundation

private let defaultIcon = "❔"
private let iconMap = [
    "Drizzle": "🌨",
    "Thunderstorm": "⛈",
    "Rain": "🌧",
    "Snow": "❄️",
    "Clear": "☀️",
    "Clouds": "☁️",
    "Mist": "🌫",
]

// Weather view model
public class WeatherViewModel: ObservableObject {
    @Published var cityName:  String = "__"
    @Published var temperature: String = "__"
    @Published var weatherDescription: String = "__"
    @Published var weatherIcon: String = defaultIcon
    @Published var pressure: String = "__"
    @Published var humidity: String = "__"
    @Published var windSpeed: String = "__"
    @Published var windDirection: String = "__"
    @Published var country: String = "__"
    @Published var sunrise: Date = Date()
    @Published var sunset: Date = Date()
    
    public let weatherService: WeatherAppService
    private var intervalListVM = IntervalListViewModel()
    
    public init(weatherService: WeatherAppService){
        self.weatherService = weatherService
    }
    
    @Sendable public func refresh() {
        weatherService.loadWeatherData {weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = "\(weather.temprature)°C"
                self.weatherDescription = weather.description.capitalized
                self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
                self.pressure = "\(weather.temprature) hPa"
                self.humidity = "\(weather.humidity) %"
                self.windSpeed = "\(weather.windSpeed) m/s"
                self.windDirection = "\(weather.windDirection) W"
                self.country = "\(weather.country)"
                self.sunrise = weather.sunrise
                self.sunrise = weather.sunrise
                self.intervalListVM.locationInterval = weather.city
                self.intervalListVM.getWeatherForecast()
            }
        }
    }
    
}
