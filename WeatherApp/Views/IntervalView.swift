//
//  IntervalView.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import SDWebImageSwiftUI
import SwiftUI

struct IntervalView: View {
    
    @StateObject private var intervalListVM = IntervalListViewModel()
    @ObservedObject var viewModel: WeatherViewModel
    
    // Interval UI View
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    Text("\(Date().formatted(.dateTime.month().day().hour().minute()))")
                    HStack {
                        Text(viewModel.weatherIcon)
                            .font(.system(size: 100))
                        Text(viewModel.temperature)
                            .font(.system(size: 60, weight: .black, design: .rounded))
                            .foregroundColor(.yellow)
                    }
                    Text(viewModel.weatherDescription)
                    List (intervalListVM.intervals, id: \.day) { day in
                        HStack(spacing: 0) {
                            WebImage(url: day.weatherIconURL)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 75, height: 75)
                                .foregroundColor(.cyan)
                                .padding(.horizontal)
                            VStack (alignment: .leading) {
                                Text(day.overview)
                                    .padding(.bottom,1)
                                Text(day.day)
                            }.padding(.vertical)
                            Spacer()
                            Text("\(day.temp)" + "C")
                                .padding(.horizontal)
                        }.border(Color.white)
                    }
                    // Make view refreshable
                    .refreshable(action: viewModel.refresh)
                    .listStyle(PlainListStyle())
                    
                }
                // Get Interval data for current location
                .onAppear(perform: viewModel.refresh)
                .navigationTitle("Weather Intervals")
                .navigationBarHidden(true)
                .alert(item: $intervalListVM.appError) { appAlert in
                    Alert(title: Text("Error"), message: Text("""
                                                              \(appAlert.errorString). Please Try Again.
                                                              """))
                }
            }
            // Show loading view
            if intervalListVM.isLoading {
                ZStack{
                    Color(.white)
                        .opacity(0.6)
                        .ignoresSafeArea()
                    ProgressView("Fetching Data")
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

struct IntervalView_Previews: PreviewProvider {
    static var previews: some View {
        IntervalView(viewModel: WeatherViewModel(weatherService: WeatherAppService()))
    }
}

