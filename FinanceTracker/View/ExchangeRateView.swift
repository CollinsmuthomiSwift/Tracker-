//
//  ExchangeRateView.swift
//  FinanceTracker
//
//  Created by Collins Muthomi on 24/09/2025.
//

import SwiftUI

struct ExchangeRateView: View {
    @StateObject var myRates = ExchangeRatesViewModel()
    let myGrids = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var navigateToLanding: Bool = false
    @State private var showAlert = false
    
   
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.lightGray)
                    .opacity(0.1)
                    .ignoresSafeArea()

                
                VStack(alignment: .leading, spacing: 16)  {
                    HStack {
                        
                        Button {
                            navigateToLanding = true
                        }label: {
                            Image(systemName: "arrow.backward")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                        }
                        
                        NavigationLink(destination: CustomerLanding(), isActive: $navigateToLanding) {
                            
                        }
                        
                        Text("Exchange Rates")
                            .font(.title)
                            .foregroundStyle(.black)
                        
                        
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 15)
                    ScrollView {
                        LazyVGrid(columns: myGrids, spacing: 7) {
                            ForEach(myRates.pairs, id: \.pair){ pair in
                                GridItemView(icon: "dolla", title: "\(pair.pair ?? "")")
                                
                                
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                }
                if showAlert, let message = myRates.errorMessage {
                    ShowAlert(
                        title: "Error",
                        message: message,
                        buttonTitle: "OK",
                        onDismiss: {
                            showAlert = false
                            myRates.errorMessage = nil
                        }
                    )
                    .zIndex(1)
                }
            }
            
        }
        .onAppear {
            myRates.fetchRates()
        }
        .onReceive(myRates.$errorMessage){ error  in
            showAlert = error != nil
        }
                   
        
    }
}

#Preview {
    ExchangeRateView()
}

struct GridItemView: View {
    let icon: String
    let title: String
    
    var body: some View {
        ZStack {
            Color(.lightGray)
                .opacity(0.1)
                .ignoresSafeArea()

            VStack(spacing: 8) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.green)
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, minHeight: 100)
            .background(Color.blue)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
        }
    }
}
