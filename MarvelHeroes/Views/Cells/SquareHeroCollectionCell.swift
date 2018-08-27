//
//  SquareHeroCollectionCell.swift
//  MarvelHeroes
//
//  Created by Mobile on 21/8/18.
//  Copyright © 2018 Mobile. All rights reserved.
//

import UIKit
import SDWebImage

class SquareHeroCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    static let identifier = "SquareHeroCollectionCell"
    static let nib = UINib(nibName: "SquareHeroCollectionCell", bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(withHero hero: Hero) {
        if let image = hero.image {
            loader.startAnimating()
            loader.isHidden = false
            imageView.sd_setImage(with: URL(string: image)) { (_, _, _, _) in
                self.loader.stopAnimating()
                self.loader.isHidden =  true
            }
        }

        nameLabel.text = hero.name
    }
    
    

}
