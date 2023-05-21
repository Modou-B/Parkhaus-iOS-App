//
//  Data.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI



class Api: ObservableObject {
    
    @Published var freeNormalParkingSpaces = 0
    @Published var freeReservedParkingSpaces = 0
    
    @Published var dataIsLoaded: Bool = false
    
    
    
    
    
    func getData()  {
        guard let url = URL(string: "http://127.0.0.1:8080/") else {
            return
        }
                
        let task = URLSession.shared.dataTask(with: url) { [self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])

            if let dictionary = json as? [String: Any] {
                if let number = dictionary["freeNormalParkingSpaces"] as? Int {
                    print(number)
//                    self.freeNormalParkingSpaces = number
                    
                }
                if let number = dictionary["freeReservedParkingSpaces"] as? Int {
                    print(number)
//                    self.freeReservedParkingSpaces = number
                    
                }
            }
        }
        task.resume()
    }
    
    
//    func setter() {
//        Home(RParkingSpaces: <#T##Int#>)
//    }
    
//    func getter() -> (Int, Int){
//        getData()
//        let long = freeReservedParkingSpaces
//        let short = freeNormalParkingSpaces
//
//        return (long, short)
//    }
    
    
//    func getDataWithValues() -> Int {
//        getData()
//        return freeReservedParkingSpaces
//    }
}



//struct Data_Previews: PreviewProvider {
//    
//    static var previews: some View {
//        VStack {
//            Label(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/, systemImage: /*@START_MENU_TOKEN@*/"42.circle"/*@END_MENU_TOKEN@*/)
//            .onAppear(perform: ) {
//                Api().getData()
//            }
//            Text("\(freeNormalParkingSpaces)")
//            Text("\(freeReservedParkingSpaces)")
//        }
//    }
//}
