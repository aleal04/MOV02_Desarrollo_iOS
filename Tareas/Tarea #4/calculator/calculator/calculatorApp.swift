//
//  calculatorApp.swift
//  calculator
//
//  Created by Andrey Leal on 4/9/21.
//

import SwiftUI
import UIKit

@main
struct calculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(EnvGlobal())
        }
    }
}
