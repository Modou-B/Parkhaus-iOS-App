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
    @AppStorage("step") var stepId: Int?
    @AppStorage("payment") var payment: String?
    
    
    
    var body: some View {
            ZStack {
                Color.orange
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
                    Text("Parking spot: \(id ?? 0)")
                        .font(.system(size: 30, weight: .medium, design: .rounded))
                        .foregroundColor(Color.green)
                    
                    
                    Spacer()
                        .frame(height: 50)
                    
                    
                    VStack(alignment: .center) {
                        Text("PAYMENT AMOUNT: \(paymentStruct.amount ?? 0)")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(Color.red.opacity(0.7))
                        
                        
                        Spacer()
                            .frame(height: 10)
                        
                        
                        Text("ARRIVED AT: \(paymentStruct.arrivedAt ?? "")")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(Color.red.opacity(0.7))
                        
                        
                        Spacer()
                            .frame(height: 10)
                        
                        
                        Text("DEPARTURED AT: \(paymentStruct.departuredAt ?? "")")
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundColor(Color.red.opacity(0.7))
                        
                        
                        Spacer()
                            .frame(height: 50)
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
                        }
                    }
                    .foregroundColor(.black)
                    .frame(width: 300, height: 50, alignment: .center)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                }
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                loadPaymentData()
            }
    }
    
    
    private func loadPaymentData() -> Bool {
        let paymentString = payment?.utf8 ?? "".utf8
        let paymentData = Data(paymentString)
        do {
            self.paymentStruct = try JSONDecoder().decode(PaymentModel.Payment.self, from: paymentData)
        }
        catch {
            print("Data cannont be loaded")
            
            return false
        }
        
        return true
    }
    
}


struct CheckOutPayment_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutPayment()
    }
}

