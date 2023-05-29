//
//  ContentView.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

let parkingSpaceUrl = "http://127.0.0.1:8080/"


struct ContentView: View {
    @AppStorage("parkingSpotId") var id: Int?
    
    var body: some View {
//        if id != 0 {
            Home()
//        } else {
//            CheckOutTicketPage()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
