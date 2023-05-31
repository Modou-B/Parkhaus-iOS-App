//
//  PaymentModal.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 31.05.23.
//

import Foundation

class PaymentModal {
    struct Payment: Decodable, Encodable {
        let arrivedAt: String?
        let departuredAt: String?
        let licensePlate: String?
        let amount: Float?
        
        
        init(licesePlate: String? = nil, arrivedAt: String? = nil, amount: Float? = nil, departuredAt: String? = nil) {
            self.licensePlate = licesePlate
            self.arrivedAt = arrivedAt
            self.amount = amount
            self.departuredAt = departuredAt
        }
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
