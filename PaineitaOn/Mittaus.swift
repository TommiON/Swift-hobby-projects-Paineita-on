//
//  Mittaus.swift
//  Paineita on!
//
//  Created by Tommi Niittymies on 22.12.2018.
//  Copyright © 2018 Tommi Niittymies. All rights reserved.
//

import Foundation

struct Mittaus: Codable {
    let alapaine: Int
    let yläpaine: Int
    let aika: Date
    
    init(mitattuAlapaine: Int, mitattuYläpaine: Int) {
        alapaine = mitattuAlapaine
        yläpaine = mitattuYläpaine
        aika = Date()
    }
}
