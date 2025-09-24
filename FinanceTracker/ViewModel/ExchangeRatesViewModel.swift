//
//  ExchangeRatesViewModel.swift
//  FinanceTracker
//
//  Created by Collins Muthomi on 24/09/2025.
//

import Foundation
import Combine


class ExchangeRatesViewModel: ObservableObject {
   
    @Published var rateModel: ExchangeRatesModel?
    @Published var pairs: [CurrencyPair] = []
    @Published var errorMessage: String? = nil
    
    var cancellables = Set<AnyCancellable>()
    
    func fetchRates() {
        guard let url = URL(string: "https://collinm.free.beeceptor.com/transactions") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data,response) in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode <= 300 else {
                    throw URLError(URLError.badServerResponse)
                }
                return data
            }
            .decode(type: ExchangeRatesModel.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print(">>>>>>COMPLETION \(completion)")
                case .failure(let error):
                    print(">>>>>FAIL",error)
                    self.errorMessage = "Failed to load exchange rates"
                }
            } receiveValue: { [weak self]  returnedData in
                self?.rateModel = returnedData
                self?.pairs = returnedData.pairs ?? []
                
            }
            .store(in: &cancellables)
    }
}
