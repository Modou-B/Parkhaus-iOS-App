//
//  CheckOutApi.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 30.05.23.
//

import Foundation

@MainActor
class CheckOutApi: AbstractApi {
    let getPaymentUrl: String = "http://127.0.0.1:8080/checkOut/getPayment"
    let payLaterUrl: String = "http://127.0.0.1:8080/checkOut/later"
    let directPaymentUrl: String = "http://127.0.0.1:8080/checkOut/direct"
    
    @Published var payment: PaymentModel.Payment = PaymentModel.Payment()
    @Published var wasSuccessful: Bool = false

    public func getPayment(ticket: TicketModel.Ticket) async {
        let body: [String: Any] = [
            "parkerIdentifier": ticket.parkerIdentifier ?? "",
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
            let decodedResult = try JSONDecoder().decode(PaymentModel.Payment.self,from: responseDate ?? Data())
            payment = decodedResult
            print("\(payment)")
            wasSuccessful = true
        } catch {
            print("Invalid Response Data")

        }
    }
    
    public func payLater(ticket: TicketModel.Ticket) async {
        let body: [String: Any] = [
            "parkerIndentifier": ticket.parkerIdentifier ?? "",
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
    }

    public func directPayment(payment: PaymentModel.Payment) async {
        let body: [String: Any] = [
            "parkerIndentifier": payment.parkerIdentifier ?? "",
            "licensePlate": payment.licensePlate ?? "",
            "arrivedAt": payment.arrivedAt ?? "",
            "departuredAt": payment.departuredAt ?? "",
            "amount": payment.amount ?? 0,
        ]
        
        let headers = [
            "Content-Type": "application/json",
        ]
  
        _ = await makeRequest(url: self.directPaymentUrl, body:body, method: "POST", headers: headers)
    }
}
