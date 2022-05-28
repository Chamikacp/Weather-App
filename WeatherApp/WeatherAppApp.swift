//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherAppService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            HomeView(viewModel: viewModel)
        }
    }
}
