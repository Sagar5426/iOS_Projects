//
//  TimerBootCamp.swift
//  Intermediate Topics
//
//  Created by Sagar Jangra on 13/04/2025.
//

import SwiftUI
import Combine


struct TimerBootCamp: View {
    // it performs infinite action after a certain time. we set using (every: Time in second)
    //  can be also be used for starting timer, showing current time every second etc.

    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()

    //Animation Counter
    @State var count: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [Color(hex: "#8312e0"), Color(hex: "#28123b")], center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            
            TabView(selection: $count) {
                Rectangle()
                    .foregroundStyle(.red)
                    .tag(1)
                Rectangle()
                    .foregroundStyle(.green)
                    .tag(2)
                Rectangle()
                    .foregroundStyle(.yellow)
                    .tag(3)
                Rectangle()
                    .foregroundStyle(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundStyle(.blue)
                    .tag(5)
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 300)
        }
        .onReceive(timer) { _ in
            withAnimation(.easeInOut) {
                count = count == 5 ? 1 : count+1
            }
        }
    }
}

#Preview {
    TimerBootCamp()
}
