//
//  HomeView.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    // Home UI View
    var body: some View {
        NavigationView{
            ZStack (alignment: .center) {
                VStack {
                    VStack (alignment: .leading) {
                        HStack {
                            Text("\(Image(systemName: "mappin.and.ellipse")) \(viewModel.cityName), \(viewModel.country)")
                                .bold().font(.title)
                                .foregroundColor(Color(#colorLiteral(red: 0.24, green: 0.23, blue: 0.38, alpha: 1)))
                            Spacer()
                            // Navigate to ForecastView
                            NavigationLink(destination: SearchView(), label: {
                                Text("\(Image(systemName: "magnifyingglass"))")
                                .bold().font(.title)
                                .foregroundColor(Color(#colorLiteral(red: 0.24, green: 0.23, blue: 0.38, alpha: 1)))
                            })
                        }
                        .padding(.horizontal)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                    .foregroundColor(Color(#colorLiteral(red: 0.24, green: 0.23, blue: 0.38, alpha: 1)))
                    
                    Text(viewModel.weatherIcon)
                    .font(.system(size: 150))
                    .foregroundColor(Color(#colorLiteral(red: 0.24, green: 0.23, blue: 0.38, alpha: 1)))
                    
                    Text(viewModel.weatherDescription)
                    .foregroundColor(Color(#colorLiteral(red: 0.24, green: 0.23, blue: 0.38, alpha: 1)))
                    .padding(.bottom,1)
                    
                    Text(viewModel.temperature)
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(Color(#colorLiteral(red: 0.24, green: 0.23, blue: 0.38, alpha: 1)))
                    
                    
                    HStack {
                        HStack (spacing: 50) {
                            VStack (alignment: .center, spacing: 20) {
                                VStack (spacing: 10) {
                                    Text("\(Image(systemName: "digitalcrown.horizontal.press"))").font(.system(size: 25))
                                        .bold()
                                        .foregroundColor(Color.black)
                                    Text(viewModel.pressure).font(.system(size: 15))
                                        .bold()
                                        .foregroundColor(Color.black)
                                }
                                
                                VStack (spacing: 10) {
                                    Text("\(Image(systemName: "wind"))").font(.system(size: 25))
                                        .bold()
                                        .foregroundColor(Color.black)
                                    Text(viewModel.windSpeed).font(.system(size: 15))
                                        .bold()
                                        .foregroundColor(Color.black)
                                }
                                
                                VStack (spacing: 10) {
                                    Text("\(Image(systemName: "sunrise"))").font(.system(size: 25))
                                        .bold()
                                        .foregroundColor(Color.black)
                                    Text(dateFormatter.string(from: viewModel.sunrise)).font(.system(size: 15))
                                        .bold()
                                        .foregroundColor(Color.black)
                                }
                            }
                            
                            VStack (alignment: .center, spacing: 20) {
                                VStack (spacing: 10) {
                                    Text("\(Image(systemName: "humidity"))").font(.system(size: 25))
                                        .bold()
                                        .foregroundColor(Color.black)
                                    Text(viewModel.humidity).font(.system(size: 15))
                                        .bold()
                                        .foregroundColor(Color.black)
                                }
                                VStack (spacing: 10) {
                                    Text("\(Image(systemName: "arrow.up.left.circle"))").font(.system(size: 25))
                                        .bold()
                                        .foregroundColor(Color.black)
                                    Text(viewModel.windDirection).font(.system(size: 15))
                                        .bold()
                                        .foregroundColor(Color.black)
                                }
                                VStack (spacing: 10) {
                                    Text("\(Image(systemName: "sunset"))").font(.system(size: 25))
                                        .bold()
                                        .foregroundColor(Color.black)
                                    Text(dateFormatter.string(from: viewModel.sunset)).font(.system(size: 15))
                                        .bold()
                                        .foregroundColor(Color.black)
                                }
                            }
                        }.padding(.vertical,40)
                            .padding(.horizontal,40)
                    }
                    .background(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.30000001192092896)))
                    .cornerRadius(20)
                    .padding(.bottom)
                    
                    HStack (spacing: 30) {
                        // Navigate to IntervalView
                        NavigationLink(destination: ForecastView(), label: {
                            Text("Forecast \(Image(systemName: "greaterthan.circle.fill"))")
                                .font(.title2)
                                .padding()
                        }).buttonStyle(.borderless).foregroundColor(.white).background(Color(#colorLiteral(red: 0.13725490868091583, green: 0.14901961386203766, blue: 0.20392157137393951, alpha: 1))).cornerRadius(10)
                        
                        NavigationLink(destination: IntervalView(viewModel: WeatherViewModel(weatherService: WeatherAppService())), label: {
                            Text("Interval \(Image(systemName: "greaterthan.circle.fill"))")
                                .font(.title2)
                                .padding()
                        }).buttonStyle(.borderless).foregroundColor(.white).background(Color(#colorLiteral(red: 0.13725490868091583, green: 0.14901961386203766, blue: 0.20392157137393951, alpha: 1))).cornerRadius(10)
                        
                    }
                    
                    
                    Spacer()
                }
                .onAppear(perform: viewModel.refresh)
                
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
            .background(LinearGradient(
                            gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 0.9788708091, green: 0.7460676432, blue: 0.5809800029, alpha: 1)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.980519712, green: 0.8878103495, blue: 0.4684302807, alpha: 1)), location: 1)]),
                            startPoint: UnitPoint(x: 0.4986666788680238, y: 0.9889162870635361),
                            endPoint: UnitPoint(x: 0.49866667603753534, y: -3.082887278793578e-10)))
        }
        
    }
}

// Date Formatter for Date Values
private var dateFormatter: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: WeatherViewModel(weatherService: WeatherAppService()))
    }
}
