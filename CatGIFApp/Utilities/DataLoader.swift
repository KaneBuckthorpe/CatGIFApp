//
//  DataLoader.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import Foundation

struct DataLoader {
    let session: URLSession
    let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    func model<Value: Codable>(for request: URLRequest, asType: Value.Type) async throws -> Value {
        let (data, _) = try await URLSession.shared.data(for: request)
        return try decoder.decode(Value.self, from: data)
    }
}
