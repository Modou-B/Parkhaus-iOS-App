//
//  ParkingSpaceGrid.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct ParkingSpaceGrid: View {
    @State private var showingTicket = false
    
    @StateObject var parkingSpotsModel = ParkingSpotsModel()
    @StateObject var carParkingApi = CarParkingApi()
    
    @AppStorage("ticket") var ticket: String?
    @AppStorage("parkingSpotId") var id: Int?
    @AppStorage("step") var stepId: Int?

    private let data: [Int] = Array(1...180)
    private let colors: [Color] = [.green, .red, .gray]

    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    
    
        
    var body: some View {
        NavigationStack {
            ZStack {
                ZStack {
                    if parkingSpotsModel.dataIsLoaded {
                        Color.blue
                            .ignoresSafeArea()
                        Circle()
                            .scale(1.7)
                            .foregroundColor(.white.opacity(0.15))
                        
                        
                        ScrollView {
                            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                                ForEach(parkingSpotsModel.parkingSpotCollection.parkingSpots ?? [], id: \.id) { parkingSpot in
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(getColor(parkingSpot: parkingSpot))
                                            .cornerRadius(30)
                                        
                                        
                                        Button("\(Int(parkingSpot.id) ?? 0)") {
                                            showingTicket = true
                                            Task {
                                                id = Int(parkingSpot.id) ?? 0
                                            }
                                        }
                                        .foregroundColor(.white)
                                        .font(.system(size: 30, design: .rounded))
                                    }
                                }
                            }
                        }
                        .navigationTitle("Parking Spaces")
                        .padding()
                        .sheet(isPresented: $showingTicket) {
                            CheckInTicket()
                        }
                    }
                }
            }.task {
                await parkingSpotsModel.fetchParkingSpots()
            }
        }
        .onAppear {
            stepId = 4
        }
    }

    
    
    
    func getColor(parkingSpot: ParkingSpotsModel.ParkingSpot)->Color {
        if parkingSpot.isFree == "0" {
            return colors[1]
        }
        
        if parkingSpot.reserved == "1" {
            return colors[2]
        }
        
        return colors[0]
    }
}




struct ParkingSpaceGrid_Previews: PreviewProvider {
    static var previews: some View {
        ParkingSpaceGrid()
    }
}
