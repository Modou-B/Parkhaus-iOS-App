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
                Color.blue
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.5))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.purple.opacity(0.15))
      
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
                .frame(width: 412.3, height: 311.8)
                .rotationEffect(.degrees(-0))
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.05000000074505806)), radius:33.98135757446289, x:22.969558715820312, y:22.969558715820312)
    
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
                    Text("Check-Out Ticket")
                        .font(.largeTitle)
                        .bold()
                        .padding()

                    Text("Booked parking spot: \(id ?? 0)")
                        .font(.system(size: 30, weight: .medium, design: .rounded))
                        .foregroundColor(Color.green)

                    Spacer()
                        .frame(height: 30)

                    Button("Checkout") {
                        Task {
                            let ticketString = ticket?.utf8 ?? "".utf8
                            let ticketData = Data(ticketString)
                            let ticket = try JSONDecoder().decode(TicketModel.Ticket.self, from: ticketData)
                            await checkOutApi.getPayment(ticket: ticket)
                            let jsonData = try JSONEncoder().encode(checkOutApi.payment)
                            let jsonString = String(data: jsonData, encoding: .utf8)!
                            payment = jsonString
                            stepId = 8
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)

                    if isALongTermParker == true {
                        Button("Fast Checkout (pay later)") {
                            Task {
                                let ticketString = ticket?.utf8 ?? "".utf8
                                let ticketData = Data(ticketString)
                                let ticket = try JSONDecoder().decode(TicketModel.Ticket.self, from: ticketData)
                                await checkOutApi.payLater(ticket: ticket)
                                let jsonData = try JSONEncoder().encode(checkOutApi.payment)
                                let jsonString = String(data: jsonData, encoding: .utf8)!
                                payment = jsonString
                                stepId = 1
                            }
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        }
                }
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                Task{
                    let ticketString = ticket?.utf8 ?? "".utf8
                    let ticketData = Data(ticketString)
                    let ticket = try JSONDecoder().decode(TicketModel.Ticket.self, from: ticketData)
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
