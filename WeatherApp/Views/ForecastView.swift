//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import SDWebImageSwiftUI
import SwiftUI

struct ForecastView: View {

    @StateObject private var forecastListVM = ForecastListViewModel()
    @State private var showModel: Bool = false
    @State private var selectedTemperature: String?
    @State private var selectedHumidity: String?
    @State private var selectedPressure: String?
    @State private var selectedWindSpeed: String?
    @State private var selectedWindDirection: String?
    @State private var selectedCloudPrecentage: String?

    // Foercast UI View
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    Picker(selection: $forecastListVM.system, label: Text("System")){
                        Text("Metric").tag(0)
                        Text("Imperial").tag(1)
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
                                    forecastListVM.getWeatherForecast()
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
                    List(forecastListVM.forecasts, id: \.day) {day in
                        VStack(alignment: .leading){
                            Text(day.day)
                                .fontWeight(.bold)

                            HStack(alignment: .center){
                                WebImage(url: day.weatherIconURL)
                                    .resizable()
                                    .placeholder{
                                        Image(systemName: "hourglass")
                                    }
                                    .scaledToFit()
                                    .frame(width: 75)
                                VStack(alignment: .leading, spacing: 10){
                                    Text(day.overview)
                                        .font(.title3)
                                        .bold()
                                    HStack{
                                        HStack{
                                            Image(systemName: "thermometer.sun")
                                            Text("Temprature")
                                        }
                                        Spacer()
                                        Text("\(day.high)")
                                    }
                                    HStack{
                                        HStack{
                                            Image(systemName: "humidity")
                                            Text("Humidity")
                                        }
                                        Spacer()
                                        Text(day.humidity)
                                    }
                                    HStack{
                                        HStack{
                                            Image(systemName: "digitalcrown.horizontal.press.fill")
                                            Text("Pressure")
                                        }
                                        Spacer()
                                        Text(day.pressure)
                                    }
                                    HStack{
                                        HStack{
                                            Image(systemName: "wind")
                                            Text("WindSpeed")
                                        }
                                        Spacer()
                                        Text(day.windSpeed)
                                    }
                                }
                            }
                        }
                        .padding()
                        .border(Color.white)
                        .onTapGesture{
                            self.selectedTemperature = "\(day.high)"
                            self.selectedHumidity = day.humidity
                            self.selectedPressure = day.pressure
                            self.selectedWindSpeed = day.windSpeed
                            self.selectedWindDirection = day.windDirection
                            self.selectedCloudPrecentage = day.clouds
                            self.showModel.toggle()

                        }
                    }
                    // Make view refreshable 
                    .refreshable{forecastListVM.getWeatherForecast()}
                    .listStyle(PlainListStyle())
                    .sheet(isPresented: $showModel) {
                        WeatherDetailView(selectedTemperature: $selectedTemperature, selectedHumidity: $selectedHumidity, selectedPressure: $selectedPressure, selectedWindSpeed: $selectedWindSpeed, selectedWindDirection: $selectedWindDirection, selectedCloudPrecentage: $selectedCloudPrecentage)
                    }

                }
                .navigationTitle("Weather Forecast")
                .navigationBarHidden(true)
                .alert(item: $forecastListVM.appError) { appAlert in
                    Alert(title: Text("Error"), message: Text("""
                                                              \(appAlert.errorString). Please Try Again.
                                                              """))
                }
                Spacer()
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

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView()
    }
}
