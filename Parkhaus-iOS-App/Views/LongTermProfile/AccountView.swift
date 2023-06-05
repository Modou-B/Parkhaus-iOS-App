//
//  AccountView.swift
//  Parkhaus-iOS-App
//
//  Created by Julian Sommer on 04.06.23.
//

import SwiftUI

struct AccountView: View {
    @State private var licensePlate = ""
    @State private var wrongLicensePlate: Float  = 0

    @StateObject var checkInApi = CheckInApi()
    @StateObject var accountOverviewApi = AccountOverviewApi()
    
    @AppStorage("ticket") var ticket: String?
    @AppStorage("loginIdentifier") var loginIdentifier: String?
    @AppStorage("step") var stepId: Int?
    
    let wrongUsernameErrorCode: Int = 901
    let wrongPasswordErrorCode: Int = 902
    
    let date = Date()
    let df = DateFormatter()
 
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 50))
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                Color.white.opacity(0.5)
                    .ignoresSafeArea()
                Color.purple.opacity(0.15)
                    .ignoresSafeArea()
                ScrollView {
                    
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
                        VStack {
                            Text("Account Details")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                            
                            TextField("License Plate", text: $licensePlate)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(10)
                                .border(.red, width: CGFloat(wrongLicensePlate))
                            
                            Spacer()
                                .frame(height: 30)
                            
                            Button("CheckIn") {
                                Task {
                                    let loginIdentifier = loginIdentifier ?? ""
                                    await checkInApi.checkInLongTermParker(licensePlate: licensePlate, identifier: loginIdentifier)
                                    
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
                            
                            Spacer()
                                .frame(height: 30)
                            
                        } // End VStack
                        .onAppear {
                            stepId = 2
                        }
                        
                    } // End ZStack
                    .compositingGroup()
                    .frame(width: 412.3, height: 400)
                    .rotationEffect(.degrees(-0))
                    .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.05000000074505806)), radius:33.98135757446289, x:22.969558715820312, y:22.969558715820312)
                    
                    ZStack{
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
                        
                        VStack {
                            Text("Open bills")
                                .font(.largeTitle)
                                .bold()
                                .padding()
                            
                            if (accountOverviewApi.wasSuccessful) {
                                ScrollView {
                                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                                        ForEach(accountOverviewApi.openPaymentCollection.openPayments ?? [], id: \.id) { openPayment in
                                            VStack {
                                                ZStack {
                                                    Rectangle()
                                                        .frame(width: 50, height: 50)
                                                        .foregroundColor(.blue)
                                                    
                                                    VStack {
                                                        Text("\(openPayment.arrivedAt)")
                                                            .bold()
                                                            .padding()
                                                        
                                                        Spacer()
                                                            .frame(height: 30)
                                                        
                                                        HStack {
                                                            Text("\(openPayment.amount)")
                                                                .bold()
                                                                .padding()
                                                            Text("\(openPayment.licensePlate)")
                                                                .bold()
                                                                .padding()
                                                            Text("\(openPayment.departuredAt)")
                                                                .bold()
                                                                .padding()
                                                        }
                                                    }
                                                    
                                                }
                                            }
                                        }
                                    }
                                } // End ScrollView
                            }
                           
                        } // End VStack
                    } // End ZStack
                } // End ScrollView
                
            } // End ZStack
            .task {
                let loginIdentifier = loginIdentifier ?? ""
                
                await accountOverviewApi.fetchOpenPayments(identifier: loginIdentifier)
            }
        } // End NavigationStack
       
    } // End View
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
