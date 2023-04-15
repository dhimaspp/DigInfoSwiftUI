//
//  DigInfoApp.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 07/04/23.
//

import SwiftUI
import Factory

@main
struct DigInfoApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "Hoefler Text", size: 32)!]
    }
    var body: some Scene {
        WindowGroup {
            ContentView(homePresenter: HomePresenter())
        }
    }
}
