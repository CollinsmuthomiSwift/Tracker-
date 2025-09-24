//
//  CustomerLanding.swift
//  FinanceTracker
//
//  Created by Collins Muthomi on 24/09/2025.
//

import SwiftUI

struct CustomerLanding: View {
    @StateObject var transactionsVM = TransactionsViewModel()
    @State private var profileImage: Image? = nil
    @State var currentBalanceAmount: String = ""
    @State var userName: String = "Collins"
    @State var moneyInAmount: String = "4000"
    @State var moneyOutAmount: String = "34,000"
    @State var balanceOut: String = ""
    @State var balanceIn: String = ""
    @State private var showAlert = false
    @State private var navigatedToRates: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray).opacity(0.1).ignoresSafeArea()
                VStack(alignment: .leading, spacing: 16) {
                    
                    HStack {
                        Spacer()
                        HStack(spacing: 12) {
                            if let profileImage = profileImage {
                                profileImage
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                                    .shadow(radius: 4)
                            } else {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 40, height: 40)
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.gray)
                                    )
                            }
                            
                            Text("Good morning \(userName)")
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 15)
                        .padding(.top, 15)
                    }
                    
                    // Balance Card
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.green)
                        .frame(height: 160)
                        .overlay {
                            VStack(spacing: 8) {
                                Text("Current Balance")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                
                                Text("\(transactionsVM.currentBalance)")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(.white)
                                
                                Divider()
                                    .background(Color.white.opacity(0.6))
                                    .padding(.horizontal, 24)
                                
                                HStack {
                                    VStack(spacing: 4) {
                                        Text("Money In")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                        Text("\(transactionsVM.balanceIn)")
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    Rectangle()
                                        .frame(width: 1, height: 30)
                                        .foregroundColor(.white.opacity(0.6))
                                    
                                    VStack(spacing: 4) {
                                        Text("Money Out")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                        Text("\(transactionsVM.balanceOut)")
                                            .font(.subheadline)
                                            .bold()
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                .padding(.horizontal, 16)
                            }
                            .padding(.vertical, 12)
                        }
                        .padding(.horizontal, 15)
                    
                    
                    HStack {
                        Text("Recent Five Transactions")
                            .font(.subheadline)
                            .foregroundColor(.black).bold()
                        
                        Spacer()
                        Text("View all")
                            .padding(.trailing, 5)
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(transactionsVM.transactions.prefix(5), id: \.id) { transaction in
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(transaction.targetCurrency ?? "-")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        
                                        Text(transaction.date ?? "")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("\(transaction.rate ?? 0, specifier: "%.2f")")
                                        .foregroundColor(transaction.status == "Failed" ? .red : .green)
                                        .bold()
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 5)
                    }
                    Button {
                        navigatedToRates = true
                    } label: {
                        Text("Add Transaction")
                            .foregroundColor(.white)
                            .frame(height: 45)
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(12)
                            .padding(.horizontal)
                        
                    }
                    .padding(.bottom, 10)
                    
                    NavigationLink(destination: AddTransactionView(), isActive: $navigatedToRates) {
                        
                    }

                    
                    Spacer()
                }
                .onAppear {
                    transactionsVM.getTransactions()
                }
                .onReceive(transactionsVM.$errorMessage) { error in
                    showAlert = error != nil
                }
                
                if showAlert, let message = transactionsVM.errorMessage {
                    ShowAlert(
                        title: "Error",
                        message: message,
                        buttonTitle: "OK",
                        onDismiss: {
                            showAlert = false
                            transactionsVM.errorMessage = nil
                        }
                    )
                    .zIndex(1)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    CustomerLanding()
}

