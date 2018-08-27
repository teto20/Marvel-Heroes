//
//  RectangleHeroCollectionCell.swift
//  MarvelHeroes
//
//  Created by Mobile on 21/8/18.
//  Copyright © 2018 Mobile. All rights reserved.
//

import UIKit

class RectangleHeroCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    static let identifier = "RectangleHeroCollectionCell"
    static let nib = UINib(nibName: "RectangleHeroCollectionCell", bundle: nil)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
