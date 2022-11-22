//
//  CatGIFAppApp.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import SwiftUI

@main
struct CatGIFApp: App {
    let viewFactory = GIFListViewFactory.self
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                viewFactory.gifList()
                    .darkNavigationStyle(title: "Cat GIFs")
            }
        }
    }
}
