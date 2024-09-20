//
//  ContentView.swift
//  Better Rest
//
//  Created by Sagar Jangra on 03/06/2024.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    //Computed property var
    static var defaultWakeTime : Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    
    var body: some View {
        NavigationStack{
            Form {
                VStack(alignment: .leading, spacing: 0){
                    Text("When do you want to wake up?")
                        .font(.headline)
                        .padding(.bottom,10)
                    
                    DatePicker("Please enter a time", selection: $wakeUp,displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Desired amount of sleep?")
                        .font(.headline)
                        .padding(.bottom,10)
                    
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount,in: 4...12, step: 0.25)
                }
                
                VStack(alignment: .leading, spacing: 0){
                    
                    Text("Daily coffee intake")
                        .font(.headline)
                        .padding(.bottom,10)
                    
                    Stepper(coffeeAmount == 1 ? "1 cup" :"\(coffeeAmount) cups",value: $coffeeAmount, in: 1...20)
                }
            }
            
            .navigationTitle("Better Rest")
                        
            .toolbar {
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: calculateBedtime) {
                        HStack {
                            Image(systemName: "clock")

                                
                            Text("Calculate")
                                .fontWeight(.semibold)
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    .padding(8)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
            })
        }
    }
    
    func calculateBedtime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.day,.hour],from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
            
        }catch{
            alertTitle = "Error"
            alertMessage = "Sorry, There was a problem in calculating your bedtime."
        }
        showingAlert = true
    }
}

#Preview {
    ContentView()
}
