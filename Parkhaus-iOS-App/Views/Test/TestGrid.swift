//
//  TestGrid.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 27.05.23.
//

import SwiftUI

struct Item: Identifiable {
    
    let id = UUID()
    let Test: String
    let image: String
    let imgColor: Color
}


struct TestGrid: View {
    @State private var showingLoginScreen = false
 
    let items = [
        Item(Test: "1", image: "home", imgColor: .orange),
        Item(Test: "2", image: "money", imgColor: .green),
        Item(Test: "3", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "4", image: "vacation", imgColor: .green),
        Item(Test: "5", image: "user", imgColor: .blue),
        
        Item(Test: "6", image: "home", imgColor: .orange),
        Item(Test: "7", image: "money", imgColor: .green),
        Item(Test: "8", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "9", image: "vacation", imgColor: .green),
        Item(Test: "10", image: "user", imgColor: .blue),
        
        Item(Test: "11", image: "home", imgColor: .orange),
        Item(Test: "12", image: "money", imgColor: .green),
        Item(Test: "13", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "14", image: "vacation", imgColor: .green),
        Item(Test: "15", image: "user", imgColor: .blue),
        
        Item(Test: "16", image: "home", imgColor: .orange),
        Item(Test: "17", image: "money", imgColor: .green),
        Item(Test: "18", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "19", image: "vacation", imgColor: .green),
        Item(Test: "20", image: "user", imgColor: .blue),
        
        Item(Test: "21", image: "home", imgColor: .orange),
        Item(Test: "22", image: "money", imgColor: .green),
        Item(Test: "23", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "24", image: "vacation", imgColor: .green),
        Item(Test: "25", image: "user", imgColor: .blue),
        
        Item(Test: "26", image: "home", imgColor: .orange),
        Item(Test: "27", image: "money", imgColor: .green),
        Item(Test: "28", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "29", image: "vacation", imgColor: .green),
        Item(Test: "30", image: "user", imgColor: .blue),
        
        Item(Test: "31", image: "home", imgColor: .orange),
        Item(Test: "32", image: "money", imgColor: .green),
        Item(Test: "33", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "34", image: "vacation", imgColor: .green),
        Item(Test: "35", image: "user", imgColor: .blue),
        
        Item(Test: "36", image: "home", imgColor: .orange),
        Item(Test: "37", image: "money", imgColor: .green),
        Item(Test: "38", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "39", image: "vacation", imgColor: .green),
        Item(Test: "40", image: "user", imgColor: .blue),
        
        Item(Test: "41", image: "home", imgColor: .orange),
        Item(Test: "42", image: "money", imgColor: .green),
        Item(Test: "43", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "44", image: "vacation", imgColor: .green),
        Item(Test: "45", image: "user", imgColor: .blue),
        
        Item(Test: "46", image: "home", imgColor: .orange),
        Item(Test: "47", image: "money", imgColor: .green),
        Item(Test: "48", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "49", image: "vacation", imgColor: .green),
        Item(Test: "50", image: "user", imgColor: .blue),
        
        Item(Test: "51", image: "home", imgColor: .orange),
        Item(Test: "52", image: "money", imgColor: .green),
        Item(Test: "53", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "54", image: "vacation", imgColor: .green),
        Item(Test: "55", image: "user", imgColor: .blue),
        
        Item(Test: "56", image: "home", imgColor: .orange),
        Item(Test: "57", image: "money", imgColor: .green),
        Item(Test: "58", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "59", image: "vacation", imgColor: .green),
        Item(Test: "60", image: "user", imgColor: .blue),
        
        Item(Test: "61", image: "home", imgColor: .orange),
        Item(Test: "62", image: "money", imgColor: .green),
        Item(Test: "63", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "64", image: "vacation", imgColor: .green),
        Item(Test: "65", image: "user", imgColor: .blue),
        
        Item(Test: "66", image: "home", imgColor: .orange),
        Item(Test: "67", image: "money", imgColor: .green),
        Item(Test: "68", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "69", image: "vacation", imgColor: .green),
        Item(Test: "70", image: "user", imgColor: .blue),
        
        Item(Test: "71", image: "home", imgColor: .orange),
        Item(Test: "72", image: "money", imgColor: .green),
        Item(Test: "73", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "74", image: "vacation", imgColor: .green),
        Item(Test: "75", image: "user", imgColor: .blue),
        
        Item(Test: "76", image: "home", imgColor: .orange),
        Item(Test: "77", image: "money", imgColor: .green),
        Item(Test: "78", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "79", image: "vacation", imgColor: .green),
        Item(Test: "80", image: "user", imgColor: .blue),
        
        Item(Test: "81", image: "home", imgColor: .orange),
        Item(Test: "82", image: "money", imgColor: .green),
        Item(Test: "83", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "84", image: "vacation", imgColor: .green),
        Item(Test: "85", image: "user", imgColor: .blue),
        
        Item(Test: "86", image: "home", imgColor: .orange),
        Item(Test: "87", image: "money", imgColor: .green),
        Item(Test: "88", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "89", image: "vacation", imgColor: .green),
        Item(Test: "90", image: "user", imgColor: .blue),
        
        Item(Test: "91", image: "home", imgColor: .orange),
        Item(Test: "92", image: "money", imgColor: .green),
        Item(Test: "93", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "94", image: "vacation", imgColor: .green),
        Item(Test: "95", image: "user", imgColor: .blue),
        
        Item(Test: "96", image: "home", imgColor: .orange),
        Item(Test: "97", image: "money", imgColor: .green),
        Item(Test: "98", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "99", image: "vacation", imgColor: .green),
        Item(Test: "100", image: "user", imgColor: .blue),
        
        Item(Test: "100", image: "home", imgColor: .orange),
        Item(Test: "102", image: "money", imgColor: .green),
        Item(Test: "103", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "104", image: "vacation", imgColor: .green),
        Item(Test: "105", image: "user", imgColor: .blue),
        
        Item(Test: "106", image: "home", imgColor: .orange),
        Item(Test: "107", image: "money", imgColor: .green),
        Item(Test: "108", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "109", image: "vacation", imgColor: .green),
        Item(Test: "110", image: "user", imgColor: .blue),
        
        Item(Test: "111", image: "home", imgColor: .orange),
        Item(Test: "112", image: "money", imgColor: .green),
        Item(Test: "113", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "114", image: "vacation", imgColor: .green),
        Item(Test: "115", image: "user", imgColor: .blue),
        
        Item(Test: "116", image: "home", imgColor: .orange),
        Item(Test: "117", image: "money", imgColor: .green),
        Item(Test: "118", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "119", image: "vacation", imgColor: .green),
        Item(Test: "120", image: "user", imgColor: .blue),
        
        Item(Test: "121", image: "home", imgColor: .orange),
        Item(Test: "122", image: "money", imgColor: .green),
        Item(Test: "123", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "124", image: "vacation", imgColor: .green),
        Item(Test: "125", image: "user", imgColor: .blue),
        
        Item(Test: "126", image: "home", imgColor: .orange),
        Item(Test: "127", image: "money", imgColor: .green),
        Item(Test: "128", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "129", image: "vacation", imgColor: .green),
        Item(Test: "130", image: "user", imgColor: .blue),
        
        Item(Test: "131", image: "home", imgColor: .orange),
        Item(Test: "132", image: "money", imgColor: .green),
        Item(Test: "133", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "134", image: "vacation", imgColor: .green),
        Item(Test: "135", image: "user", imgColor: .blue),
        
        Item(Test: "136", image: "home", imgColor: .orange),
        Item(Test: "137", image: "money", imgColor: .green),
        Item(Test: "138", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "139", image: "vacation", imgColor: .green),
        Item(Test: "140", image: "user", imgColor: .blue),
        
        Item(Test: "141", image: "home", imgColor: .orange),
        Item(Test: "142", image: "money", imgColor: .green),
        Item(Test: "143", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "144", image: "vacation", imgColor: .green),
        Item(Test: "145", image: "user", imgColor: .blue),
        
        Item(Test: "146", image: "home", imgColor: .orange),
        Item(Test: "147", image: "money", imgColor: .green),
        Item(Test: "148", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "149", image: "vacation", imgColor: .green),
        Item(Test: "150", image: "user", imgColor: .blue),
        
        Item(Test: "151", image: "home", imgColor: .orange),
        Item(Test: "152", image: "money", imgColor: .green),
        Item(Test: "153", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "154", image: "vacation", imgColor: .green),
        Item(Test: "155", image: "user", imgColor: .blue),
        
        Item(Test: "156", image: "home", imgColor: .orange),
        Item(Test: "157", image: "money", imgColor: .green),
        Item(Test: "158", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "159", image: "vacation", imgColor: .green),
        Item(Test: "160", image: "user", imgColor: .blue),
        
        Item(Test: "161", image: "home", imgColor: .orange),
        Item(Test: "162", image: "money", imgColor: .green),
        Item(Test: "163", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "164", image: "vacation", imgColor: .green),
        Item(Test: "165", image: "user", imgColor: .blue),
        
        Item(Test: "166", image: "home", imgColor: .orange),
        Item(Test: "167", image: "money", imgColor: .green),
        Item(Test: "168", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "169", image: "vacation", imgColor: .green),
        Item(Test: "70", image: "user", imgColor: .blue),
        
        Item(Test: "171", image: "home", imgColor: .orange),
        Item(Test: "172", image: "money", imgColor: .green),
        Item(Test: "173", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "174", image: "vacation", imgColor: .green),
        Item(Test: "175", image: "user", imgColor: .blue),
        
        Item(Test: "176", image: "home", imgColor: .orange),
        Item(Test: "177", image: "money", imgColor: .green),
        Item(Test: "178", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(Test: "179", image: "vacation", imgColor: .green),
        Item(Test: "180", image: "user", imgColor: .blue),
    ]
    
    
    let spacing: CGFloat = 10
    @State private var numberOfColumns = 5
    
    var body: some View {
        
        let colums = Array(
            repeating: GridItem(.flexible(),
              spacing: spacing),
                count: numberOfColumns)
        
        NavigationStack {
            ScrollView {
                
                headerView
                
                LazyVGrid(columns: colums, spacing: spacing) {
                    ForEach(items) { item in
                        Button(action: {
                            showingLoginScreen = true
                        }) {
                            ItemView(item: item)
                            
                        }
                        
                        .navigationDestination(
                            isPresented: $showingLoginScreen) {
                                CheckInTicket()
                            }
                        
    //                    .buttonStyle(PlainButtonStyle())
                        .buttonStyle(ItemButtonStyle(cornerRadius: 20))
                    }
                }
                .padding(.horizontal)
                .offset(y: -50)
            }
            .background(Color.white)
        .ignoresSafeArea()
        }
    }
    
    var headerView: some View {
        VStack {
            Image("avatar")
                .resizable()
                .frame(width: 110,height: 110)
                .clipShape(Circle())
                .overlay(Circle().stroke( Color.white,lineWidth: 4))
                .onTapGesture {
                    numberOfColumns = numberOfColumns % 3 + 1
                }
            
            Text("Modou")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .medium, design: .rounded))
            
            Text("Irgend ein Text")
                .foregroundColor(.white.opacity(0.7))
                .font(.system(size: 18, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
        }
        .frame(height: 350)
        .frame(maxWidth: .infinity)
        .background(Color.purple)
    }
}

struct ItemButtonStyle: ButtonStyle {
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            
            if configuration.isPressed {
                Color.black.opacity(0.2)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
        
    }
}

struct ItemView: View {
    
    let item: Item
    
    var body: some View {
        
        GeometryReader { reader in
            
            let fontSize = min(reader.size.width * 0.2, 28)
            let imageWidth: CGFloat = min(50, reader.size.width * 0.6)
            
            
            VStack(spacing: 5) {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(item.imgColor)
                    .frame(width: imageWidth)
                
                
                Text(item.Test)
                    .font(.system(size: fontSize,weight: .bold, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.9))
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(Color.white)
        }
        .frame(height: 80)
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
        
    }
    
}

struct TestGrid_Previews: PreviewProvider {
    static var previews: some View {
        TestGrid()
    }
}
