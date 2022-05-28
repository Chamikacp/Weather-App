//
//  UIApplication+Keyboard.swift
//  WeatherApp
//
//  Created by Chamika Perera on 2022-05-21.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
