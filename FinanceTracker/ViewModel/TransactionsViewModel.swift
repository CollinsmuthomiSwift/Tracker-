//
//  TrackerViewModel.swift
//  FinanceTracker
//
//  Created by Collins Muthomi on 24/09/2025.
//

import Foundation
import Combine

class TransactionsViewModel: ObservableObject {
    @Published var transactions: [TransactionsModel] = []
    @Published var balanceIn: Double = 0
    @Published var balanceOut: Double = 0
    @Published var currentBalance: Double = 0
    @Published var errorMessage: String? = nil
    
    
    var cancellables = Set<AnyCancellable>()
    
    func getTransactions() {
        guard let url = URL(string: "https://collinm.free.beeceptor.com/transactions") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data,response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
                    throw URLError(URLError.badServerResponse)
                   
                }
                return data
            }
            .decode(type: [TransactionsModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print(">>>>>>COMPLETION \(completion)")
                case .failure(let error):
                    print(">>>>>FAIL",error)
                    self.errorMessage = "Failed to load recent transactions. Please try again later"
                }
            } receiveValue: { [weak self] returnedData in
                self?.transactions = returnedData
                self?.calculateMyBalance()
            }
            .store(in: &cancellables)

    }
    
    private func calculateMyBalance() {
           balanceIn = transactions
               .filter { $0.status == "Success" }
               .compactMap { $0.rate }
               .reduce(0, +)
           
           balanceOut = transactions
               .filter { $0.status == "Failed" }
               .compactMap { $0.rate }
               .reduce(0, +)
           
           currentBalance = balanceIn - balanceOut
       }
    
    
}


