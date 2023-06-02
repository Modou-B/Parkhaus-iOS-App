//
//  ParkingSpotsModel.swift
//  Parkhaus-iOS-App
//
//  Created by Julian Sommer on 26.05.23.
//

import SwiftUI

class ParkingSpotsModel: ObservableObject {
    struct ParkingSpotCollection: Codable {
        let parkingSpots: [ParkingSpot]?
        
        init(parkingSpots: [ParkingSpot]? = []) {
            self.parkingSpots = parkingSpots
        }
    }
    
    
    struct ParkingSpot: Codable {
        let id: String
        let reserved: String
        let isFree: String
    }
    
    
    @Published var parkingSpotCollection: ParkingSpotCollection = ParkingSpotCollection()
    @Published var dataIsLoaded: Bool = false
    
    
    @MainActor
    func fetchParkingSpots()  async {
        guard let url = URL(string: "http://127.0.0.1:8080/parkingSpots") else {
            return
        }

        do {
            let (responseData, _) = try await URLSession.shared.data(from: url)
            
            
            let decodedResult = try JSONDecoder().decode(ParkingSpotCollection.self, from: responseData)
            parkingSpotCollection = decodedResult
        
            dataIsLoaded = true
        } catch {
            print("Invalid Response Data")
        }
    }
}
