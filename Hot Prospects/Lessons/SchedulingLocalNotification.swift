//
//  SchedulingLocalNotification.swift
//  Hot Prospects
//
//  Created by Sagar Jangra on 07/10/2024.
//

import SwiftUI

struct SchedulingLocalNotification: View {
    var body: some View {
        VStack {
            Button("Request Permission") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("Permission granted")
                    } else if let error {
                        print("Error: \(error.localizedDescription)")
                    }
                    
                }
            }
            .padding()
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the cat"
                content.subtitle = "It looks hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
                
            }
        }
    }
}

#Preview {
    SchedulingLocalNotification()
}
