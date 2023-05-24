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
    @State private var showingLoginScreen = false
    
    
    var body: some View {
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
                    TextField("License Plate", text: $licensePlate)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    
                    Spacer()
                        .frame(height: 30)
                    
                    Button("Login") {
                        checkLicenseIsEmpty(licensePlate: licensePlate)
                        }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .navigationDestination(
                        isPresented: $showingLoginScreen) {
                            ParkingSpaceGrid()
                            
                        }
                }
//                .navigationTitle("Short Term Parker")
//                .navigationBarHidden(true)
            }
        }
    }
    
    
    func checkLicenseIsEmpty(licensePlate: String) {
            if licensePlate.isEmpty {
                wrongLicensePlate = 2
            } else {
                wrongLicensePlate = 0
                showingLoginScreen = true
            }
    }

}


struct ShortTermParkerLogin_Previews: PreviewProvider {
    static var previews: some View {
        ShortTermParkerLogin()
    }
}
