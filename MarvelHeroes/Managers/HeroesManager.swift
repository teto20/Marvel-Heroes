//
//  HeroesManager.swift
//  MarvelHeroes
//
//  Created by Mobile on 20/8/18.
//  Copyright © 2018 Mobile. All rights reserved.
//

import UIKit


class HeroesManager {
    
    static func fetchHeroesData(completion: @escaping ([Hero]) -> ()) {
        
        var heroes: [Hero] = []
        
        _ = URLSession.shared.dataTask(with: Constants.API.heroesListURL) { (datos, respuesta, error) in
            
            guard error == nil else {
                completion([])
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]

                guard let jsonData = json["data"] as? [String: Any] else {
                    return
                }
                guard let results = jsonData["results"] as? [[String: Any]] else {
                    return
                }
                
                for result in results {
                    guard let hero = Hero.fromJSON(jsonData: result) else {
                        continue
                    }
                    heroes.append(hero)
                }
                completion(heroes)
                
            } catch {
                completion([])
            }
            
        }.resume()

    }
    
}
