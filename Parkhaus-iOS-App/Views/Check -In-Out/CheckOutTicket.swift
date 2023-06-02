//
//  CheckOutTicketPage.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 29.05.23.
//

import SwiftUI

struct CheckOutTicket: View {
    @State private var isALongTermParker: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var checkOutApi = CheckOutApi()
    
    @AppStorage("ticket") var ticket: String?
    @AppStorage("parkingSpotId") var id: Int?
    @AppStorage("step") var stepId: Int?
    @AppStorage("payment") var payment: String?
    
    
    
    var body: some View {
            ZStack {
                Color.red
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
                    
                    
                    Button("Checkout") {
                        Task {
                            let ticketString = ticket?.utf8 ?? "".utf8
                            let ticketData = Data(ticketString)
                            let ticket = try JSONDecoder().decode(CheckInModel.Ticket.self, from: ticketData)
                            await checkOutApi.getPayment(ticket: ticket)
                            let jsonData = try JSONEncoder().encode(checkOutApi.payment)
                            let jsonString = String(data: jsonData, encoding: .utf8)!
                            payment = jsonString
                            stepId = 7
                        }
                    }
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50, alignment: .center)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                    
                    
                    if isALongTermParker == true {
                        Button("Fast Checkout (pay later)") {
                            Task {
                                let ticketString = ticket?.utf8 ?? "".utf8
                                let ticketData = Data(ticketString)
                                let ticket = try JSONDecoder().decode(CheckInModel.Ticket.self, from: ticketData)
                                await checkOutApi.payLater(ticket: ticket)
                                let jsonData = try JSONEncoder().encode(checkOutApi.payment)
                                let jsonString = String(data: jsonData, encoding: .utf8)!
                                payment = jsonString
                                stepId = 1
                            }
                        }
                        .foregroundColor(.black)
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(10)
                        }
                }
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                Task{
                    let ticketString = ticket?.utf8 ?? "".utf8
                    let ticketData = Data(ticketString)
                    let ticket = try JSONDecoder().decode(CheckInModel.Ticket.self, from: ticketData)
                    if ticket.longTermParkerId != nil {
                        isALongTermParker = true
                    }
                    
                }
            }
        }
    
    }


struct CheckOutTicketPage_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutTicket()
    }
}
