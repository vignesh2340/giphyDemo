//
//  FavouriteGiphyViewController.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import UIKit

class FavouriteGiphyViewController: UIViewController {
    
    @IBOutlet weak var giphyCollectionView: UICollectionView!
    
    var giphyList: [GiphyScreenModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setCollectionViewFlowLayout()
        fetchFavGiphy()
        title = "Favourtie Giphy"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavGiphy()
    }
    
    private func registerCell() {
        giphyCollectionView.register("GiphyCollectionViewCell")
    }
    
    /// Method to set collection view flow layout
    private func setCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (self.view.frame.width / 2) - 10 , height: (self.view.frame.width / 2) - 10 )
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        giphyCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func fetchFavGiphy() {
        giphyList = FavouriteGiphyEntity.fetchFavourteGiphy()
        giphyCollectionView.reloadData()
    }
    
}

extension FavouriteGiphyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        giphyList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let giphy = giphyList?[indexPath.row] else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GiphyCollectionViewCell", for: indexPath) as! GiphyCollectionViewCell
        cell.bind(to: giphy)
        cell.delegate = self
        return cell
    }
    
}


extension FavouriteGiphyViewController: GiphyCollectionViewCellDelegate {
    
    
    func actionOnLikeButton(cell: GiphyCollectionViewCell) {
        guard let indexPath = giphyCollectionView.indexPath(for: cell),
                let giphy = giphyList?[indexPath.row] else { return }
        
        FavouriteGiphyEntity.removeFromFavourteList(giphy: giphy)
        giphyList?.remove(at: indexPath.row)
        giphyCollectionView.deleteItems(at: [indexPath])
        
        NotificationCenter.default.post(name: Notification.Name("refreshGiphyList"), object: nil, userInfo: ["id": giphy.id ?? ""])
    }
}
