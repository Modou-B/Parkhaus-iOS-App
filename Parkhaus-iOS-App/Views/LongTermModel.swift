//
//  ShortTermModel.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 22.05.23.
//

import Foundation

class LongTermModel: ObservableObject {
    struct Response: Codable {
        let longTermParkerId: Int
        let username: String
        let password: String
        let hasError: String
        let errorMessage: String
        let errorCode: String
    }
    
//    @Published var longTermParkerValues: Response = Response(licencePlate: "XXXXYYY",arrivedAt: Date(), longTermParkerId: 1, password: "1234")
    
    func LongTermCheckIn(licencePlate: String, username: String, password: String) async {
        
        
        
        
        guard let url = URL(string: "http://127.0.0.1:8080/CheckIn/LongTermParker") else {
            return
        }


        print("Making api call...")

        var request = URLRequest(url: url)
        // method, boy, headers
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        print("TEST: \(licencePlate),\(username),\(password)")

        let body: [String: AnyHashable] = [
            "longTermParkerId": 1,
            "username": username,
            "password": password,
            "hasError": "",
            "errorMessage": "",
            "errorCode": "",
//            "licencePlate": licencePlate,
//            "arrivedAt": 1,
//            "longTermParkerId": username,
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

