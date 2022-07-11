//
//  GiphyListViewModelType.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import Foundation
import Combine

typealias GiphyViewModelOuput = AnyPublisher<GiphyListState, Never>

protocol GiphyListViewModelType {
    func transform(input: GiphyListViewModelInput) -> GiphyViewModelOuput
}

struct GiphyListViewModelInput {
    let appear: AnyPublisher<Void, Never>
    var requestParameter: [String : Any]
}

// Output
enum GiphyListState {
    case loading
    case success([GiphyScreenModel])
    case failure(Error)
}

extension GiphyListState: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.success(let lhsMovies), .success(let rhsMovies)): return lhsMovies == rhsMovies
        case (.failure, .failure): return true
        default: return false
        }
    }
}
