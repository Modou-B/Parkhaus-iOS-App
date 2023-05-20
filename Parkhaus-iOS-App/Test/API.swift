////
////  API.swift
////  Parkhaus-iOS-App
////
////  Created by Modou on 19.05.23.
////
//
//import Foundation
//
//
//struct freeParkingSpaceInfo: Codable {
//    let freeNormalParkingSpaces, freeReservedParkingSpaces: Int
//}
//
//@MainActor class freeParkingSpaceManager: ObservableObject {
//    @Published var resultURL = ""
//    
//    
//    func getData(){
//        guard let url = URL(string: "http://127.0.0.1:8080/") else {
//            print("Invalid req")
//            return
//        }
//        URLSession.shared.dataTask(with: url) { (data,response,error) in
//            guard let data = data else {
//                print("Could not retrieve data...")
//                
//                DispatchQueue.main.async {
//                    self.resultURL = "Could not retrieve data..."
//                }
//                return
//            }
//        }
//    }
//}
//
