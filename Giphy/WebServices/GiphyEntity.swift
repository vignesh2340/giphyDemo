//
//  GiphyEntity.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import Foundation
import CoreData

class FavouriteGiphyEntity: NSManagedObject {
    
    //MARK:- Fetch
    static func fetchFavourteGiphy() -> [GiphyScreenModel]? {
        let fetchRequest: NSFetchRequest<FavouriteGiphyEntity> = FavouriteGiphyEntity.fetchRequest()
        if let fetchedList = try? AppDelegate.getAppDelegateObj().getManagedObjectContext().fetch(fetchRequest), fetchedList.count > 0 {
            var giphyList = [GiphyScreenModel]()
            for giphy in fetchedList {
                var model = GiphyScreenModel()
                model.id = giphy.id
                model.url = giphy.url
                model.title = giphy.title
                model.isFavourteGiphy = true
                model.images = GiphyData(original: GiphyImage(url: giphy.imageUrl))
                giphyList.append(model)
            }
            return giphyList
        }
        return nil
    }
    
    
    static func removeFromFavourteList(giphy: GiphyScreenModel) {
        guard let giphyId = giphy.id else { return }
        let fetchRequest: NSFetchRequest<FavouriteGiphyEntity> = FavouriteGiphyEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id==%@", giphyId)
        if let objects = try? AppDelegate.getAppDelegateObj().getManagedObjectContext().fetch(fetchRequest) {
            for obj in objects {
                AppDelegate.getAppDelegateObj().getManagedObjectContext().delete(obj)
            }
            AppDelegate.getAppDelegateObj().saveContext()
        }
    }
    
    
}
