//
//  CatGIFAppTests.swift
//  CatGIFAppTests
//
//  Created by kane buckthorpe on 21/11/2022.
//

import XCTest
@testable import CatGIFApp

final class CatGIFAppTests: XCTestCase {
    
    func test_TheCatAPIURLBuilder() {
        let builder = TheCatAPIURLBuilder.self
        let url = builder.build(size: .thumb, limit: 2, page: 1)
        XCTAssertEqual(url.absoluteString, "https://api.thecatapi.com/v1/images/search?size=thumb&mime_types=gif&limit=2&page=1&order=ASC")
    }

    func test_PaginationGIFListViewModel_pagination() async {
        let viewModel = PaginationGIFListViewModel(service: MockGIFListService())
        var itemsAsyncIterator = viewModel.$items.values.makeAsyncIterator()
        var items = await itemsAsyncIterator.next()!
        viewModel.loadData()
        items = await itemsAsyncIterator.next()!
        XCTAssertEqual(items.count, 1)
        XCTAssertEqual(items[0].id, "\(0)")
        
        for n in 1...50 {
            viewModel.loadMore()
            items = await itemsAsyncIterator.next()!
            XCTAssertEqual(items.count, n+1)
            XCTAssertEqual(items[n].id, "\(n)")
        }
    }
    
    func test_PaginationGIFListViewModel_error() async {
        let viewModel = PaginationGIFListViewModel(service: MockErrorGIFListService())
        var errorAsyncIterator = viewModel.$error.values.makeAsyncIterator()
        var error = await errorAsyncIterator.next()
        XCTAssertNil(error!)
        viewModel.loadData()
        error = await errorAsyncIterator.next()
        XCTAssertNotNil(error!)
    }
    
    func test_GifListCategoryFilter() async {
        let hatCat = CatAPIModel(categories: [.init(name: "hat")], id: "0", url: .dummy)
        let happyCat = CatAPIModel(categories: [.init(name: "happy")], id: "1", url: .dummy)
        let funnyCat = CatAPIModel(categories: [.init(name: "funny")], id: "1", url: .dummy)

        let filter = GifListCategoryFilter(["hat", "happy"])
        
        let filteredHat = filter.filter(cat: hatCat)
        XCTAssertFalse(filteredHat)
        let filteredHappy = filter.filter(cat: happyCat)
        XCTAssertFalse(filteredHappy)
        let filteredFunny = filter.filter(cat: funnyCat)
        XCTAssertTrue(filteredFunny)
    }
}

struct MockGIFListService: GIFPaginationListService {
    func fetchGIFs(for page: Int) async throws -> [GIFCardItem] {
        return [GIFCardItem(url: .dummy, id: "\(page)")]
    }
}

struct MockErrorGIFListService: GIFPaginationListService {
    enum MockError: Error {
        case error
    }
    func fetchGIFs(for page: Int) async throws -> [GIFCardItem] {
        throw MockError.error
    }
}

extension URL {
    fileprivate static var dummy: URL { URL(string: "https://www.google.com")! }
}
