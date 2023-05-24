//
//  ParkingSpaceGrid.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 19.05.23.
//

import SwiftUI

struct ParkingSpaceGrid: View {
    private let data: [Int] = Array(1...180)
        private let colors: [Color] = [.green, .green, .green, .red]
        
        // Flexible, custom amount of columns that fill the remaining space
        private let numberColumns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
        // Adaptive, make sure it's the size of your smallest element.
        private let adaptiveColumns = [
            GridItem(.adaptive(minimum: 50))
        ]
        
        // Fixed, creates columns with fixed dimensions
        private let fixedColumns = [
            GridItem(.fixed(200)),
            GridItem(.fixed(200))
        ]
        
        var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                        ForEach(data, id: \.self) { number in
                            ZStack {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(colors[number%4])
                                    .cornerRadius(30)
                                Text("\(number)")
                                    .foregroundColor(.white)
                                    .font(.system(size: 30, design: .rounded))
                            }
                        }
                    }
                }
                .navigationTitle("Parking Spaces")
                .padding()
            }
        }}


struct ParkingSpaceGrid_Previews: PreviewProvider {
    static var previews: some View {
        ParkingSpaceGrid()
    }
}
