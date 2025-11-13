//
//  Untitled.swift
//  classProject
//
//  Created by Sebastian Bejaoui on 11/2/25.
//

import SwiftUI

struct MainView: View {
    
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                Home()
                    
            }
            .tabItem { Label("Home", systemImage: "creditcard") }
            .tag(0)
            
            // Tab 2: Overview
            NavigationStack {
                metrics()
            }
            .tabItem { Label("Report", systemImage: "chart.bar.fill") }
            .tag(1)
            
            
            NavigationStack {
                leaderboard()
                
            }
            .tabItem { Label("Leaderboard", systemImage: "person.circle.fill") }
            .tag(2)
            
            
            NavigationStack {
               setting()
                
            }
            .tabItem { Label("Setting", systemImage: "gearshape.fill") }
            .tag(3)
            
            
        }
    }
}





#Preview { MainView() }
