//
//  GIFListCard.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import SwiftUI

struct GIFListCard: View {
    let url: URL

    var body: some View {
        GIFImage(url: url)
            .aspectRatio(16/9, contentMode: .fill)
            .cornerRadius(8)
    }
}

struct GIFListCard_Previews: PreviewProvider {
    static var previews: some View {
        GIFListCard(url: GIFPreviewData.gifURL)
    }
}
