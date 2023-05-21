//
//  ContentView.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

let parkingSpaceUrl = "http://127.0.0.1:8080/"



//Model
//struct Model: Decodable {
//    let freeNormalParkingSpaces: String
//    let freeReservedParkingSpaces: String
//}




//class ViewModel: ObservableObject {
//    @Published var items = [Model]()
//
//    func loadData() {
//        guard let url = URL(string: "http://127.0.0.1:8080/") else {
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, _,
//            error in
//            guard let data = data, error == nil else {
//                return
//            }
//
//            print(String(data:data,encoding: .utf8)!)
//        }
//        task.resume()
//    }
//}




struct ContentView: View {
    
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
