//
//  APIManager.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import Foundation
import Combine
import Alamofire

//Final class to restrict inheritance of APIManager class
final class APIManager {
    
    static let manager = APIManager()
    
    //Private init method to block creating of APIManger instance outside of the class.
    private init(){}
    
    
    @discardableResult
    func fetchData<T: Decodable>(type model: T.Type, configuration: APIConfiguration, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Result<T, AFError>, Never> {
        return AF.request(configuration).publishDecodable(type: T.self, decoder: decoder).result()
    }
}
