//
//  GatewayClient.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import Foundation
import Alamofire

struct GatewayClient {
    
    let reportUrl = APIConfig.baseUrl + "/report"
    
    static let shared = GatewayClient()
    
    func report(sessionData: SessionData, transactionId: String, handler: @escaping (AFDataResponse<Any>) -> ()) {
        let headers = HTTPHeaders(["email": sessionData.email,
                                    "session_id": sessionData.sessionId,
                                    "transaction_id": transactionId])
        
        let semaphore = DispatchSemaphore(value: 1)
        var success = false
        DispatchQueue.global(qos: .background).async {
            for i in (0..<APIConfig.apiGatewayAttempts) {
                print("GATEWAY REPORT ATTEMPT NUMBER \(i)")
                do {
                    usleep(500000) // 0.5 seconds
                }
                semaphore.wait()
                if success {
                    semaphore.signal()
                    return
                }
            
                print("GATEWAY REPORT: MAKING REQUEST")
                AF.request(reportUrl, headers: headers).validate().responseJSON { response in
                    switch response.result {
                    case .success:
                        print("GATEWAY REPORT: SUCCESS!")
                        success = true
                        handler(response)
                    case .failure:
                        print("GATEWAY REPORT: NO JSON")
                    }
                    semaphore.signal()
                }
            }
        }
    }
}
