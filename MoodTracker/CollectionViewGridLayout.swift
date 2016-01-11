//
//  CollectionViewGridLayout.swift
//  MoodTracker
//
//  Created by Seyithan Teymur on 11/01/16.
//  Copyright © 2016 Brokoli. All rights reserved.
//

import UIKit

class CollectionViewGridLayout: UICollectionViewFlowLayout {
    var aspectRatio: CGFloat = 1
    var numberOfColumns: Int = 3
    
    override func prepareLayout() {
        if let collectionView = self.collectionView {
            /*  Get the size of the collection view and fit the items into it to make them
            *  appear as _pages_.
            */
            let viewSize = collectionView.bounds.size
            resetItemSizeWithViewSize(viewSize)
        }
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        resetItemSizeWithViewSize(newBounds.size)
        return self.collectionView!.bounds != newBounds
    }
    
    private func resetItemSizeWithViewSize(viewSize: CGSize) {
        let marginTotal = self.minimumInteritemSpacing * CGFloat(self.numberOfColumns - 1)
        let rowWidth = viewSize.width - marginTotal
        
        let width = rowWidth / CGFloat(numberOfColumns)
        let height = width * aspectRatio
        
        self.itemSize = CGSize(width: width, height: height)
    }
}
