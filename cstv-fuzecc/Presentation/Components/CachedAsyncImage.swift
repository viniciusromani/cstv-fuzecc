//
//  CachedAsyncImage.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import SwiftUI

struct CachedAsyncImage<Content>: View where Content: View {
    private let url: URL?
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    init(
        url urlString: String?,
        scale: CGFloat = 1.0,
        transaction: Transaction = Transaction(),
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = URL(string: urlString ?? "")
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let url = self.url {
            if let cached = Cache[url] {
                content(.success(cached))
            } else {
                AsyncImage(
                    url: url,
                    scale: scale,
                    transaction: transaction
                ) { phase in cacheAndRender(phase: phase) }
            }
        } else {
            content(.failure(NSError(domain: "invalid url to cachedasyncimage", code: -1)))
        }
    }
    
    func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase, let url = self.url {
            Cache[url] = image
        }
        return content(phase)
    }
}

fileprivate class Cache {
    static private var stored: [URL: Image] = [:]
    
    static subscript(url: URL) -> Image? {
        get { Cache.stored[url] }
        set { Cache.stored[url] = newValue }
    }
}

#Preview {
    CachedAsyncImage(
        url: "https://developer.apple.com/news/images/og/swiftui-og.png"
    ) { phase in
        switch phase {
        case .empty: ProgressView()
        case .success(let image): image
        case .failure(let error): ProgressView()
        @unknown default: fatalError("unknown error on cached async image")
        }
    }
}
