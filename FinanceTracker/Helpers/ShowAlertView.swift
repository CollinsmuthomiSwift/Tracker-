//
//  ShowAlertView.swift
//  FinanceTracker
//
//  Created by Collins Muthomi on 24/09/2025.
//

import Foundation


struct CustomAlertView: View {
    let title: String
    let message: String
    let buttonTitle: String
    var onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.4) // Dim background
                .ignoresSafeArea()
                .onTapGesture { onDismiss() }

            VStack(spacing: 16) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Button(action: onDismiss) {
                    Text(buttonTitle)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.black)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color(.systemGray6).opacity(0.95))
            .cornerRadius(16)
            .padding(.horizontal, 40)
            .shadow(radius: 8)
        }
        .transition(.opacity.combined(with: .scale)) // smooth animation
        .animation(.easeInOut, value: UUID())
    }
}

