//
//  GIFImage.swift
//  CatGIFApp
//
//  Created by kane buckthorpe on 22/11/2022.
//

import UIKit
import SwiftUI
import FLAnimatedImage

struct GIFImage: UIViewRepresentable {
    private var url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    private let imageView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
}

extension GIFImage {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        view.addSubview(activityIndicator)
        view.addSubview(imageView)
        
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        activityIndicator.startAnimating()
        Task.detached {
            guard let (data, _) = try? await URLSession.shared.data(from: url) else { return }
            let image = FLAnimatedImage(animatedGIFData: data)
            
            Task { @MainActor in
                activityIndicator.stopAnimating()
                imageView.animatedImage = image
            }
        }
    }
}
