//
//  GiphyTests.swift
//  GiphyTests
//
//  Created by Admin on 08/07/22.
//

import XCTest
@testable import Giphy

class GiphyListViewControllerTests: XCTestCase {

    var viewController: GiphyListViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // Step 2. Instantiate UIViewController with Storyboard ID
        viewController = storyboard.instantiateViewController(withIdentifier: "GiphyListViewController") as? GiphyListViewController
        // Step 3. Make the viewDidLoad() execute.
        viewController.loadViewIfNeeded()
    }
    
    func testVariables() {
        XCTAssertNotNil(viewController.giphyList)
        XCTAssertNotNil(viewController.listViewModel)
    }

    func testCollectionView() {
        XCTAssertEqual(viewController.collectionView(viewController.giphyCollectionView, numberOfItemsInSection: 0), 0)
        viewController.giphyList = [GiphyScreenModel.getTestData()]
        XCTAssertEqual(viewController.collectionView(viewController.giphyCollectionView, numberOfItemsInSection: 0), 1)
        let cell = viewController.collectionView(viewController.giphyCollectionView, cellForItemAt: IndexPath(row: 0, section: 0)) as? GiphyCollectionViewCell
        XCTAssertEqual(cell?.titleLabel.text, "test")
    }
    
}
