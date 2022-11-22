//
//  TheCatAPIRequestBuilder.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import Foundation

struct TheCatAPIRequestBuilder {
    private static let apiKeyHeader = "x-api-key"
    private static let apiKeyValue = "live_MFtx9dm0AmK1l9tc5hgmnyj1gw3UzUGK7W4NB3fogtjRhlfnSzddhhwDm6a8f0iY"
    
    static func build(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue(apiKeyValue, forHTTPHeaderField: apiKeyHeader)
        return request
    }
}
