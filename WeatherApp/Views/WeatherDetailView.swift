//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-22.
//

import SDWebImageSwiftUI
import SwiftUI

struct WeatherDetailView: View {
    @Binding var selectedTemperature: String?
    @Binding var selectedHumidity: String?
    @Binding var selectedPressure: String?
    @Binding var selectedWindSpeed: String?
    @Binding var selectedWindDirection: String?
    @Binding var selectedCloudPrecentage: String?
    
    @Environment(\.dismiss) var dismiss
    
    // Weather in-detail UI View
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Text("\(Image(systemName: "xmark"))").font(.system(size: 30))
                            .bold()
                    }
                }.padding()
                
                Text("Weather Details").font(.system(size: 30))
                    .bold()
                    .padding(.bottom)
                
                HStack (spacing: 10) {
                    VStack (alignment: .center, spacing: 30) {
                        VStack (spacing: 10) {
                            Text("Temprature").font(.system(size: 25))
                                .bold()
                            Text("\(Image(systemName: "thermometer.sun"))").font(.system(size: 50))
                                .bold()
                                
                            Text(selectedTemperature!).font(.system(size: 25))
                                .bold()
                                
                        }
                        
                        VStack (spacing: 10) {
                            Text("Wind Speed").font(.system(size: 25))
                                .bold()
                            Text("\(Image(systemName: "wind"))").font(.system(size: 50))
                                .bold()
                                
                            Text(selectedWindSpeed!).font(.system(size: 25))
                                .bold()
                                
                        }
                        
                        VStack (spacing: 10) {
                            Text("Cloud Precentage").font(.system(size: 25))
                                .bold()
                            Text("\(Image(systemName: "smoke.fill"))").font(.system(size: 50))
                                .bold()
                                
                            Text(selectedCloudPrecentage!).font(.system(size: 25))
                                .bold()
                                
                        }
                    }
                    
                    VStack (alignment: .center, spacing: 30) {
                        VStack (spacing: 10) {
                            Text("Pressure").font(.system(size: 25))
                                .bold()
                            Text("\(Image(systemName: "digitalcrown.horizontal.press.fill"))").font(.system(size: 50))
                                .bold()
                                
                            Text(selectedPressure!).font(.system(size: 25))
                                .bold()
                                
                        }
                        
                        VStack (spacing: 10) {
                            Text("Wind Direction").font(.system(size: 25))
                                .bold()
                            Text("\(Image(systemName: "arrow.up.left.circle"))").font(.system(size: 50))
                                .bold()
                                
                            Text(selectedWindDirection!).font(.system(size: 25))
                                .bold()
                                
                        }
                        
                        VStack (spacing: 10) {
                            Text("Humidity").font(.system(size: 25))
                                .bold()
                            Text("\(Image(systemName: "humidity"))").font(.system(size: 50))
                                .bold()
                                
                            Text(selectedHumidity!).font(.system(size: 25))
                                .bold()
                                
                        }
                    }
                }
                Spacer()
            }
            
        }
    }
}
