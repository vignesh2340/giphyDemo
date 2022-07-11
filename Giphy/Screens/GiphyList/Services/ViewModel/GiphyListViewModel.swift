//
//  GiphyListViewModel.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import Foundation
import Combine

final class GiphyListViewModel: GiphyListViewModelType {
    private var cancellables: [AnyCancellable] = []
   
    func transform(input: GiphyListViewModelInput) -> GiphyViewModelOuput {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        
        let movieList = input.appear
            .flatMap({ _ in GiphyListService().getTrendingGiphyList(parameter: input.requestParameter)})
            .map ({ result -> GiphyListState in
                switch result {
                    
                case .success(let data):
                    print("List: \n",data.data)
                    return .success(self.viewModels(from: data))
                case .failure(let error):
                    print("Error: \n", error.localizedDescription)
                    return .failure(error)
                }
            }).eraseToAnyPublisher()
        let loading: GiphyViewModelOuput = input.appear.map({_ in .loading }).eraseToAnyPublisher()
        
        return Publishers.Merge(loading, movieList).removeDuplicates().eraseToAnyPublisher()
        
    }
    
    private func viewModels(from movie: GiphyListResultModel) -> [GiphyScreenModel] {
        return GiphyListViewModelBuilder.viewModel(from: movie)
    }
}
