//
//  Data.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

class ParkingSpaceModel: ObservableObject {
    struct ParkingSpaces: Codable {
        let freeNormalParkingSpaces: Int
        let freeReservedParkingSpaces: Int
    }
    
    @Published var parkingSpaces: ParkingSpaces = ParkingSpaces(freeNormalParkingSpaces: 0, freeReservedParkingSpaces: 0)
    @Published var dataIsLoaded: Bool = false
    
    @MainActor
    func fetchParkingSpaceCounts()  async {
        guard let url = URL(string: "http://127.0.0.1:8080/") else {
            return
        }

        do {
            let (responseData, _) = try await URLSession.shared.data(from: url)

            parkingSpaces = try JSONDecoder().decode(ParkingSpaces.self, from: responseData)
            dataIsLoaded = true
        } catch {
            print("Invalid Response Data")
        }
    }
}
