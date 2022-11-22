//
//  GIFPreviewData.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import Foundation

enum GIFPreviewData {
    static let gifURL = URL(string: "https://cdn2.thecatapi.com/images/4qm.gif")!
    static let gifItem = GIFCardItem(url: gifURL, id: UUID().uuidString)
}
