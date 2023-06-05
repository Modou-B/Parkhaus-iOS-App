//
//  ContentView.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

let parkingSpaceUrl = "http://127.0.0.1:8080/"

struct ContentView: View {
    @AppStorage("step") var id: Int?
    
    var body: some View {
        switch id {
        case 1:
            Home()
        case 2:
            LoginLongTermParker()
        case 3 :
            LoginShortTermParker()
        case 4:
            ParkingSpaceGrid()
        case 5:
            CheckInTicket()
        case 6:
            CheckOutTicket()
        case 7:
            CheckOutPayment()
        default:
            Home()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
