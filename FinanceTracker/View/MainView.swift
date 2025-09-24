//
//  MainView.swift
//  FinanceTracker
//
//  Created by Collins Muthomi on 24/09/2025.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CustomerLanding()
                .tabItem {
                    Image(systemName: "house.fill")
                        .foregroundColor(.green)
                    Text("Home")
                }
            
            ExchangeRateView()
                .tabItem {
                    Image(systemName: "arrow.up.arrow.down")
                    Text("Exchange Rate")
                }
            
            AddTransactionView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("More")
                    
                }
        }
        
    }
}

#Preview {
    MainView()
}
