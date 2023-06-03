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
//                        Circle()
//                            .scale(1.7)
//                            .foregroundColor(.white.opacity(0.5))
//                        Circle()
//                            .scale(1.35)
//                            .foregroundColor(.purple.opacity(0.15))
                        

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
                        .frame(width: 380, height: 680)
                        .rotationEffect(.degrees(-0))
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.05000000074505806)), radius:33.98135757446289, x:22.969558715820312, y:22.969558715820312)
                        
                        
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
