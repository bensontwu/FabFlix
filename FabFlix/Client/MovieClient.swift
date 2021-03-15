//
//  MovieClient.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import Foundation
import Alamofire

struct MovieClient {
    
    private let searchUrl = APIConfig.movieUrl + "/search"
    private let getUrl = APIConfig.movieUrl + "/get"
    
    func search(sessionData: SessionData, params: [String: Any], handler: @escaping ([[String: Any]]) -> ()) {
        let headers = HTTPHeaders(["email": sessionData.email,
                                   "session_id": sessionData.sessionId])
        
        AF.request(searchUrl, parameters: params, headers: headers).response { response in
            guard let transactionId = response.response?.headers.value(for: "transaction_id") else {
                print("MOVIE SEARCH: transaction id failure")
                return
            }
            
            GatewayClient.shared.report(sessionData: sessionData, transactionId: transactionId) { response in
                switch response.result {
                case .success:
                    guard let json = response.value as? [String: Any],
                          let resultCode = json["resultCode"] as? Int,
                          resultCode == APIConfig.movieSearchResultCodeSuccess,
                          let moviesJson = json["movies"] as? [[String: Any]]
                    else {
                        print("MOVIE SEARCH: json deserialization into movies failure")
                        return
                    }
                    print("MOVIE SEARCH: successfully deserialized json into movies")
                    handler(moviesJson)
                case .failure:
                    print("MOVIE SEARCH: failure at stage gateway request")
                    return
                }
            }
        }
    }
    
    func get(sessionData: SessionData, movieId: String, handler: @escaping ([String: Any]) -> ()) {
        let headers = HTTPHeaders(["email": sessionData.email,
                                  "session_id": sessionData.sessionId])
        
        AF.request("\(getUrl)/\(movieId)", headers: headers).response { response in
            guard let transactionId = response.response?.headers.value(for: "transaction_id") else {
                print("MOVIE SEARCH: transaction id failure")
                return
            }
            
            GatewayClient.shared.report(sessionData: sessionData, transactionId: transactionId) { response in
                switch response.result {
                case .success:
                    guard let json = response.value as? [String: Any],
                          let resultCode = json["resultCode"] as? Int,
                          resultCode == APIConfig.movieGetResultCodeSuccess,
                          let movieJson = json["movie"] as? [String: Any]
                    else {
                        print("MOVIE GET: json deserialization into movie failure")
                        return
                    }
                    print("MOVIE GET: successfully deserialized json into movie")
                    handler(movieJson)
                case .failure:
                    print("MOVIE GET: failure at stage gateway request")
                    return
                }
            }
        }
    }
}
