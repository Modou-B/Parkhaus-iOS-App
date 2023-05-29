//
//  Home.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct Home: View {
    @State var LongTermParkerLoginLbl = "Long Term Parker"
    @State var ShortTermParkerLoginLbl = "Short Term Parker"
    
    @State var LongTermParkingSpacesLbl = "Free Long Term Parking Spaces:"
    @State var ShortTermParkingSpacesLbl = "Free Short Term Parking Spaces:"
    
    
    //Todo: $showingLoginScreen hinzufügen
    @State private var showingLongTermLoginScreen = false
    @State private var showingShortTermLoginScreen = false
    @StateObject var parkingSpaceModel = ParkingSpaceModel()
    
    @AppStorage("parkingSpotId") var id: Int?
    @State private var showText = true
    
    
    
    var body: some View {
        NavigationStack() {
            ZStack {
                ZStack {
                    Color.blue
                        .ignoresSafeArea()
                    Circle()
                        .scale(1.7)
                        .foregroundColor(.white.opacity(0.15))
                    Circle()
                        .scale(1.35)
                        .foregroundColor(.white)
                    
                    
                    VStack(alignment: .leading) {
                        if parkingSpaceModel.dataIsLoaded {
                            Text("Free Long Term Parking Spaces: \(parkingSpaceModel.parkingSpaces.freeReservedParkingSpaces)")
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                            Text("Free Short Term Parking Spaces: \(parkingSpaceModel.parkingSpaces.freeNormalParkingSpaces)")
                                .font(.system(size: 20, weight: .medium, design: .rounded))
                            Spacer()
                                .frame(height: 50)
                            Button(LongTermParkerLoginLbl) {
                                showingLongTermLoginScreen = true
                                }
                            .foregroundColor(.black)
                            .frame(width: 300, height: 50)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(10)
                            .navigationDestination(
                                isPresented: $showingLongTermLoginScreen) {
                                    LongTermParkerLogin()
                                }
                                .disabled(false)
                            Button(ShortTermParkerLoginLbl) {
                                showingShortTermLoginScreen = true
                                }
                            .foregroundColor(.black)
                            .frame(width: 300, height: 50)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(10)
                            .navigationDestination(
                                isPresented: $showingShortTermLoginScreen) {
                                    ShortTermParkerLogin()
                                }
                        } else {
                            Text("Loading parking spot data...")
                        }

                    }
                    .onAppear {
                        
                    }
                    .navigationTitle("Home")
                }
                
            } .task {
                await parkingSpaceModel.fetchParkingSpaceCounts()
            }
        }
    }
}

func checkIfAlreadyInSession() -> Bool{
    
    if id == 0 {
        return true
    }
}
struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
