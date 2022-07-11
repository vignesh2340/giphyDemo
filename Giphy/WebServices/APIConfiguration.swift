//
//  APIConfiguration.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import Alamofire

public protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var urlString: String { get }
    var parameters: Parameters? { get }
    
    func asURLRequest() throws -> URLRequest
}

