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
    
    @StateObject var parkingSpaceModel = ParkingSpaceModel()
    
    
    
    
    var body: some View {
        NavigationView() {
            ZStack {
                VStack {
                    if parkingSpaceModel.dataIsLoaded {
                        Text("Free Long Term Parking Spaces: \(parkingSpaceModel.parkingSpaces.freeReservedParkingSpaces)")
                        Text("Free Short Term Parking Spaces: \(parkingSpaceModel.parkingSpaces.freeNormalParkingSpaces)")
                        Text(" ")
                        Text(" ")
                        Text(" ")

                        
                        
                        
                        NavigationLink(destination: LongTermParkerLogin()) {
                            Text(LongTermParkerLoginLbl)
                        }
                        .bold()
                        .padding(.horizontal)
                        .buttonStyle(.bordered)
                        
                        
                        NavigationLink(destination: ShortTermParkerLogin()) {
                            Text(ShortTermParkerLoginLbl)
                        }
                        .bold()
                        .padding(.horizontal)
                        .buttonStyle(.bordered)
                           
                        
                    } else {
                        Text("Loading parking spot data...")
                    }
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
