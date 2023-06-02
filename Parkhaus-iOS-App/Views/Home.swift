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
    @State private var showingLongTermLoginScreen = false
    @State private var showingShortTermLoginScreen = false
    @State private var showCheckOut = false
    
    @StateObject var parkingSpaceModel = ParkingSpaceModel()
    @AppStorage("parkingSpotId") var id: Int?
    @AppStorage("step") var stepId: Int?
    
    
    
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
                            Text("\(LongTermParkingSpacesLbl) \(parkingSpaceModel.parkingSpaces.freeReservedParkingSpaces)")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                            
                            
                            Text("\(ShortTermParkingSpacesLbl) \(parkingSpaceModel.parkingSpaces.freeNormalParkingSpaces)")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                            
                            
                            Spacer()
                                .frame(height: 50)
                            
                            
                            Button(LongTermParkerLoginLbl) { showingLongTermLoginScreen = true }
                            .foregroundColor(.black)
                            .frame(width: 300, height: 50)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(10)
                            .navigationDestination(
                                isPresented: $showingLongTermLoginScreen) { LoginLongTermParker() }
                                .disabled(false)
                            
                            
                            Button(ShortTermParkerLoginLbl) { showingShortTermLoginScreen = true }
                            .foregroundColor(.black)
                            .frame(width: 300, height: 50)
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(10)
                            .navigationDestination(
                                isPresented: $showingShortTermLoginScreen) { LoginShortTermParker() }
                            
                            
                        } else {
                            Text("Loading parking spot data...")
                        }

                    }
                    .navigationTitle("Home")
                }
            } .task {
                await parkingSpaceModel.fetchParkingSpaceCounts()
            }
        }
    }
}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
