//
//  AddTransactionView.swift
//  FinanceTracker
//
//  Created by Collins Muthomi on 24/09/2025.
//

import SwiftUI

struct AddTransactionView: View {
    @State var expenceTapped: Bool = false
    @State var incomeTapped: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        
                    }label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 30, height: 10)
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    AddTransactionView()
}
