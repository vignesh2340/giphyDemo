//
//  GiphyCollectionViewCell.swift
//  Giphy
//
//  Created by Admin on 08/07/22.
//

import UIKit
import Kingfisher

protocol GiphyCollectionViewCellDelegate: AnyObject {
    func actionOnLikeButton(cell: GiphyCollectionViewCell)
}

class GiphyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var giphyImageView: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    weak var delegate: GiphyCollectionViewCellDelegate?
    
    /// Initial method to bind data
    /// - Parameter model: Denotes GiphyScreenModel
    func bind(to model: GiphyScreenModel) {
        loadGif(model: model)
        titleLabel.text = model.title
        mainView.setShadow()
        updateLikeButton(with: model)
    }
    
    /// Private method to load gif into image view
    /// - Parameter model: Denotes GiphyScreenModel
    private func loadGif(model: GiphyScreenModel) {
        let processor = DefaultImageProcessor()
        giphyImageView.kf.indicatorType = .activity
        if let urlString = model.images?.original?.url, let url = URL.init(string: urlString) {
            giphyImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholderImage"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ],
                completionHandler: nil)
        }
    }
    
    /// Method to update like button image
    /// - Parameter model: Denotes GiphyScreenModel
    private func updateLikeButton(with model: GiphyScreenModel) {
        likeBtn.setImage(UIImage(named: model.isFavourteGiphy ? ImageConstants.liked_icon : ImageConstants.like_icon ), for: .normal)
    }
    
    @IBAction func actionOnLikeButton(_ sender: Any) {
        delegate?.actionOnLikeButton(cell: self)
    }
    
}
