//
//  GiphyListViewController.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import UIKit
import Combine

class GiphyListViewController: UIViewController {

    
    @IBOutlet weak var giphyCollectionView: UICollectionView!
    
    var listViewModel: GiphyListViewModel!
    private var cancellables: [AnyCancellable] = []

    private let appear = PassthroughSubject<Void, Never>()
    var giphyList: [GiphyScreenModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setCollectionViewFlowLayout()
        setupViewModel()
        setNotoficationOberserver()
        title = "Giphy"
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
    
    /// Method to set view model
    private func setupViewModel() {
        listViewModel = GiphyListViewModel()
        fetchGiphyList()
    }
    
    private func fetchGiphyList() {
        bind(to: listViewModel)
        appear.send(())
    }
    
    private func bind(to viewModel: GiphyListViewModelType) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        let input = GiphyListViewModelInput(appear: appear.eraseToAnyPublisher().eraseToAnyPublisher(),
                                            requestParameter: ["api_key": APIConstants.API_KEY,
                                                               "limit": 10,
                                                               "offset": giphyList.count])
        
        let output = viewModel.transform(input: input)
        
        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
    private func render(_ state: GiphyListState) {
        switch state {
        case .loading:
            if self.giphyList.count == 0 {
                self.giphyCollectionView.setActivityIndicator(show: true)
                self.giphyList = []
            }
        case .failure:
            self.giphyList = []
        case .success(var giphyList):
            self.giphyCollectionView.setActivityIndicator(show: false)
            if let favourteGiphyList = FavouriteGiphyEntity.fetchFavourteGiphy() {
                let favIds = favourteGiphyList.map({$0.id})
                for (index, giphy) in giphyList.enumerated() {
                    giphyList[index].isFavourteGiphy = favIds.contains(giphy.id)
                }
            }
            self.giphyList.append(contentsOf: giphyList)
            self.giphyCollectionView.reloadData()
        }
    }
    
    /// Method to add notificaiton Observer
    func setNotoficationOberserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshGiphyList), name: Notification.Name("refreshGiphyList"), object: nil)
    }
    
    /// Method to update giphy lsit
    /// - Parameter notification: Denotes Notification
    @objc func refreshGiphyList(notification: Notification) {
        
        guard let userInfo = notification.userInfo, let giphyId = userInfo["id"] as? String else {
            return
        }
        for (index, giphy) in giphyList.enumerated() {
            if giphy.id == giphyId  {
                giphyList.remove(at: index)
                giphyCollectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
            }
        }
    }
}

//MARK: UICollectionViewDataSource
extension GiphyListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        giphyList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GiphyCollectionViewCell", for: indexPath) as! GiphyCollectionViewCell
        cell.bind(to: giphyList[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row == (giphyList.count - 1) else { return }
        fetchGiphyList()
    }
    
}

extension GiphyListViewController: GiphyCollectionViewCellDelegate {
    
    
    /// Method to update like/dislike
    /// - Parameter cell: Denotes GiphyCollectionViewCell
    func actionOnLikeButton(cell: GiphyCollectionViewCell) {
        guard let indexPath = giphyCollectionView.indexPath(for: cell) else { return }
        
        if giphyList[indexPath.row].isFavourteGiphy {
            FavouriteGiphyEntity.removeFromFavourteList(giphy: giphyList[indexPath.row])
        } else {
            giphyList[indexPath.row].storeIntoFavourteTable()
        }
        giphyList[indexPath.row].isFavourteGiphy.toggle()
        giphyCollectionView.reloadItems(at: [indexPath])
    }
}
