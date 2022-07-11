//
//  GiphyListAPIConfiguration.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import Foundation
import Alamofire

public enum GiphyAPIConfiguration: APIConfiguration {
    
    case getGiphyList(params: [String: Any])
    
    public var method: HTTPMethod {
        switch self {
        case .getGiphyList:
            return .get
        }
    }
    
    public var parameters: Parameters? {
        switch self {
        case .getGiphyList(let params):
            return params
        }
    }
    
    // MARK: - UrlString
    public var urlString: String {
        switch self {
            
        case .getGiphyList:
            return APIConstants.BaseUrl + APIConstants.TrendingGiphy
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let urlWithPathValue = urlString
        var url = try urlWithPathValue.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let parameters = parameters {
            switch self {
            case .getGiphyList:
                var urlComponents = URLComponents(string: urlWithPathValue)!
                urlComponents.queryItems = []
                
                _ = parameters.map { (key, value) in
                    let item = URLQueryItem(name: key, value: "\(value)")
                    urlComponents.queryItems?.append(item)
                }
                
                url = urlComponents.url!
                print(url)
                urlRequest.url = url
            }
        }
        return urlRequest
    }
    
}
