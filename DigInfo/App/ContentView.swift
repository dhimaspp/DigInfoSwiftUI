//
//  ContentView.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 07/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var homePresenter: HomePresenter
    @State private var selectedTab = 0
    @State private var isNavBarHidden = false
    
    var scrollViewDelegate: ScrollViewDelegate {
            ScrollViewDelegate(isNavBarHidden: self.$isNavBarHidden)
        }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationStack {
                switch selectedTab {
                case 0:
                    HomeView(presenter: homePresenter)
                case 1:
                    SavedNewsView(presenter: homePresenter)
                case 2:
                    ProfileView()
                default:
                    HomeView(presenter: homePresenter)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(isNavBarHidden)
            
            HStack {
                TabButton(imageName: "house", text: "Home", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                TabButton(imageName: "bookmark", text: "Saved News", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }.padding(.horizontal, 20)
                TabButton(imageName: "person", text: "Profile", isSelected: selectedTab == 2) {
                    selectedTab = 2
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: -5)
            .opacity(isNavBarHidden ? 0 : 1)
            .animation(.easeInOut(duration: 0.2))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        ContentView(homePresenter: HomePresenter())
    }
}
