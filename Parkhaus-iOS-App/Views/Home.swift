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
    @StateObject var parkingSpaceModel = ParkingSpaceModel()
    
    var body: some View {
        NavigationView() {
            ZStack {
                VStack {
                    if parkingSpaceModel.dataIsLoaded {
                        NavigationLink(destination: LongTermParkerLogin()) {
                            Text(LongTermParkerLoginLbl+" \(parkingSpaceModel.parkingSpaces.freeReservedParkingSpaces)")
                        }
                        .bold()
                        .frame(height: 55).border(Color.red)
                   
                        NavigationLink(destination: ShortTermParkerLogin()) {
                            Text("Short Term Parker \(parkingSpaceModel.parkingSpaces.freeNormalParkingSpaces)")
                        }
                        .bold()
                        .frame(height: 55).border(Color.red)
                        .padding(50)
                        
                    } else {
                        Text("Loading parking spot data...")
                    }
                }
               
                .navigationTitle("Home")
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
