//
//  ContentView.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var spaceData: SpaceData?
    
    var body: some View {
        //Home()
        Button(action: loadData) {
            Text("test")
            
        }
    }

    // ViewModel
    private func loadData() {
        guard let url = URL(string: "http://127.0.0.1:8080/") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _,
            error in
            guard let data = data, error == nil else {
                return
            }
            print(String(data:data,encoding: .utf8)!)
        }
        task.resume()
    }
    }


//Model
struct SpaceData: Decodable {
    var freeNormalParkingSpaces: String
    var freeReservedParkingSpaces: String
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
