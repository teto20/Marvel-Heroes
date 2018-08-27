//
//  Hero.swift
//  MarvelHeroes
//
//  Created by Mobile on 20/8/18.
//  Copyright © 2018 Mobile. All rights reserved.
//

import UIKit

struct Hero {

    var id: Int
    var name: String
    var heroDescription: String?
    var image: String?
    
    static func fromJSON(jsonData: [String: Any]) -> Hero? {
        
        guard let id = jsonData["id"] as? Int else {
            return nil
        }
        
        guard let name = jsonData["name"] as? String else {
            return nil
        }
        
        guard let heroDesription = jsonData["description"] as? String else {
            return nil
        }
        
        guard let thumbnail = jsonData["thumbnail"] as? [String: String] else {
            return nil
        }
        
        guard let path = thumbnail["path"], let ext = thumbnail["extension"] else {
            return nil
        }
        
        let image = "\(path).\(ext)"
        let hero = Hero(id: id, name: name, heroDescription: heroDesription, image: image)
        return hero
    }
    
}


