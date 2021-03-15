//
//  Config.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import Foundation
import Alamofire

class APIConfig {
    static let baseUrl = "http://localhost:12345/api/g"
    static let movieUrl = baseUrl + "/movies"
    static let idmUrl = baseUrl + "/idm"
    
    static let apiGatewayAttempts: Int = 20
    
    static let movieSearchResultCodeSuccess = 210
    static let movieGetResultCodeSuccess = 210
}
