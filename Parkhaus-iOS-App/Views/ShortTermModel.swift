////
////  ShortTermModel.swift
////  Parkhaus-iOS-App
////
////  Created by Modou on 22.05.23.
////
//
//import Foundation
//
//class ShortTermModel: ObservableObject {
//    struct ShortTermParkerValues: Codable {
//        let licencePlate: String
//        let arrivedAt: Date
//        let longTermParkerId: String
//    }
//    
//    @Published var checkInShortTermParker: ShortTermParkerValues = ShortTermParkerValues(licencePlate: "", arrivedAt: Date.now,longTermParkerId: "")
//    @Published var licenseValid: Bool = false
//    
//    @MainActor
//    func fetchParkingSpaceCounts()  async {
//        guard let url = URL(string: "http://127.0.0.1:8080/CheckIn/ShortTermParker") else {
//            return
//        }
//        
//        do {
//            let (responseData, _) = try await URLSession.shared.data(from: url)
//            
//            ShortTermParkerValues = try JSONDecoder().decode(ShortTermParkerValues.self, from: responseData)
//            licenseValid = true
//        } catch {
//            print("Invalid Response Data")
//        }
//    }
//}
