//
//  Home.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct Home: View {
    @State var LongTermParkerLoginLbl = "Log into your account"
    @State var ShortTermParkerLoginLbl = "Park short term"
    @State var ShortTermParkingSpacesLbl = "Free Short Term Parking Spaces:"
    @State private var showingLongTermLoginScreen = false
    @State private var showingShortTermLoginScreen = false
    @State private var showCheckOut = false
    @State private var shortTermButtonDisabled = false
    
    @StateObject var parkingSpaceModel = ParkingSpaceModel()
    @AppStorage("parkingSpotId") var id: Int?
    @AppStorage("freeNormalParkingSpaces") var freeNormalParkingSpaces: Int?
    @AppStorage("freeReservedParkingSpaces") var freeReservedParkingSpaces: Int?

    @AppStorage("step") var stepId: Int?
    
    var body: some View {
        NavigationStack() {
            ZStack {
                ZStack {
                    Color.blue
                        .ignoresSafeArea()
                    Circle()
                        .scale(1.7)
                        .foregroundColor(.white.opacity(0.5))
                    Circle()
                        .scale(1.35)
                        .foregroundColor(.purple.opacity(0.15))
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 45.87)
                        .fill(LinearGradient(
                                gradient: Gradient(stops: [
                            .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6000000238418579)), location: 0),
                            .init(color: Color(#colorLiteral(red: 0.8509804010391235, green: 0.8509804010391235, blue: 0.8509804010391235, alpha: 0.20000000298023224)), location: 1)]),
                                startPoint: UnitPoint(x: -0.0015019709411221993, y: 0.011388006885359792),
                                endPoint: UnitPoint(x: 1.0189002040034465, y: 0.9898934130319252)))

                        RoundedRectangle(cornerRadius: 45.87)
                        .strokeBorder(LinearGradient(
                                gradient: Gradient(stops: [
                            .init(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.699999988079071)), location: 0),
                            .init(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.10000000149011612)), location: 1)]),
                                startPoint: UnitPoint(x: 0.017291056030272978, y: 0.043389347588974614),
                                endPoint: UnitPoint(x: 0.9767208936133693, y: 0.9648771623222485)), lineWidth: 1.6990679502487183)
                    }
                    .compositingGroup()
                    .frame(width: 412.3, height: 311.8)
                    .rotationEffect(.degrees(-0))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.05000000074505806)), radius:33.98135757446289, x:22.969558715820312, y:22.969558715820312)
                     
                    VStack(alignment: .center) {
                        Text("Parking Lot Home")
                            .font(.largeTitle)
                            .bold()
                            .padding()
                        
                        if parkingSpaceModel.dataIsLoaded {
                            Text("\(ShortTermParkingSpacesLbl) \(freeNormalParkingSpaces ?? 0)")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
 
                            Spacer()
                                .frame(height: 30)
        
                            Button(ShortTermParkerLoginLbl) {
                                checkAvailability()
                                if shortTermButtonDisabled == false {
                                    showingShortTermLoginScreen = true
                                }
                            }
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .navigationDestination(
                                isPresented: $showingShortTermLoginScreen) { LoginShortTermParker()}
                                .alert(isPresented: $shortTermButtonDisabled) {
                                Alert(title: Text("No free spaces"), message: Text("All short term parking spaces are booked."))}
                            
                            Spacer()
                                .frame(height: 10)
                            
                            Button(LongTermParkerLoginLbl) {
                                showingLongTermLoginScreen = true
                            }
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .navigationDestination(
                                isPresented: $showingLongTermLoginScreen) { LoginLongTermParker() }
                            
                        } else {
                            Text("Loading parking spot data...")
                        }
                    }
//                    .navigationTitle("Home")
                    .onAppear {
                        stepId = 1
                    }
                }
            } .task {
                await parkingSpaceModel.fetchParkingSpaceCounts()
                
                if parkingSpaceModel.dataIsLoaded {
                    freeNormalParkingSpaces = parkingSpaceModel.parkingSpaces.freeNormalParkingSpaces
                    freeReservedParkingSpaces = parkingSpaceModel.parkingSpaces.freeReservedParkingSpaces
                }
            }
        }
    }
    
    func checkAvailability(){
        if parkingSpaceModel.parkingSpaces.freeNormalParkingSpaces <= 4 {
            shortTermButtonDisabled = true
            
        } else {
            shortTermButtonDisabled = false
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
