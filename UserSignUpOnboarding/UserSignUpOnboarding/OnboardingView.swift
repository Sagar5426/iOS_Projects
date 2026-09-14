//
//  OnboardingView.swift
//  UserSignUpOnboarding
//
//  Created by Sagar Jangra on 13/11/2024.
//

import SwiftUI

struct OnboardingView: View {
    
    // Onboarding States:
    /*
     0 - Welcome Screen
     1 - Add name
     2 - Add age
     3 - Add gender
     */
    @State private var onBoardingState: Int = 0
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading))
    
    // onboarding inputs
    @State private var name: String = ""
    @State private var age: Double = 50
    @State private var gender: String = ""
    
    // for alert
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    @State var showAlert: Bool = false
    
    // app storage
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    var body: some View {
        ZStack {
            // content
            ZStack {
                switch onBoardingState {
                case 0: welcomeSection
                        .transition(transition)
                case 1: addNameSection
                        .transition(transition)
                case 2: addAgeSection
                        .transition(transition)
                case 3: addGenderSection
                        .transition(transition)
                default:
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundStyle(.green)
                }
            }
            
            // button
            VStack {
                Spacer()
                bottomButton
            }
            .padding(30)
            
        }
        .alert(Text(alertTitle), isPresented: $showAlert) {
            Button("OK", role: .cancel, action: { })
        } message: {
            Text(alertMessage)
        }
        
        
        
    }
}




#Preview {
    OnboardingView()
        .background(.purple)
}

// MARK: Components
extension OnboardingView {
    
    private var bottomButton: some View {
        
        Text(buttonTextLogic())
            .font(.headline)
            .foregroundStyle(.purple)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        
            .onTapGesture {
                handleNextButtonPressed()
            }
        
    }
    
    private var welcomeSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .foregroundStyle(.white)
            
            Text("Find your match")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .overlay (
                    Capsule(style: .continuous)
                        .frame(height: 3)
                        .offset(y: 5)
                        .foregroundStyle(.white),
                    alignment: .bottom
                    
                )
            
            Text("This is the #1 App to find your match online")
                .font(.title3)
                .foregroundStyle(.white)
                .padding(.horizontal, 50)
                .multilineTextAlignment(.center)
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    
    
    private var addNameSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What's your name?")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .lineLimit(1)
            
            TextField("Your name here...", text: $name)
                .font(.headline)
                .foregroundStyle(.black)
                .frame(height: 55)
                .padding(.horizontal)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
    private var addAgeSection: some View {
        VStack(spacing: 40) {
            Spacer()
            Text("What's your Age?")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            // String(format: "%.0f", age)  --> used to remove decimal
            Text("Age: \(String(format: "%.0f", age))")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            Slider(value: $age, in: 18...100, step: 1)
                .tint(.white)
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    private var addGenderSection: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("What's your gender?")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            
            Menu {
                Picker("Gender", selection: $gender) {
                    Text("Male").tag("Male")
                    Text("Female").tag("Female")
                    Text("Other").tag("Other")
                }
            } label: {
                Text(gender.count > 1 ? gender : "Select a gender")
                    .font(.headline)
                    .foregroundStyle(.purple)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            
            
            
            Spacer()
            Spacer()
        }
        .padding(30)
    }
    
}

// MARK: Functions
extension OnboardingView {
    func handleNextButtonPressed() {
        
        //CHECK
        switch onBoardingState {
        case 1:
            guard name.count >= 3 else {
                showAlert(AlertTitle: "Your name should contain at least 3 characters! 😩", AlertMessage: "")
                return
            }
        case 3:
            guard gender.count > 1 else {
                showAlert(AlertTitle: "Please select your gender! 😳", AlertMessage: "")
                return
            }
        default: break
        }
        
        //GO TO NEXT SECTION
        if(onBoardingState == 3) {
            signIn()
        } else {
            withAnimation(.spring()) {
                onBoardingState += 1
            }
        }
    }
    
    func signIn() {
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        currentUserSignedIn = true
        
    }
    
    func buttonTextLogic() -> String {
        if onBoardingState == 0  {
            return "SIGN UP"
        } else if onBoardingState == 3 {
            return "FINISH"
        } else {
            return "NEXT"
        }
    }
    
    func showAlert(AlertTitle: String, AlertMessage: String) {
        alertTitle = AlertTitle
        alertMessage = AlertMessage
        showAlert.toggle()
    }
}
