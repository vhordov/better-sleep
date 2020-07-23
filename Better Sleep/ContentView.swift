//
//  ContentView.swift
//  Better Sleep
//
//  Created by Grechko Dmytro on 2020-07-22.
//  Copyright © 2020 Hacker's Studio. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var sleepAmount: Double = 8.0
    @State var wakeUp = Date()
    let now = Date()
    let tomorrow = Date().addingTimeInterval(86400)
    
    var body: some View {
        Form {
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%.2f") hours")
            }
            DatePicker("Please enter a date", selection: $wakeUp, in: now...)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
