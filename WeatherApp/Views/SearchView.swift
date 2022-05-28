//
//  SeachView.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-22.
//

import SDWebImageSwiftUI
import SwiftUI
import CoreLocation

struct SearchView: View {
    
    @StateObject private var forecastListVM = SearchListViewModel()
    

    // Search Loacation UI View
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    Picker(selection: $forecastListVM.system, label: Text("System")){
                        Text("Metric").tag(0)
                        Text("Imperial").tag(1)
                    }
                    .onChange(of: forecastListVM.system) { _ in
                        forecastListVM.getWeatherForecast()
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.vertical)
                    .padding(.horizontal)
                    HStack{
                        TextField("Enter Location", text: $forecastListVM.location, onCommit: {
                            forecastListVM.getWeatherForecast()
                        })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                Button(action:{
                                    // Resetting forecast data and the city
                                    forecastListVM.location = ""
                                    forecastListVM.clear()
                                }){
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(.gray)
                                }
                                    .padding(.horizontal,10),
                                alignment: .trailing
                            )
                            .border(Color.white)
                        Button {
                            // Get forecast data for entered city
                            forecastListVM.getWeatherForecast()
                        } label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.title)
                        }
                    }.padding(.horizontal)
                     .padding(.bottom)
                    
                    ScrollView {
                        HStack (spacing: 10) {
                            VStack (alignment: .center, spacing: 30) {
                                VStack (spacing: 10) {
                                    Text("Temprature").font(.system(size: 25))
                                        .bold()
                                    Text("\(Image(systemName: "thermometer.sun"))").font(.system(size: 50))
                                        .bold()
                                    if forecastListVM.system == 0 {
                                        Text("\(forecastListVM.temperature) °C").font(.system(size: 25))
                                            .bold()
                                    } else {
                                        Text("\(forecastListVM.temperature) °F").font(.system(size: 25))
                                            .bold()
                                    }
                                    
                                }
                                
                                VStack (spacing: 10) {
                                    Text("Wind Speed").font(.system(size: 25))
                                        .bold()
                                    Text("\(Image(systemName: "wind"))").font(.system(size: 50))
                                        .bold()
                                     
                                    if forecastListVM.system == 0 {
                                        Text("\(forecastListVM.windSpeed) m/s").font(.system(size: 25))
                                            .bold()
                                    } else {
                                        Text("\(forecastListVM.windSpeed) mi/h").font(.system(size: 25))
                                            .bold()
                                    }
                                    
                                        
                                }
                                
                                VStack (spacing: 10) {
                                    Text("Cloud Precentage").font(.system(size: 25))
                                        .bold()
                                    Text("\(Image(systemName: "smoke.fill"))").font(.system(size: 50))
                                        .bold()
                                        
                                    Text("\(forecastListVM.clouds) %").font(.system(size: 25))
                                        .bold()
                                        
                                }
                            }
                            
                            VStack (alignment: .center, spacing: 30) {
                                VStack (spacing: 10) {
                                    Text("Pressure").font(.system(size: 25))
                                        .bold()
                                    Text("\(Image(systemName: "digitalcrown.horizontal.press.fill"))").font(.system(size: 50))
                                        .bold()
                                        
                                    Text("\(forecastListVM.pressure) hPa").font(.system(size: 25))
                                        .bold()
                                        
                                }
                                
                                VStack (spacing: 10) {
                                    Text("Wind Direction").font(.system(size: 25))
                                        .bold()
                                    Text("\(Image(systemName: "arrow.up.left.circle"))").font(.system(size: 50))
                                        .bold()
                                        
                                    Text("\(forecastListVM.windDirection) W").font(.system(size: 25))
                                        .bold()
                                        
                                }
                                
                                VStack (spacing: 10) {
                                    Text("Humidity").font(.system(size: 25))
                                        .bold()
                                    Text("\(Image(systemName: "humidity"))").font(.system(size: 50))
                                        .bold()
                                        
                                    Text("\(forecastListVM.humidity) %").font(.system(size: 25))
                                        .bold()
                                        
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .navigationTitle("Weather Forecast")
                .navigationBarHidden(true)
                .alert(item: $forecastListVM.appError) { appAlert in
                    Alert(title: Text("Error"), message: Text("""
                                                              \(appAlert.errorString). Please Try Again.
                                                              """))
                }
                
            }
            // Show loading view
            if forecastListVM.isLoading {
                ZStack{
                    Color(.white)
                        .opacity(0.6)
                        .ignoresSafeArea()
                    ProgressView("Fetching Data!")
                        .padding()
                        .foregroundColor(Color.white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(.systemBackground))
                        )
                        .shadow(radius: 10)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
