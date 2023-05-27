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
    @State private var wasAuthenticationSuccessfull = false

    @AppStorage("ticket") var ticket: String?

    @StateObject var checkInApi = CheckInApi()

    let wrongUsernameErrorCode: Int = 901
    let wrongPasswordErrorCode: Int = 902
    
    let date = Date()
    let df = DateFormatter()

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
                            resetErrors()
                            await checkInApi.checkInLongTermParker(licensePlate: licensePlate, username: username, password: password)
                            
                            if authenticateLogin() {
                                let jsonData = try JSONEncoder().encode(checkInApi.ticket)
                               let jsonString = String(data: jsonData, encoding: .utf8)!
                                ticket = jsonString
                                
                                self.wasAuthenticationSuccessfull = true
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .navigationDestination(
                        isPresented: $wasAuthenticationSuccessfull) {
                            ParkingSpaceGrid()

                        }
//                    NavigationLink(destination: ParkingSpaceGrid(), isActive: $showingLoginScreen) {
//                    }
                    
                }
                
            }
//            .navigationBarHidden(true)
        }
    }
    private func authenticateLogin()-> Bool {
        if checkInApi.hasError {
            switch checkInApi.loginResponse.errorCode {
            
            case self.wrongUsernameErrorCode:
                self.wrongUsername = 2
                break
            
            case self.wrongPasswordErrorCode:
                self.wrongPassword = 2
            
            default:
                print("Undefined Error Code")
            }
            
            return false
        }
        
        return true
    }
    
    private func resetErrors() {
        self.wrongUsername = 0
        self.wrongPassword = 0
    }
}

struct LongTermParkerLogin_Previews: PreviewProvider {
    static var previews: some View {
        LongTermParkerLogin()
    }
}
