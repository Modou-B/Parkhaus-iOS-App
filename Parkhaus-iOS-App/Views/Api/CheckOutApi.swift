//
//  CheckOutApi.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 30.05.23.
//

import Foundation

@MainActor
class CheckOutApi: AbstractApi {
    let getPaymentUrl: String = "http://127.0.0.1:8080/CheckOut/GetPayment"
    let payLaterUrl: String = "http://127.0.0.1:8080/CheckOut/PayLater"
    let directPayment: String = "http://127.0.0.1:8080/CheckOut/DirectPayment"
    
    
    @Published var payment: PaymentModal.Payment = PaymentModal.Payment()
    
    
    
    @Published var loginResponse: CheckInModel.LoginResponse = CheckInModel.LoginResponse()
    @Published var wasSuccessful: Bool = false
    @Published var hasError: Bool = false
    
    public func getPayment(ticket: CheckInModel.Ticket) async {
        let body: [String: Any] = [
            "licensePlate": ticket.licensePlate ?? "",
            "arrivedAt": ticket.arrivedAt ?? "",
            "longTermParkerId": ticket.longTermParkerId ?? 0,
        ]

        let headers = [
            "Content-Type": "application/json",
        ]




        var responseDate: Data? = nil
        responseDate = await makeRequest(url: self.getPaymentUrl, body:body, method: "POST", headers: headers)

        if responseDate == nil {
            return
        }

        do {
            let decodedResult = try JSONDecoder().decode(PaymentModal.Payment.self,from: responseDate ?? Data())
            payment = decodedResult
            print("\(payment)")
            wasSuccessful = true
        } catch {
            print("Invalid Response Data")

        }
    }
    
    
    public func payLater(ticket: CheckInModel.Ticket) async {
        let body: [String: Any] = [
            "licensePlate": ticket.licensePlate ?? "",
            "arrivedAt": ticket.arrivedAt ?? "",
            "longTermParkerId": ticket.longTermParkerId ?? 0,
        ]
        
        let headers = [
            "Content-Type": "application/json",
        ]
        
        
        
        
        var responseDate: Data? = nil
        responseDate = await makeRequest(url: self.payLaterUrl, body:body, method: "POST", headers: headers)

        if responseDate == nil {
            return
        }
        
//        do {
//            let decodedResult = try JSONDecoder().decode(PaymentModal.Payment.self,from: responseDate ?? Data())
//            payment = decodedResult
//            print(payment)
//            wasSuccessful = true
//        } catch {
//            print("Invalid Response Data")
//
//        }
    }
    
}

