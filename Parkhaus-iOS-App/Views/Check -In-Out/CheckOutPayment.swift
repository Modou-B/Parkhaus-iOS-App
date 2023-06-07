//
//  CheckOutPayment.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 30.05.23.
//

import SwiftUI

struct CheckOutPayment: View {
    @State private var parkingSpotBooked: Float = 0
    @State private var paymentStruct: PaymentModel.Payment = PaymentModel.Payment()
    @State private var isLoaded: Bool = false

    @Environment(\.presentationMode) var presentationMode
    @StateObject var carParkingApi = CarParkingApi()
    @StateObject var checkOutApi = CheckOutApi()
    
    @AppStorage("ticket") var ticket: String?
    @AppStorage("parkingSpotId") var id: Int?
    @AppStorage("isShortTermParker") var isShortTermParker: Bool?
    @AppStorage("isLongTermParker") var isLongTermParker: Bool?
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
                .frame(width: 412.3, height: 390)
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
                    Text("Payment Transaction")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    Text("Parking spot: \(id ?? 0)")
                        .font(.system(size: 30, weight: .medium, design: .rounded))
                        .foregroundColor(Color.green)
                    
                    Spacer()
                        .frame(height: 50)
                    
                    VStack(alignment: .center) {
                        
                        Text("PAYMENT AMOUNT: \(formatPaymentAmount(amount: paymentStruct.amount ?? 0.00))")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(Color.black.opacity(0.7))
                        
                        Spacer()
                            .frame(height: 10)
                        
                        VStack(alignment: .trailing) {
                            Text("ARRIVED AT: \(paymentStruct.arrivedAt ?? "")")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(Color.black.opacity(0.7))
                            
                            Spacer()
                                .frame(height: 10)
                            
                            Text("DEPARTURED AT: \(paymentStruct.departuredAt ?? "")")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundColor(Color.black.opacity(0.7))
                            
                            Spacer()
                                .frame(height: 30)
                        }
                        
                    }
                    
                    Button("Pay") {
                        Task {
                            let paymentString = payment?.utf8 ?? "".utf8
                            let paymentData = Data(paymentString)
                            let paymentJSON = try JSONDecoder().decode(PaymentModel.Payment.self, from: paymentData)
                            await checkOutApi.directPayment(payment: paymentJSON)
                            let jsonData = try JSONEncoder().encode(checkOutApi.payment)
                            let jsonString = String(data: jsonData, encoding: .utf8)!
                            payment = jsonString
                            stepId = 1
                            isShortTermParker = false
                            isLongTermParker = false
                        }
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                loadPaymentData()
            }
    }

    private func loadPaymentData() -> Void {
        let paymentString = payment?.utf8 ?? "".utf8
        let paymentData = Data(paymentString)
        do {
            self.paymentStruct = try JSONDecoder().decode(PaymentModel.Payment.self, from: paymentData)
        }
        catch {
            print("Data cannont be loaded")
        }
    }
    
    private func formatPaymentAmount(amount: Float) -> String {
        let formatter = NumberFormatter()
           formatter.maximumFractionDigits = 2

        return formatter.string(from: amount as NSNumber) ?? "\(amount)"
    }
}

struct CheckOutPayment_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutPayment()
    }
}
