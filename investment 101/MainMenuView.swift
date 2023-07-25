//
//  MainMenuView.swift
//  investment 101
//
//  Created by Celine Tsai on 25/7/23.
//

import SwiftUI

struct MainMenuView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer()
                
                switch selectedTab {
                case 0:
                    ProfileView()
                case 1:
                    UnitsView()
                case 2:
                    StockView()
                default:
                    EmptyView()
                }
                
                Spacer()
                
                HStack {
                    TabBarButton(imageName: "house.fill", text: "Home", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    TabBarButton(imageName: "book.fill", text: "Courses", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    TabBarButton(imageName: "chart.line.uptrend.xyaxis", text: "Stock", isSelected: selectedTab == 2) {
                        selectedTab = 2
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.white.shadow(radius: 2))
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle(navigationTitleForTab(selectedTab))
        }
    }
    
    func navigationTitleForTab(_ tab: Int) -> String {
        switch tab {
        case 0:
            return "Home"
        case 1:
            return "Courses"
        case 2:
            return ""
        default:
            return ""
        }
    }
}


struct TabBarButton: View {
    let imageName: String
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                
                Text(text)
                    .font(.caption)
                    .foregroundColor(isSelected ? .blue : .gray)
            }
            .padding(.vertical, 6)
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
