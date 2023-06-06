//
//  AbstractApi.swift
//  Parkhaus-iOS-App
//
//  Created by Julian Sommer on 27.05.23.
//

import Foundation
import SwiftUI

class AbstractApi: ObservableObject {
    public func makeRequest(url: String, body: [String: Any], method: String, headers: [String: String]) async -> Data? {
        guard let url = URL(string: url) else {
            return nil
        }
       
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
     
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        do {
            let (responseData, _) = try await URLSession.shared.data(for: request)
            
            return responseData
        } catch {
            print("Invalid Response Data")
            
            return nil
        }
    }
    
    public func makeGetRequest(url: String, headers: [String: String]) async -> Data? {
        guard let url = URL(string: url) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        do {
            let (responseData, _) = try await URLSession.shared.data(for: request)
            
            return responseData
        } catch {
            print("Invalid Response Data")
            
            return nil
        }
    }
}
