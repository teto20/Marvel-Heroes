//
//  HeroesListController.swift
//  MarvelHeroes
//
//  Created by Mobile on 20/8/18.
//  Copyright © 2018 Mobile. All rights reserved.
//

import UIKit
import SDWebImage

enum DisplayMode {
    case grid, list
}

class HeroesListController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!

    fileprivate var displayMode: DisplayMode = .grid
    fileprivate var heroes: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        
        displayMode = .list
        fetchAndLoadHeroes()
    }
    
    @IBAction func changeLayout() {
        displayMode = (displayMode == .grid) ? .list : .grid
        collectionView.reloadData()
    }
    
    //MARK: Private methods
    
    private func registerCells() {
        self.collectionView.register(RectangleHeroCollectionCell.nib, forCellWithReuseIdentifier: RectangleHeroCollectionCell.identifier)
        self.collectionView.register(SquareHeroCollectionCell.nib, forCellWithReuseIdentifier: SquareHeroCollectionCell.identifier)
    }
    
    private func fetchAndLoadHeroes() {
        loader.startAnimating()
        HeroesManager.fetchHeroesData { heroes in
            DispatchQueue.main.async {
                self.heroes = heroes
                self.collectionView.reloadData()
                self.loader.stopAnimating()
                self.loader.isHidden = true
            }
        }
    }
    
}

extension HeroesListController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let destinationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeroDetail") as? DetailViewController else {
            return
        }
        
        let selectedHero = heroes[indexPath.row]
        collectionView.deselectItem(at: indexPath, animated: true)
        destinationController.selectedHero = selectedHero
        navigationController?.pushViewController(destinationController, animated: true)
    }
    
}

extension HeroesListController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let selectedHero = heroes[indexPath.row]
        if displayMode == .grid {
            
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: SquareHeroCollectionCell.identifier, for: indexPath) as! SquareHeroCollectionCell
            cell.update(withHero: selectedHero)
            return cell
        } else {
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: RectangleHeroCollectionCell.identifier, for: indexPath) as! RectangleHeroCollectionCell
            cell.nameLabel.text = selectedHero.name
            if let image = selectedHero.image {
                cell.loader.startAnimating()
                cell.loader.isHidden = false
                cell.imageView.sd_setImage(with: URL(string: image)) { (_, _, _, _) in
                    cell.loader.stopAnimating()
                    cell.loader.isHidden =  true
                }
            }
            return cell
        }
    }

    
}

extension HeroesListController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if displayMode == .grid {
            let itemSize = UIScreen.main.bounds.width/2
            return CGSize(width: itemSize, height: itemSize)
        } else {
            return CGSize(width: UIScreen.main.bounds.width, height: 80)
        }
    }
    
}

