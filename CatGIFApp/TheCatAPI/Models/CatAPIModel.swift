//
//  CatAPIModel.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import Foundation

struct CatAPIModel: Codable {
    let categories: [Category]?
    let id: String
    let url: URL
    
    struct Category: Codable {
        let name: String
    }
}
