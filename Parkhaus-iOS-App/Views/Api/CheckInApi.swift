//
//  ShortTermModel.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 26.05.23.
//

import Foundation

@MainActor
class CheckInApi: AbstractApi {
    let shortTermUrl: String = "http://127.0.0.1:8080/CheckIn/ShortTermParker"
    let longTermUrl: String = "http://127.0.0.1:8080/CheckIn/LongTermParker"

    @Published var ticket: CheckInModel.Ticket = CheckInModel.Ticket()
    @Published var loginResponse: CheckInModel.LoginResponse = CheckInModel.LoginResponse()
    @Published var wasSuccessful: Bool = false
    @Published var hasError: Bool = false

    public func checkInShortTermParker(licensePlate: String) async {
        let body = [
            "licensePlate": licensePlate,
        ]
        
        let headers = [
            "Content-Type": "application/json",
        ]
        
        var responseDate: Data? = nil
        responseDate = await makeRequest(url: self.shortTermUrl, body:body, method: "POST", headers: headers)
        
        if responseDate == nil {
            return
        }
        
        do {
            let decodedResult = try JSONDecoder().decode(CheckInModel.Ticket.self, from: responseDate ?? Data())
            ticket = decodedResult
            wasSuccessful = true
        } catch {
            print("Invalid Response Data")
            
        }
    }
    
    public func checkInLongTermParker(licensePlate: String, username: String, password: String) async {
        let body = [
            "licensePlate": licensePlate,
            "username": username,
            "password": password,
        ]
        
        let headers = [
            "Content-Type": "application/json",
        ]
        
        var responseDate: Data? = nil
        responseDate = await makeRequest(url: self.longTermUrl, body:body, method: "POST", headers: headers)
        
        if responseDate == nil {
            return
        }
        
        do {
            let decodedLoginResponseResult = try JSONDecoder().decode(CheckInModel.LoginResponse.self, from: responseDate ?? Data())
            loginResponse = decodedLoginResponseResult
    
            if (loginResponse.error != nil) {
                hasError = true
                return
            }
            
            let decodedTicketResult = try JSONDecoder().decode(CheckInModel.Ticket.self, from: responseDate ?? Data())
            ticket = decodedTicketResult
            wasSuccessful = true
        } catch {
            print("Invalid Response Data")
        }
    }
}

