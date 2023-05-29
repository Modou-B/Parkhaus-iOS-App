//
//  ShortTermParkerLogin.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct ShortTermParkerLogin: View {
    @State private var licensePlate = ""
    @State private var wrongLicensePlate: Float  = 0
    
    @AppStorage("ticket") var ticket: String?
    @AppStorage("parkingSpotId") var id: Int?
    @AppStorage("step") var stepId: Int?
    @StateObject var checkInApi = CheckInApi()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack {
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
                        TextField("License Plate", text: $licensePlate)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                        
                        
                        Spacer()
                            .frame(height: 30)
                        
                        
                        Button("Login") {
                            checkLicenseIsEmpty(licensePlate: licensePlate)
                            Task {
                                await checkInApi.checkInShortTermParker(licensePlate: licensePlate)
                                
                                let jsonData = try JSONEncoder().encode(checkInApi.ticket)
                               let jsonString = String(data: jsonData, encoding: .utf8)!
                                ticket = jsonString
                            }
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .navigationDestination(
                            isPresented: $checkInApi.wasSuccessful) {
                                ParkingSpaceGrid()
                            }
                            .disabled(licensePlate.isEmpty)

                    }
                    .onAppear {
                        stepId = 3
                        print("StepID: \(stepId)")
                    }
    //                .navigationTitle("Short Term Parker")
    //                .navigationBarHidden(true)
                }
            }
        }
    }
    
    
    func checkLicenseIsEmpty(licensePlate: String) {
            if licensePlate.isEmpty {
                wrongLicensePlate = 2
            } else {
                wrongLicensePlate = 0
            }
    }
}

struct ShortTermParkerLogin_Previews: PreviewProvider {
    static var previews: some View {
        ShortTermParkerLogin()
    }
}
