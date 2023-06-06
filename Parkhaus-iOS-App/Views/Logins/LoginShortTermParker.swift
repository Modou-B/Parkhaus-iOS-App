//
//  ShortTermParkerLogin.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct LoginShortTermParker: View {
    @State private var licensePlate = ""
    @State private var wrongLicensePlate: Float = 0
    
    @StateObject var checkInApi = CheckInApi()
    @Environment(\.presentationMode) var presentationMode
    
    @AppStorage("ticket") var ticket: String?
    @AppStorage("parkingSpotId") var id: Int?
    @AppStorage("step") var stepId: Int?

    var body: some View {
        NavigationStack {
            VStack {
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
   
                    VStack {
                        Text("Short Term Parker")
                            .font(.largeTitle)
                            .bold()
                            .padding()

                        TextField("License Plate", text: $licensePlate)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
     
                        Spacer()
                            .frame(height: 30)
                     
                        Button("Login") {
                            checkLicenseIsEmpty(licensePlate: licensePlate)
                            
                            Task {
                                await checkInApi.checkInShortTermParker(licensePlate: licensePlate)
                                let jsonData = try JSONEncoder().encode(checkInApi.ticket)
                                let jsonString = String(data: jsonData, encoding: .utf8)!
                                ticket = jsonString
                            }
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .navigationDestination(isPresented: $checkInApi.wasSuccessful) { ParkingSpaceGrid() }
                            .disabled(licensePlate.isEmpty)
                    }
                    .onAppear {
                        stepId = 4
                    }
                }
            }
        }
    }
  
    private func checkLicenseIsEmpty(licensePlate: String) {
        wrongLicensePlate = 0

        if licensePlate.isEmpty {
            wrongLicensePlate = 2
        }
    }
}

struct ShortTermParkerLogin_Previews: PreviewProvider {
    static var previews: some View {
        LoginShortTermParker()
    }
}
