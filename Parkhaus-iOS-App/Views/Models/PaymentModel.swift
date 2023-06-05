//
//  PaymentModal.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 31.05.23.
//

import Foundation

class PaymentModel {
    struct Payment: Decodable, Encodable {
        let parkerIdentifier: String?
        let arrivedAt: String?
        let departuredAt: String?
        let licensePlate: String?
        let amount: Float?
        
        init(parkerIdentifier: String? = nil, licesePlate: String? = nil, arrivedAt: String? = nil, amount: Float? = nil, departuredAt: String? = nil) {
            self.parkerIdentifier = parkerIdentifier
            self.licensePlate = licesePlate
            self.arrivedAt = arrivedAt
            self.amount = amount
            self.departuredAt = departuredAt
        }
    }
    
    struct OpenPaymentCollection: Codable {
        let openPayments: [OpenPayment]?
        
        init(openPayments: [OpenPayment]? = []) {
            self.openPayments = openPayments
        }
    }
    
    struct OpenPayment: Codable, Identifiable {
        let id: String
        let arrivedAt: String
        let departuredAt: String
        let licensePlate: String
        let amount: String
    }
   
    struct LoginResponse: Decodable, Encodable {
        let error: String?
        let errorCode: Int?
        
        init(error: String? = nil, errorCode: Int? = nil) {
            self.error = error
            self.errorCode = errorCode
        }
    }
}
