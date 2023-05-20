//
//  ShortTermParkerLogin.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct ShortTermParkerLogin: View {
    @State private var licensePlate = ""
    
    var body: some View {
        VStack {
            TextField("License Plate", text: self.$licensePlate)
                .frame(height: 55).border(Color.red)
            
            NavigationLink(destination: ParkingSpaceGrid()) {
                Text("Click here")
            }
        }
    }
}


struct ShortTermParkerLogin_Previews: PreviewProvider {
    static var previews: some View {
        ShortTermParkerLogin()
    }
}
