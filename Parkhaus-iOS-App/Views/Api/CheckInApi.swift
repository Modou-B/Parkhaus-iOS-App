//
//  ShortTermModel.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 26.05.23.
//

import Foundation

@MainActor
class CheckInApi: AbstractApi {
    let shortTermCheckingUrl: String = "http://127.0.0.1:8080/CheckIn/ShortTermParker"
    let longTermCheckIn: String = "http://127.0.0.1:8080/CheckIn/LongTermParker"
    let longTermLogin: String = "http://127.0.0.1:8080/CheckIn/LongTermParker/Login"

    
    @Published var ticket: TicketModel.Ticket = TicketModel.Ticket()
    @Published var loginResponse: TicketModel.LoginResponse = TicketModel.LoginResponse()
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
        responseDate = await makeRequest(url: self.shortTermCheckingUrl, body:body, method: "POST", headers: headers)
        
        if responseDate == nil {
            return
        }
        
        do {
            let decodedResult = try JSONDecoder().decode(TicketModel.Ticket.self, from: responseDate ?? Data())
            ticket = decodedResult
            wasSuccessful = true
        } catch {
            print("Invalid Response Data")
            
        }
    }
    
    public func checkInLongTermParker(licensePlate: String, identifier: String) async {
        let body = [
            "licensePlate": licensePlate,
            "identifier": identifier,
        ]
        
        let headers = [
            "Content-Type": "application/json",
        ]
        
        var responseDate: Data? = nil
        responseDate = await makeRequest(url: self.longTermCheckIn, body:body, method: "POST", headers: headers)
        
        if responseDate == nil {
            return
        }
        
        do {
            let decodedTicketResult = try JSONDecoder().decode(TicketModel.Ticket.self, from: responseDate ?? Data())
            
            ticket = decodedTicketResult
            wasSuccessful = true
        } catch {
            print("Invalid Response Data")
        }
    }
    
    public func loginLongTermParker(username: String, password: String) async {
        let body = [
            "username": username,
            "password": password,
        ]
        
        let headers = [
            "Content-Type": "application/json",
        ]
        
        print(body)
        print(password)
        var responseData: Data? = nil
        responseData = await makeRequest(url: self.longTermLogin, body:body, method: "POST", headers: headers)
        
        if responseData == nil {
            return
        }
        
        do {
            let decodedLoginResponseResult = try JSONDecoder().decode(TicketModel.LoginResponse.self, from: responseData ?? Data())
            loginResponse = decodedLoginResponseResult
    
            if (loginResponse.error != nil) {
                hasError = true
                
                return
            }
            
            wasSuccessful = true
        } catch {
            print("Invalid Response Data")
        }
    }
}
