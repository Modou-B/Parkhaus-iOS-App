//
//  TicketModel.swift
//  Parkhaus-iOS-App
//
//  Created by Julian Sommer on 27.05.23.
//

import SwiftUI

class CheckInModel {
    struct Ticket: Decodable, Encodable {
        let licensePlate: String?
        let arrivedAt: String?
        let longTermParkerId: Int?
        
        init(licesePlate: String? = nil, arrivedAt: String? = nil, longTermParkerId: Int? = nil) {
            self.licensePlate = licesePlate
            self.arrivedAt = arrivedAt
            self.longTermParkerId = longTermParkerId
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
