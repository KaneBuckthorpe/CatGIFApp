//
//  GIFListViewFactory.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import SwiftUI

enum GIFListViewFactory {
    static func gifList() -> some View {
        let service = GifListServiceAdapter()
        let viewModel = PaginationGIFListViewModel(service: service)
        return GIFList(viewModel: viewModel)
    }
}
