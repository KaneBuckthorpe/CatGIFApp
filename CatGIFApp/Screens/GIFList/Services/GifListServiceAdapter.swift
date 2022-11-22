//
//  GifListServiceAdapter.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import Foundation

struct GifListServiceAdapter: GIFPaginationListService {
    let service = TheCatAPIGIFService()
    
    func fetchGIFs(for page: Int) async throws -> [GIFCardItem] {
        try await service.fetchGIFs(page: page)
            .map { GIFCardItem(url: $0.url, id: $0.id) }
    }
}
