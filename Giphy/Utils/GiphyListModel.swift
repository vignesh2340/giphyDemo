//
//  GiphyListModel.swift
//  Giphy
//
//  Created by Admin on 11/07/22.
//

import Combine

class GiphyListModel: ObservableObject {
    public  static let shared = GiphyListModel()
    public var publisher = PassthroughSubject<String, Never>()
}
