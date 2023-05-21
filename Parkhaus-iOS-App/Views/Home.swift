//
//  Home.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct Home: View {
    @State var LongTermParkerLoginLbl = "Long Term Parker"
    @State var ShortTermParkerLoginLbl = "Short Term Parker"
    
    
    
    var NParkingSpaces = 0
    var RParkingSpaces = 0
    
    var body: some View {
        
        
//        var num1 = 0
//        var num2 = 0
        
        
        NavigationView() {
            
            ZStack {
                
                VStack {
                    
                    NavigationLink(destination: LongTermParkerLogin()) {
                        Text(LongTermParkerLoginLbl+" \(RParkingSpaces)")
                    }
                    .bold()
                    .frame(height: 55).border(Color.red)
                    .onAppear() {
                        print("\(NParkingSpaces)")
//                        var result = Api().getter()
//                        print("\(result.0)")
//                        load()
//                        num1 = Api().freeNormalParkingSpaces
//                        num2 = Api().getData()
                        Api().getData()
                    }
                    
                    NavigationLink(destination: ShortTermParkerLogin()) {
                        Text("Short Term Parker \(NParkingSpaces)")
                    }
                    .bold()
                    .frame(height: 55).border(Color.red)
                    .padding(50)
                    
                    
                    Button("Button") {
//                        load()
//                        num1 = Api().getDataWithValues()
//                        print("Test: \(num1)")
//                        self.LongTermParkerLoginLbl = "\(num1)"
                    }
                    
                }
                
                .navigationTitle("Home")
            }
        }
        
    }
}

//func load() {
//    Api().getData()
//}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
