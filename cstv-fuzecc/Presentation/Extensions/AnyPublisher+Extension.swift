//
//  AnyPublisher+Extension.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import Foundation
import Combine

/**
 this is used to convert combine api call to async/await
 it has been written to support pull-to-refresh on List
 */
extension AnyPublisher {
    func async() async throws -> Output {
        var cancellable: AnyCancellable?
        defer { cancellable?.cancel() }
        return try await withCheckedThrowingContinuation { continuation in
            cancellable = first()
                .sink { result in
                    switch result {
                    case .finished: break
                    case let .failure(error): continuation.resume(throwing: error)
                    }
                } receiveValue: { value in
                    continuation.resume(with: .success(value))
                }
        }
    }
}
