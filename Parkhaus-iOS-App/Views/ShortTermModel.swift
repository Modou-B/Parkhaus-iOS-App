//
//  ShortTermModel.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 26.05.23.
//

import Foundation

class ShortTermModel: ObservableObject {
    struct Response: Codable {
        let licencePlate: String
        let longTermParkerId: Int
        let username: String
        let password: String
        let hasError: String
        let errorMessage: String
        let errorCode: String
    }
    
//    @Published var longTermParkerValues: Response = Response(licencePlate: "XXXXYYY",arrivedAt: Date(), longTermParkerId: 1, password: "1234")
    
    func ShortTermCheckIn(licencePlate: String) async {
        
        
        
        
        guard let url = URL(string: "http://127.0.0.1:8080/CheckIn/ShortTermParker") else {
            return
        }


        print("Making api call...")

        var request = URLRequest(url: url)
        // method, boy, headers
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        print("TEST: \(licencePlate)")

        let body: [String: AnyHashable] = [
            "licencePlate": licencePlate,
//            "username": username,
//            "password": password,
        ]
//        print("TEST: \(licencePlate),\(username),\(password)")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        // Make the request
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                let response = try JSONDecoder().decode(Response.self, from: data)
                print("SUCCESS: \(response)")
            }
            catch {
                print("---------------------: \(error)")
            }
        }
        task.resume()
    }
}

