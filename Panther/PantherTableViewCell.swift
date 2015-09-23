//
//  PantherTableViewCell.swift
//  Panther
//
//  Created by Mark Jackson on 9/21/15.
//  Copyright © 2015 Mark Jackson. All rights reserved.
//

import UIKit

class PantherIndexedCollectionView: UICollectionView {
    
    var indexPath: NSIndexPath!
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class PantherTableViewCell: UITableViewCell {
    
    var row : Int = 0
    
    @IBOutlet weak var collectionView: PantherIndexedCollectionView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var totalSpots: UILabel!
    
    // #pragma mark UICollectionViewDataSource
    
    func setCollectionViewDataSourceDelegate(dataSource : UICollectionViewDataSource, withDelegate delegate : UICollectionViewDelegate, atIndexPath indexPath : NSIndexPath){
        self.collectionView.dataSource = dataSource
        self.collectionView.delegate = delegate
        self.collectionView.indexPath = indexPath
        self.collectionView.reloadData()
    }
    
//    
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//    }
//    
//    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell : CircleDataCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! CircleDataCollectionViewCell
//        
//        return cell
//    }

}
