//
//  RequestPlugin.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 3/8/23.
//

import Foundation
import Moya

final class RequestPlugin: PluginType {
    
    // MARK: - Prepare
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        return request
    }
    
    // MARK: - Process
    
    func process(_ result: Result<Response, MoyaError>, target: TargetType) -> Result<Response, MoyaError> {
        switch result {
        case let .success(response):
            do {
                let jsonData = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                let plainRequestData = try JSONSerialization.data(
                    withJSONObject: jsonData,
                    options: []
                )
                
                let plainResponse = Response(
                    statusCode: response.statusCode,
                    data: plainRequestData,
                    request: response.request,
                    response: response.response
                )
                return .success(plainResponse)
                
            } catch {}
            
        default: break
        }
        return result
    }
    
}
