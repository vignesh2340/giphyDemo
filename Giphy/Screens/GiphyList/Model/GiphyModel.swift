//
//  GiphyModel.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import Foundation
import CoreData

struct GiphyListResultModel: Decodable {
    var data: [GiphyScreenModel]?
    var pagination: Pagination?
}

struct GiphyScreenModel: Decodable {
    var type: String?
    var id: String?
    var url: String?
    var title: String?
    var images: GiphyData?
    var isFavourteGiphy: Bool = false
    
    init(){}
    
    enum CodingKeys: String, CodingKey {
        case type
        case id
        case url
        case title
        case images
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        images = try values.decodeIfPresent(GiphyData.self, forKey: .images)
    }
    
    func storeIntoFavourteTable() {
        let favouriteGiphyEntity = FavouriteGiphyEntity(context: AppDelegate.getAppDelegateObj().getManagedObjectContext())
        favouriteGiphyEntity.id = id
        favouriteGiphyEntity.url = url
        favouriteGiphyEntity.title = title
        favouriteGiphyEntity.imageUrl = images?.original?.url
        AppDelegate.getAppDelegateObj().saveContext()
    }
    
    static func getTestData() -> GiphyScreenModel {
        var model = GiphyScreenModel()
        model.title = "test"
        return model
    }
    
}

struct GiphyData: Decodable {
    var original: GiphyImage?
}

struct GiphyImage: Decodable {
    var url: String?
}

struct Pagination: Decodable {
    var totalCount: Int?
    var offSet: Int?
    var count: Int?
}

extension GiphyScreenModel: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
