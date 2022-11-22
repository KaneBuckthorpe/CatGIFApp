//
//  GIFList.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import SwiftUI

protocol GIFListViewModel: ObservableObject {
    var items: [GIFCardItem] { get }
    var error: Error? { get }
    func loadData()
    func loadMore()
}

struct GIFList<ViewModel>: View where ViewModel: GIFListViewModel {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        if viewModel.error != nil {
            errorView()
        } else if !viewModel.items.isEmpty {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.items) { item in
                        GIFListCard(url: item.url)
                            .task {
                                loadMore(for: item, in: viewModel.items)
                            }
                        
                    }
                }
                .padding(16)
            }
        } else {
            loadingView().task{ viewModel.loadData() }
        }
    }
    
    private func loadMore(for item: GIFCardItem, in items: [GIFCardItem]) {
        let thresholdIndex = items.index(items.endIndex, offsetBy: -4)
        if items.lastIndex(of: item) == thresholdIndex {
            Task {
                viewModel.loadMore()
            }
        }
    }
    
    private func loadingView() -> some View {
        ProgressView()
    }
    
    @ViewBuilder
    private func errorView() -> some View {
        VStack(spacing: 16) {
            Text("Something went wrong.")
            Button {
                Task {
                    viewModel.loadData()
                }
            } label: {
                Text("Try again")
            }
        }
    }
}

struct GIFList_Previews: PreviewProvider {
    class ViewModel: GIFListViewModel {
        var items: [GIFCardItem] = [GIFPreviewData.gifItem]
        var error: Error?
        func loadData() {}
        func loadMore() {}
    }
    
    static var previews: some View {
        GIFList(viewModel: ViewModel())
    }
}
