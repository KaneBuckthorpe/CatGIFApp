//
//  TheCatAPIGIFService.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import Foundation

struct TheCatAPIGIFService {
    let dataLoader: DataLoader
    
    init(dataLoader: DataLoader = DataLoader()) {
        self.dataLoader = dataLoader
    }
    
    func fetchGIFs(
        size: TheCatAPIURLBuilder.Size = .thumb,
        limit: Int = 25,
        page: Int
    ) async throws -> [CatAPIModel] {
        let url = TheCatAPIURLBuilder.build(size: size, limit: limit, page: page)
        let request = TheCatAPIRequestBuilder.build(url: url)
        return try await dataLoader.model(for: request, asType: [CatAPIModel].self)
    }
}
