//
//  CheckOutTicketPage.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 29.05.23.
//

import SwiftUI

struct CheckOutTicketPage: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var checkOutApi = CheckOutApi()
    @AppStorage("ticket") var ticket: String?
    @AppStorage("parkingSpotId") var id: Int?
    @AppStorage("step") var stepId: Int?
    @AppStorage("payment") var payment: String?
    
    @State private var parkingSpotBooked: Float = 0
    @State private var isALongTermParker: Bool = false
    
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
                                
                                print(id)
                                parkingSpotBooked = 2
                                stepId = 7
                                print("StepID: \(stepId)")
                            }
                        }
                        .foregroundColor(.black)
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(10)
                        .border(.green, width: CGFloat(parkingSpotBooked))
                    
                    
                    if isALongTermParker == true {
                        Button("Fast Checkout (pay later)") {
                            Task {
                                let ticketString = ticket?.utf8 ?? "".utf8
                                let ticketData = Data(ticketString)
                                let ticket = try JSONDecoder().decode(CheckInModel.Ticket.self, from: ticketData)
                                
//                                await carParkingApi.parkCar(licensePlate: ticket.licensePlate ?? "", parkingSpotId: id ?? 0)
                                print(id)
                                parkingSpotBooked = 2
                                stepId = 1
                                print("StepID: \(stepId)")
                            }
                        }
                        .foregroundColor(.black)
                        .frame(width: 300, height: 50, alignment: .center)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(10)
                        .border(.green, width: CGFloat(parkingSpotBooked))
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
        CheckOutTicketPage()
    }
}
