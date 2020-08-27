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
        ScrollView {
            VStack(spacing: 0) {
                ZStack {
                    Image("Stars")
                    .scaledToFill()
                    VStack {
                        Image("Sun")
                        Text("18:56")
                            .font(.custom("chalkboard", size: 70))
                            .foregroundColor(Color.orange)
                    }
                }
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [
                        Color(red: 240.0 / 255.0, green: 212.0 / 255.0, blue: 146.0 / 255.0),
                        Color(red: 229.0 / 255.0, green: 155.0 / 255.0, blue: 112.0 / 255.0)]),
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing
                    )
                    VStack {
                       Text("When do you want to wake up?")
                        .font(.custom("sf-compact", size: 24))
                        .foregroundColor(Color.white)
                        DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .background(Color.white
                                .frame(width: 414, height: 215))
                        Text("Desired amount of sleep")
                            .font(.custom("sf-compact", size: 24))
                            .foregroundColor(Color.white)
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%.2f") hours")
                        }
                        .padding(25.0)
                        .frame(width: 257.0, height: 40.0)
                    }
                    .padding(.top, 25.0)
                    
                    }
            }
            ZStack {
                LinearGradient(gradient: Gradient(colors: [
                    Color(red: 240.0 / 255.0, green: 212.0 / 255.0, blue: 146.0 / 255.0),
                    Color(red: 229.0 / 255.0, green: 155.0 / 255.0, blue: 112.0 / 255.0)]),
                    startPoint: .bottomLeading,
                    endPoint: .topTrailing
                )
                VStack {
                Text("Daily coffee intake")
                    .font(.custom("sf-compact", size: 24))
                    .foregroundColor(Color.white)
                    Stepper(value: $coffeeAmount, in: 1...20, step: 1) {
                    if coffeeAmount == 1 {
                    Text("1 cup")
                    } else {
                    Text("\(coffeeAmount) cups")
                        .frame(width: 257.0, height: 40.0)
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
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
