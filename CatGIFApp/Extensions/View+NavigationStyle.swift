//
//  View+NavigationStyle.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import SwiftUI

extension View {
    func darkNavigationStyle() -> some View {
        self
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(
                Color.indigo,
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
    
    func darkNavigationStyle(title: String) -> some View {
        self
            .darkNavigationStyle()
            .navigationTitle(title)
    }
}
