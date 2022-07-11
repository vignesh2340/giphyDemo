//
//  FavouriteGiphyViewControllerTests.swift
//  GiphyTests
//
//  Created by Admin on 11/07/22.
//

import XCTest
@testable import Giphy

class FavouriteGiphyViewControllerTests: XCTestCase {

    var viewController: FavouriteGiphyViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Step 2. Instantiate UIViewController with Storyboard ID
        viewController = storyboard.instantiateViewController(withIdentifier: "FavouriteGiphyViewController") as? FavouriteGiphyViewController
        // Step 3. Make the viewDidLoad() execute.
        viewController.loadViewIfNeeded()
    }
    
    func testVariables() {
        XCTAssertNotNil(viewController.giphyList)
        XCTAssertNotNil(viewController.giphyList)
    }

    func testCollectionView() {

        viewController.giphyList = [GiphyScreenModel.getTestData()]
        XCTAssertEqual(viewController.collectionView(viewController.giphyCollectionView, numberOfItemsInSection: 0), 1)
        let cell = viewController.collectionView(viewController.giphyCollectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as? GiphyCollectionViewCell
        XCTAssertEqual(cell?.titleLabel.text, "test")
    }
    

}
