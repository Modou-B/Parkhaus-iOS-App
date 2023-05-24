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
                .frame(height: 50)
                .padding(.horizontal)
                .overlay {
                     RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                   }
            
            
            TextField("License Plate", text: self.$licensePlate)
                .frame(height: 50)
                .padding(.horizontal)
                .overlay {
                     RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue, lineWidth: 2)
                   }
            
            Text(" ")
            NavigationLink(destination: ParkingSpaceGrid()) {
                Text("Validate data")
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .cornerRadius(5)
        }
    }
}


struct LongTermParkerLogin_Previews: PreviewProvider {
    static var previews: some View {
        LongTermParkerLogin()
    }
}
