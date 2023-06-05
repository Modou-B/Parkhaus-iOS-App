//
//  CarParkingApi.swift
//  Parkhaus-iOS-App
//
//  Created by Julian Sommer on 27.05.23.
//

import Foundation

@MainActor
class CarParkingApi: AbstractApi {
    let carParkingUrl: String = "http://127.0.0.1:8080/Status/CarParking"

    @Published var wasSuccessful: Bool = false

    public func parkCar(licensePlate: String, parkingSpotId: Int) async {
        let body: [String: Any] = [
            "licensePlate": licensePlate,
            "parkingSpotId": parkingSpotId
        ]
        
        let headers = [
            "Content-Type": "application/json",
        ]
        
        _ = await makeRequest(url: self.carParkingUrl, body:body, method: "POST", headers: headers)
        
        wasSuccessful = true
    }
}
