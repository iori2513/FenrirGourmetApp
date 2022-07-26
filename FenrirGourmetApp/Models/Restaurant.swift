//
//  Restaurant.swift
//  FenrirGourmetApp
//
//  Created by 中田伊織 on 2022/07/23.
//

import Foundation

struct Restaurant {
    let id: String?
    let name: String?
    let mainLogo: String?
    let budget: String?
    let address: String?
    let businessHour: String?
    let access: String?
    let latitude: Double
    let longitude: Double
    
    init(id: String, name: String, mainLogo: String, budget: String, address: String, businessHour: String, access: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.mainLogo = mainLogo
        self.budget = budget
        self.address = address
        self.businessHour = businessHour
        self.access = access
        self.latitude = latitude
        self.longitude = longitude
    }
    
    
}
