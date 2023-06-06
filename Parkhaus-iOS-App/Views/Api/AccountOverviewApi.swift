//
//  AccountOverviewApi.swift
//  Parkhaus-iOS-App
//
//  Created by Julian Sommer on 04.06.23.
//

import Foundation

@MainActor
class AccountOverviewApi: AbstractApi {
    let openPaymentsUrl: String = "http://127.0.0.1:8080/payments/openPayments/"

    @Published var openPaymentCollection: PaymentModel.OpenPaymentCollection = PaymentModel.OpenPaymentCollection()
    @Published var wasSuccessful: Bool = false

    public func fetchOpenPayments(identifier: String) async {
        let headers: [String: String] = [:]

        let finishedUrl = self.openPaymentsUrl + identifier

        let responseData = await makeGetRequest(url: finishedUrl, headers: headers)

        if responseData == nil {
            return
        }

        do {
            let decodedResult = try JSONDecoder().decode(PaymentModel.OpenPaymentCollection.self, from: responseData ?? Data())
        
            openPaymentCollection = decodedResult
            wasSuccessful = true
        } catch {
            print("Invalid Response Data")

        }
    }
    
    public func payOpenPayment(identifier: String, paymentId: Int) async {
        let body: [String: Any] = [
            "paymentId": paymentId,
        ]
        
        let headers = [
            "Content-Type": "application/json",
        ]

        let finishedUrl = self.openPaymentsUrl + identifier

        let responseData = await makeRequest(url: finishedUrl, body:body, method: "POST", headers: headers)
    }
}
