//
//  ParkingSpaceGrid.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct ParkingSpaceGrid: View {
    @StateObject var parkingSpotsModel = ParkingSpotsModel()
    @StateObject var carParkingApi = CarParkingApi()
    @State private var showingTicket = false
//    @State var parkingSpotId: Int

    @AppStorage("ticket") var ticket: String?

    
    private let data: [Int] = Array(1...180)
    private let colors: [Color] = [.green, .red, .gray]
        
        // Flexible, custom amount of columns that fill the remaining space
        private let numberColumns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        // Adaptive, make sure it's the size of your smallest element.
        private let adaptiveColumns = [
            GridItem(.adaptive(minimum: 50))
        ]
        
        // Fixed, creates columns with fixed dimensions
        private let fixedColumns = [
            GridItem(.fixed(200)),
            GridItem(.fixed(200))
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
                                                    let ticketString = ticket?.utf8 ?? "".utf8
                                                    let ticketData = Data(ticketString)
                                                    let ticket = try JSONDecoder().decode(CheckInModel.Ticket.self, from: ticketData)

                                                    let parkingSpotId = Int(parkingSpot.id) ?? 0

                                                    await carParkingApi.parkCar(licensePlate: ticket.licensePlate ?? "", parkingSpotId: parkingSpotId)
                                                    
                                                }
                                            } .foregroundColor(.white)
                                                .font(.system(size: 30, design: .rounded))
//                                                .navigationDestination(
//                                                    isPresented: $showingLoginScreen) {
//                                                        TestTicketPage()
//                                                    }
                                        }
                                    }
                                }
                            }
                            .navigationTitle("Parking Spaces")
                            .padding()
                            .sheet(isPresented: $showingTicket) {
                                TestTicketPage()
                            }
                        }
                    }
                }.task {
                    await parkingSpotsModel.fetchParkingSpots()
                    print(ticket)
                }
            }
//            .navigationBarBackButtonHidden(true)
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



