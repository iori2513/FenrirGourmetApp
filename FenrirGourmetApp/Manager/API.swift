//
//  API.swift
//  FenrirGourmetApp
//
//  Created by 中田伊織 on 2022/07/23.
//

import Foundation
import Kanna
struct Constants {
    static let API_KEY = "b794e8dfbd9686a1"
    static let baseURL = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1"
    
}

enum APIError: Error {
    case error
}

class API {
    static let shared = API()
    
    func getRestaurantData(latitude: Double, longitude: Double, range: Int, completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/?key=\(Constants.API_KEY)&lat=\(latitude)&lng=\(longitude)&range=\(range)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {return}
            do {
                let doc = try HTML(html: data, encoding: String.Encoding.utf8)
                guard (doc.xpath("//shop").count) != 0 else {print(1)
                    return}
                let nodesArray = [doc.xpath("//shop/name"),
                                  doc.xpath("//shop/logo_image"),
                                  doc.xpath("//shop/budget/name")]
               
                var searchRestaurants = [Restaurant]()
                for n in 0...nodesArray[0].count - 1 {
                    let restaurant = Restaurant(name: nodesArray[0][n].text ?? "",
                                                logoImage: nodesArray[1][n].text ?? "",
                                                budget: nodesArray[2][n].text ?? "")
                    searchRestaurants.append(restaurant)
                }
                completion(.success(searchRestaurants))
                
            } catch {
                completion(.failure(APIError.error))
            }
        }
        task.resume()
    }
                                              
}
