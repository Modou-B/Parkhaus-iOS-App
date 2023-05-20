//
//  LongTermParkerLogin.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct LongTermParkerLogin: View {
    @State private var username = ""
    @State private var licensePlate = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: self.$username)
                .frame(height: 55).border(Color.red)
                        
            TextField("License Plate", text: self.$licensePlate)
                .frame(height: 55).border(Color.red)
            
            NavigationLink(destination: ParkingSpaceGrid()) {
                Text("Click here")
            }
            
        }
    }
}


struct LongTermParkerLogin_Previews: PreviewProvider {
    static var previews: some View {
        LongTermParkerLogin()
    }
}
