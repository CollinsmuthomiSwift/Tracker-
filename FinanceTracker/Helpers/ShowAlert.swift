//
//  ShowAlert.swift
//  FinanceTracker
//
//  Created by Collins Muthomi on 24/09/2025.
//

import SwiftUI

//struct ShowAlert_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomAlertView(
//            title: "Error",
//            message: "Failed to load data. Please try again.",
//            buttonTitle: "OK",
//            onDismiss: { }
//        )
//        .background(Color.black.opacity(0.4)) // Optional: see the dim background
//        .previewLayout(.sizeThatFits)
//    }
//}

struct ShowAlert: View {
    let title: String
    let message: String
    let buttonTitle: String
    var onDismiss: () -> Void
    var body: some View {
        ZStack {
           // Color.black.opacity(0.4) // Dim background
                //.ignoresSafeArea()
                //.onTapGesture { onDismiss() }

            VStack(spacing: 16) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.center)

                Button(action: onDismiss) {
                    Text(buttonTitle)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .padding(.horizontal, 40)
            .shadow(radius: 8)
        }
        .transition(.opacity.combined(with: .scale)) // smooth animation
        .animation(.easeInOut, value: UUID())
    }
}

#Preview {
    ShowAlert(title: "Error", message: "Failed to load transactions. Please try again.", buttonTitle: "Ok", onDismiss: { })
}






