//
//  ContentView.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("step") var id: Int?
        
    var body: some View {
        switch id {
            case 1:
                Home()
            case 2:
                LoginLongTermParker()
            case 3:
                AccountView()
            case 4 :
                LoginShortTermParker()
            case 5:
                ParkingSpaceGrid()
            case 6:
                CheckInTicket()
            case 7:
                CheckOutTicket()
            case 8:
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
