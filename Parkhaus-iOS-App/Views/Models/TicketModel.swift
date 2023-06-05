//
//  TicketModel.swift
//  Parkhaus-iOS-App
//
//  Created by Julian Sommer on 27.05.23.
//

import SwiftUI

class TicketModel {
    struct Ticket: Decodable, Encodable {
        let parkerIdentifier: String?
        let licensePlate: String?
        let arrivedAt: String?
        let longTermParkerId: Int?
        
        init(parkerIdentifier: String? = nil, licesePlate: String? = nil, arrivedAt: String? = nil, longTermParkerId: Int? = nil) {
            self.parkerIdentifier = parkerIdentifier
            self.licensePlate = licesePlate
            self.arrivedAt = arrivedAt
            self.longTermParkerId = longTermParkerId
        }
    }
    
    struct LoginResponse: Decodable, Encodable {
        let identifier: String?
        let error: String?
        let errorCode: Int?
        
        init(identifier: String? = nil, error: String? = nil, errorCode: Int? = nil) {
            self.identifier = identifier
            self.error = error
            self.errorCode = errorCode
        }
    }
}
