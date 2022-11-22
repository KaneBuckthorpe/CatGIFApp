//
//  PaginationGIFListViewModel.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import Foundation

protocol GIFPaginationListService {
    func fetchGIFs(for page: Int) async throws -> [GIFCardItem]
}

class PaginationGIFListViewModel: GIFListViewModel {
    
    private let service: GIFPaginationListService
    private var page = 0
    private var loadingTask: Task<Void, Error>?
    
    @Published var items: [GIFCardItem] = []
    @Published var error: Error?
    
    init(service: GIFPaginationListService) {
        self.service = service
    }

    func loadData() {
        guard loadingTask == nil else { return }
        self.loadingTask = Task { @MainActor in
            do {
                self.items = try await service.fetchGIFs(for: page)
            } catch {
                self.error = error
            }
            self.loadingTask = nil
        }
    }
    
    func loadMore() {
        guard loadingTask == nil else { return }
        let newPage = page + 1
        self.loadingTask = Task { @MainActor in
            do {
                let newItems = try await service.fetchGIFs(for: newPage)
                self.items = items + newItems
                self.page = newPage
            } catch {
                self.error = error
            }
            self.loadingTask = nil
        }
    }
}
