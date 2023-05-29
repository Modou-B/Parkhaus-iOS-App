//
//  CheckOutTicketPage.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 29.05.23.
//

import SwiftUI

struct CheckOutTicketPage: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var carParkingApi = CarParkingApi()
    @AppStorage("ticket") var ticket: String?
    @AppStorage("parkingSpotId") var id: Int?
    @State private var parkingSpotBooked: Float = 0
    
    var body: some View {
        
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
//                            .foregroundColor(.black)
//                            .font(.largeTitle)
//                            .padding(10)
//                            .frame(height: 50, alignment: .top)
//                    })
                
                VStack{
                    Text("Booked parking spot: \(id ?? 0)")
                        .font(.system(size: 30, weight: .medium, design: .rounded))
                        .foregroundColor(Color.green)
                    
                    
                    Spacer()
                        .frame(height: 50)
                
                    
                    Button("Booking out parking spot") {
                        Task {
                            let ticketString = ticket?.utf8 ?? "".utf8
                            let ticketData = Data(ticketString)
                            let ticket = try JSONDecoder().decode(CheckInModel.Ticket.self, from: ticketData)
                            
                            await carParkingApi.parkCar(licensePlate: ticket.licensePlate ?? "", parkingSpotId: id ?? 0)
                            print(id)
                            parkingSpotBooked = 2
                        }
                    }
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50, alignment: .center)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                    .border(.green, width: CGFloat(parkingSpotBooked))
                }
            }
            .navigationBarBackButtonHidden()
        }
        
        
    }

struct CheckOutTicketPage_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutTicketPage()
    }
}
