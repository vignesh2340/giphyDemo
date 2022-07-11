//
//  GiphyListViewModelBuilder.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import Foundation


struct GiphyListViewModelBuilder {
    static func viewModel(from movie: GiphyListResultModel) -> [GiphyScreenModel] {
        return movie.data ?? [GiphyScreenModel]()
    }
}
