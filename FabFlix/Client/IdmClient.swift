//
//  IdmClient.swift
//  FabFlix
//
//  Created by Benson  on 3/14/21.
//

import Foundation
import Alamofire

enum IdmResult {
    case failure
    case success
}

final class IdmClient {
    
    private let loginUrl = APIConfig.idmUrl + "/login"
    private let registerUrl = APIConfig.idmUrl + "/register"
    
    func login(email: String, password: String, handler: @escaping (IdmResult, String?, String?) -> ()) {
        let body = [
            "email": email,
            "password": password
        ]
        
        AF.request(loginUrl, method: .post, parameters: body, encoding: JSONEncoding.default).response { response in
            guard let transactionId = response.response?.headers.value(for: "transaction_id") else {
                print("LOGIN: transaction id failure")
                return
            }
            
            // empty sessiondata
            GatewayClient.shared.report(sessionData: SessionData(email: "", sessionId: ""), transactionId: transactionId) { response in
                switch response.result {
                case .success:
                    guard let json = response.value as? [String: Any],
                          let resultCode = json["resultCode"] as? Int,
                          let message = json["message"] as? String
                    else {
                        print("LOGIN: json deserialization failure")
                        handler(.failure, nil, nil)
                        return
                    }
                    guard let sessionId = json["session_id"] as? String
                    else {
                        handler(.failure, message, nil)
                        return
                    }
                    let loginResult: IdmResult = resultCode == APIConfig.idmLoginResultCodeSuccess ? .success : .failure
                    handler(loginResult, message, sessionId)
                case .failure:
                    print("LOGIN: failure at stage gateway request")
                    handler(.failure, nil, nil)
                    return
                }
            }
        }
    }
    
    func register(email: String, password: String, handler: @escaping (IdmResult, String?) -> ()) {
        let body = [
            "email": email,
            "password": password
        ]
        
        AF.request(registerUrl, method: .post, parameters: body, encoding: JSONEncoding.default).response { response in
            guard let transactionId = response.response?.headers.value(for: "transaction_id") else {
                print("REGISTER: transaction id failure")
                return
            }
            
            // empty sessiondata
            GatewayClient.shared.report(sessionData: SessionData(email: "", sessionId: ""), transactionId: transactionId) { response in
                switch response.result {
                case .success:
                    guard let json = response.value as? [String: Any],
                          let resultCode = json["resultCode"] as? Int,
                          let message = json["message"] as? String
                    else {
                        print("REGISTER: failure")
                        handler(.failure, nil)
                        return
                    }
                    let registerResult: IdmResult = resultCode == APIConfig.idmRegisterResultCodeSuccess ? .success : .failure
                    handler(registerResult, message)
                case .failure:
                    print("REGISTER: failure at stage gateway request")
                    handler(.failure, nil)
                    return
                }
            }
        }
    }
}
