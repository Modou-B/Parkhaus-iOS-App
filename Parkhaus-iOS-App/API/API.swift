//
//  API.swift
//  Parkhaus-App
//
//  Created by Modou on 17.05.23.
//

import Foundation

class ParkhausInfo {
    private static let defaultSession = URLSession(configuration: .default)
    
    static func getFreeParkingSpaceCount(completion: @escaping (FreeParkingSpaceCount?,String?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8080/") else {
            return
        }
        
        defaultSession.FreeParkingSpaceCountTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error as Any)
                return
            }
                
            DispatchQueue.main.async {
                completion(data, error?.localizedDescription)
            }
        }.resume()
    }
}
