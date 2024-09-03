//
//  Loadable.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import Foundation
import SwiftUI
import Combine

enum LoadingState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}

protocol Loadable: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}

struct AsyncContentView<Source: Loadable, LoadingView: View, Content: View>: View {
    @ObservedObject var source: Source
    var loading: () -> LoadingView
    var content: (Source.Output) -> Content
    
    init(source: Source,
         @ViewBuilder loadingView: @escaping () -> LoadingView = { ProgressView().controlSize(.extraLarge).tint(.white) },
         @ViewBuilder content: @escaping (Source.Output) -> Content
    ) {
        self.source = source
        self.loading = loadingView
        self.content = content
    }
    
    var body: some View {
        switch source.state {
        case .idle:
            Color.clear.onAppear(perform: source.load)
        case .loading:
            loading()
        case .failed(let error):
            let _ = print("error loading data \(error)")
        case .loaded(let output):
            content(output)
        }
    }
}
