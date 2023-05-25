//
//  ContentView.swift
//  LoginScreen
//
//  Created by Federico on 13/11/2021.
//

import SwiftUI

struct LongTermParkerLogin: View {
    @State private var username = ""
    @State private var password = ""
    @State private var licensePlate = ""
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float  = 0
    @State private var wrongLicensePlate: Float  = 0
    @State private var showingLoginScreen = false
    
    let date = Date()
    let df = DateFormatter()
    
    
//    @StateObject var shortTermModel = ShortTermModel()
    
    var body: some View {
//        df.dateStyle = DateFormatter.Style.short
        NavigationStack {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)

                
                VStack {
                    Text("Long Term Parker")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                        
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Spacer()
                        .frame(height: 20)
                    
                    TextField("License Plate", text: $licensePlate)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongLicensePlate))
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Button("Login") {
                        Task {
                            await LongTermModel().LongTermCheckIn(licencePlate: licensePlate, username: username, password: password)
                        }
                        
//                        authenticateUser(username: username, password: password, licensePlate: licensePlate)
                        }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .navigationDestination(
                        isPresented: $showingLoginScreen) {
                            ParkingSpaceGrid()
                            
                        }
//                    NavigationLink(destination: ParkingSpaceGrid(), isActive: $showingLoginScreen) {
//                    }
                    
                }
                
            }
//            .navigationBarHidden(true)
        }
    }
    
    func authenticateUser(username: String, password: String, licensePlate: String) {
        if username.lowercased() == "modou" {
            wrongUsername = 0
            if password.lowercased() == "1234" {
                wrongPassword = 0
                if licensePlate.isEmpty {
                    wrongLicensePlate = 2
                } else {
                    wrongLicensePlate = 0
                    showingLoginScreen = true
                }
            } else {
                wrongPassword = 2
            }
        } else {
            wrongUsername = 2
        }
    }
}

struct LongTermParkerLogin_Previews: PreviewProvider {
    static var previews: some View {
        LongTermParkerLogin()
    }
}
