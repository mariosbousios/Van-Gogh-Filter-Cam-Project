//
//  VanGoghFiltersManager.swift
//  VanGogh Cam
//
//  Created by Marios Bousios on 3/8/21.
//

import Foundation
import UIKit

class VanGoghFiltersManager {
    
    // Fills and returns the Van Gogh Filter Data
    public func getVanGoghFilters() -> [VanGoghFilter] {
        var vanGoghFilters = [VanGoghFilter]()
        
        let starryNightFilter = VanGoghFilter(painting: .starryNight,
                                    image: UIImage(named: Strings.VanGogh.StarryNight.imageName),
                                    name: Strings.VanGogh.StarryNight.name,
                                    info: Strings.VanGogh.StarryNight.info)
        
        let cafeTerraceFilter = VanGoghFilter(painting: .cafeTerrace,
                                              image: UIImage(named: Strings.VanGogh.CafeTerrace.imageName),
                                              name: Strings.VanGogh.CafeTerrace.name,
                                              info: Strings.VanGogh.CafeTerrace.info)
        
        let almondBlossomFilter = VanGoghFilter(painting: .almondBlossom,
                                                image: UIImage(named: Strings.VanGogh.AlmondBlossom.imageName),
                                                name: Strings.VanGogh.AlmondBlossom.name,
                                                info: Strings.VanGogh.AlmondBlossom.info)
        
        let potatoEatersFilter = VanGoghFilter(painting: .potatoEaters,
                                                image: UIImage(named: Strings.VanGogh.PotatoEaters.imageName),
                                                name: Strings.VanGogh.PotatoEaters.name,
                                                info: Strings.VanGogh.PotatoEaters.info)
        
        vanGoghFilters.append(contentsOf: [starryNightFilter, cafeTerraceFilter, almondBlossomFilter, potatoEatersFilter])
        
        return vanGoghFilters
    }
}
