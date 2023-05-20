//
//  Home.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        
        NavigationView() {
            
            ZStack {
                
                VStack {
                    
                    NavigationLink(destination: LongTermParkerLogin()) {
                        Text("Long Term Parker")
                    }
                    .bold()
                    .frame(height: 55).border(Color.red)
                    
                    NavigationLink(destination: ShortTermParkerLogin()) {
                        Text("Short Term Parker")
                    }
                    .bold()
                    .frame(height: 55).border(Color.red)
                    .padding(50)
                }
                
                .navigationTitle("Home")
            }
        }
        
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
