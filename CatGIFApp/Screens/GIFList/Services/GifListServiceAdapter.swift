//
//  GifListServiceAdapter.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import Foundation

protocol CatFilter {
    func filter(cat: CatAPIModel) -> Bool
}

struct GifListServiceAdapter: GIFPaginationListService {
    let service = TheCatAPIGIFService()
    let filters: [CatFilter] = [GifListCategoryFilter(["hat"])]
    
    func fetchGIFs(for page: Int) async throws -> [GIFCardItem] {
        try await service.fetchGIFs(page: page)
            .filter { cat in
                filters.contains(where: { $0.filter(cat: cat) })
            }
            .map { GIFCardItem(url: $0.url, id: $0.id) }
    }
}

struct GifListCategoryFilter: CatFilter {
    let excluded: [String]
    
    init(_ excluded: [String]) {
        self.excluded = excluded
    }
    
    func filter(cat: CatAPIModel) -> Bool {
        !excluded.contains(where: { categoryName in
            cat.categories?.contains(where: { $0.name == categoryName }) ?? false
        })
    }
}
