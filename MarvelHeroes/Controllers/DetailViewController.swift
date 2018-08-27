//
//  DetailViewController.swift
//  MarvelHeroes
//
//  Created by Mobile on 20/8/18.
//  Copyright © 2018 Mobile. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var heroDescription: UILabel!
    
    var selectedHero: Hero!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title =  selectedHero.name
        heroDescription.text = selectedHero.heroDescription ?? "Sin descripcion"
        
        guard let image = selectedHero.image, let url = URL(string: image) else {
            return
        }
        
        imageView.sd_setImage(with: url, completed: nil)
        // Do any additional setup after loading the view.
    }
}
