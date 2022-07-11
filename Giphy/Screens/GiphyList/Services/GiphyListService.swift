//
//  GiphyListService.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import Foundation
import Alamofire
import Combine

protocol APIGiphyListScreenProtocol {
    func getTrendingGiphyList(parameter: [String: Any]) -> AnyPublisher<Result<GiphyListResultModel, AFError>, Never>
    
}
struct GiphyListService: APIGiphyListScreenProtocol {
  
    func getTrendingGiphyList(parameter: [String: Any]) -> AnyPublisher<Result<GiphyListResultModel, AFError>, Never> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let configuration = GiphyAPIConfiguration.getGiphyList(params: parameter)
        return APIManager.manager.fetchData(type: GiphyListResultModel.self, configuration: configuration, decoder: jsonDecoder)
    }
}
