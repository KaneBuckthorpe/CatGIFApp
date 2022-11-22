//
//  TheCatAPIURLBuilder.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import Foundation

enum TheCatAPIURLBuilder {
    enum Size: String {
        case full
        case med
        case small
        case thumb
    }
    
    static func build(size: Size, limit: Int, page: Int) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.thecatapi.com"
        components.path = "/v1/images/search"
        let sizeQuery = URLQueryItem(name: "size", value: size.rawValue)
        let mimeTypeQuery = URLQueryItem(name: "mime_types", value: "gif")
        let limitQuery = URLQueryItem(name: "limit", value: "\(limit)")
        let pageQuery = URLQueryItem(name: "page", value: "\(page)")
        let orderQuery = URLQueryItem(name: "order", value: "ASC")
        components.queryItems = [sizeQuery, mimeTypeQuery, limitQuery, pageQuery, orderQuery]
        return components.url!
    }
}
