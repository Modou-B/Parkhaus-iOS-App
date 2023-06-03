//
//  ContentView.swift
//  LoginScreen
//
//  Created by Federico on 13/11/2021.
//

import SwiftUI

struct LoginLongTermParker: View {
    @State private var username = ""
    @State private var password = ""
    @State private var licensePlate = ""
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float  = 0
    @State private var wrongLicensePlate: Float  = 0
    @State private var wasAuthenticationSuccessfull = false

    @StateObject var checkInApi = CheckInApi()
    
    @AppStorage("ticket") var ticket: String?
    @AppStorage("parkingSpotId") var id: Int?
    @AppStorage("step") var stepId: Int?
    
    let wrongUsernameErrorCode: Int = 901
    let wrongPasswordErrorCode: Int = 902
    
    let date = Date()
    let df = DateFormatter()

    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.5))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.purple.opacity(0.15))
                ZStack {
                    RoundedRectangle(cornerRadius: 45.87)
                    .fill(LinearGradient(
                            gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6000000238418579)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 0.20000000298023224)), location: 1)]),
                            startPoint: UnitPoint(x: -0.0015019709411221993, y: 0.011388006885359792),
                            endPoint: UnitPoint(x: 1.0189002040034465, y: 0.9898934130319252)))

                    RoundedRectangle(cornerRadius: 45.87)
                    .strokeBorder(LinearGradient(
                            gradient: Gradient(stops: [
                        .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.699999988079071)), location: 0),
                        .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.10000000149011612)), location: 1)]),
                            startPoint: UnitPoint(x: 0.017291056030272978, y: 0.043389347588974614),
                            endPoint: UnitPoint(x: 0.9767208936133693, y: 0.9648771623222485)), lineWidth: 1.6990679502487183)
                }
                .compositingGroup()
                .frame(width: 412.3, height: 400)
                .rotationEffect(.degrees(-0))
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.05000000074505806)), radius:33.98135757446289, x:22.969558715820312, y:22.969558715820312)
                


                
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
                    .navigationDestination(isPresented: $wasAuthenticationSuccessfull) { ParkingSpaceGrid() }
                }
                .onAppear {
                    stepId = 2
                }
            }
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
        LoginLongTermParker()
    }
}
