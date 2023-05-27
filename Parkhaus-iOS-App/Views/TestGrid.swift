//
//  TestGrid.swift
//  Parkhaus-iOS-App
//
//  Created by Modou on 27.05.23.
//

import SwiftUI

struct Item: Identifiable {
    
    let id = UUID()
    let title: String
    let image: String
    let imgColor: Color
}


struct TestGrid: View {
 
    let items = [
        Item(title: "Home", image: "home", imgColor: .orange),
        Item(title: "Money", image: "money", imgColor: .green),
        Item(title: "Bank", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(title: "Vacation", image: "vacation", imgColor: .green),
        Item(title: "User", image: "user", imgColor: .blue),
        Item(title: "Charts", image: "charts", imgColor: .orange),
        Item(title: "Support", image: "support", imgColor: .purple),
    ]
    
    
    let spacing: CGFloat = 10
    @State private var numberOfColumns = 3
    
    var body: some View {
        
        let colums = Array(
            repeating: GridItem(.flexible(),
              spacing: spacing),
                count: numberOfColumns)
        
        ScrollView {
            
            headerView
            
            LazyVGrid(columns: colums, spacing: spacing) {
                ForEach(items) { item in
                    Button(action:  {}) {
                        ItemView(item: item)
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
                
                
                Text(item.title)
                    .font(.system(size: fontSize,weight: .bold, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.9))
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(Color.white)
        }
        .frame(height: 150)
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
        
    }
    
}

struct TestGrid_Previews: PreviewProvider {
    static var previews: some View {
        TestGrid()
    }
}
