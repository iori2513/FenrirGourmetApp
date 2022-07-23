//
//  Restaurant.swift
//  FenrirGourmetApp
//
//  Created by 中田伊織 on 2022/07/23.
//

import Foundation

struct Restaurant {
    let name: String?
    let logoImage: String?
    let budget: String?
    
    init(name: String, logoImage: String, budget: String) {
        self.name = name
        self.logoImage = logoImage
        self.budget = budget
    }
    
}
