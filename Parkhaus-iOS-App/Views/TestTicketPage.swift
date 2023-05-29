//
//  TestTicketPage.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 28.05.23.
//

import SwiftUI

struct TestTicketPage: View {

    @StateObject var carParkingApi = CarParkingApi()
    @AppStorage("ticket") var ticket: String?
    @AppStorage("parkingSpotId") var id: Int?
                
//    @StateObject var parkingSpaceGrid = ParkingSpaceGrid()
    
//    @StateObject var parkingSpotsModel = ParkingSpotsModel()
    
    var body: some View {
        
        HStack {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)
                        .edgesIgnoringSafeArea(.all)
                
                
//                    Button(action: {
//                        presentationMode.wrappedValue.dismiss()
//                    }, label: {
//                        Image(systemName: "xmark")
//                            .foregroundColor(.yellow)
//                            .font(.largeTitle)
//                            .padding(20)
//                            .frame(alignment: .bottom)
//                    })
                ZStack{
                    Button("Book parking spot") {
                        Task {
                            let ticketString = ticket?.utf8 ?? "".utf8
                            let ticketData = Data(ticketString)
                            let ticket = try JSONDecoder().decode(CheckInModel.Ticket.self, from: ticketData)
                            
                            
//                            let parkingSpotId = Int(parkingSpot.id) ?? 0
                            
                            await carParkingApi.parkCar(licensePlate: ticket.licensePlate ?? "", parkingSpotId: id)
                        }
                    }
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50, alignment: .center)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
//                    Button("Test") {
//                        showingTicket = true
//
//
//                        Task {
//                            let ticketString = ticket?.utf8 ?? "".utf8
//                            let ticketData = Data(ticketString)
//                            let ticket = try JSONDecoder().decode(CheckInModel.Ticket.self, from: ticketData)
//
//                            let parkingSpotId = Int(parkingSpot.id) ?? 0
//
//                            await carParkingApi.parkCar(licensePlate: ticket.licensePlate ?? "", parkingSpotId: parkingSpotId)
//
//                        }
//                    } .foregroundColor(.white)
//                        .font(.system(size: 30, design: .rounded))
                }
                
                
                
            }
            .navigationBarBackButtonHidden()
        }
        
        
    }
}

struct TestTicketPage_Previews: PreviewProvider {
    static var previews: some View {
        TestTicketPage()
    }
}
