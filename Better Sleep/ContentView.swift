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
    @State var coffeeAmount: Int = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    let now = Date()
    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("When do you want to wake up?")
//                    .font(.headline)
//                DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
//                .labelsHidden()
//                Text("Desired amount of sleep")
//                    .font(.headline)
//                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
//                    Text("\(sleepAmount, specifier: "%.2f") hours")
//                }
//                Text("Daily coffee intake")
//                    .font(.headline)
//                Stepper(value: $coffeeAmount, in: 1...20, step: 1) {
//                    if coffeeAmount == 1 {
//                        Text("1 cup")
//                    } else {
//                        Text("\(coffeeAmount) cups")
//                    }
//                }
//            }
//            .navigationBarTitle("Better Sleep")
//            .navigationBarItems(trailing:
//                Button(action: calculateBedTime) {
//                    Text("Calculate")
//                }
//            )
//                .alert(isPresented: $showingAlert) {
//                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Okay")))
//            }
//        }
//    }
    
    var body: some View {
        VStack {
            VStack {
               Image("Sun")
                Text("18:59")
            }
            .background(Image("Stars"))
            VStack {
               Text("")
            }
        }
    }
    
    func calculateBedTime() {
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            alertTitle = formatter.string(from: sleepTime)
            alertMessage = "your ideal bedtime is..."
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculatibg your bad time"
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
