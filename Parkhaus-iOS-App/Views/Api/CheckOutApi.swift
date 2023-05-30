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
    let payLaterUrl: String = "http://127.0.0.1:8080/CheckOut/PayLatet"
    let directPayment: String = "http://127.0.0.1:8080/CheckOut/DirectPayment"
    
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
        responseDate = await makeRequest(url: self.getPaymentUrl, body:body, method: "POST", headers: headers)
        
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
        responseDate = await makeRequest(url: self.payLaterUrl, body:body, method: "POST", headers: headers)
        
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

