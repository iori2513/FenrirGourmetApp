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
    case noRestaurantError
    
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .error:
            return "もう一度お試しください"
        case .noRestaurantError:
            return "該当するレストランがありません"
        }
    }
}

class API {
    static let shared = API()
    
    func getRestaurantData(latitude: Double, longitude: Double, range: Int, completion: @escaping (Result<[Restaurant], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/?key=\(Constants.API_KEY)&lat=\(latitude)&lng=\(longitude)&range=\(range)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {return}
            do {
                let doc = try HTML(html: data, encoding: String.Encoding.utf8)
                guard (doc.xpath("//shop").count) != 0 else {
                    completion(.failure(APIError.noRestaurantError))
                    return
                    
                }
                
                let nodesArray = [doc.xpath("//shop/id"),
                                  doc.xpath("//shop/name"),
                                  doc.xpath("//shop/logo_image"),
                                  doc.xpath("//shop/budget/name"),
                                  doc.xpath("//shop/address"),
                                  doc.xpath("//shop/open"),
                                  doc.xpath("//shop/mobile_access"),
                                  doc.xpath("//shop/lat"),
                                  doc.xpath("//shop/lng"),
                                  doc.xpath("//shop/genre/catch")]
               
                var searchRestaurants = [Restaurant]()
                for n in 0...nodesArray[0].count - 1 {
                    let restaurant = Restaurant(id: nodesArray[0][n].text ?? "",
                                                name: nodesArray[1][n].text ?? "",
                                                mainLogo: nodesArray[2][n].text ?? "",
                                                budget: nodesArray[3][n].text ?? "",
                                                address: nodesArray[4][n].text ?? "",
                                                businessHour: nodesArray[5][n].text ?? "",
                                                access: nodesArray[6][n].text ?? "",
                                                latitude: atof(nodesArray[7][n].text),
                                                longitude: atof(nodesArray[8][n].text),
                                                keywords: nodesArray[9][n].text ?? "")
                    searchRestaurants.append(restaurant)
                }
                completion(.success(searchRestaurants))
                
            } catch {
                completion(.failure(APIError.error))
            }
        }
        task.resume()
    }
    
    func getImages(id: String?, completion: @escaping (Result<[String?], Error>) -> Void) {
        guard let id = id else {return}
        guard let url = URL(string: "\(Constants.baseURL)/?key=\(Constants.API_KEY)&id=\(id)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {return}
            do {
                let doc = try HTML(html: data, encoding: String.Encoding.utf8)
                guard (doc.xpath("//shop").count) != 0 else {
                    completion(.failure(APIError.noRestaurantError))
                    return
                    
                }
                let images: [String?] = [doc.xpath("//shop/photo/mobile/l").first?.text,
                                         "https://thumb.ac-illust.com/eb/ebe435f09324eb334280f879807e7842_w.jpeg",
                                         "https://thumb.ac-illust.com/eb/ebe435f09324eb334280f879807e7842_w.jpeg",
                                         "https://thumb.ac-illust.com/eb/ebe435f09324eb334280f879807e7842_w.jpeg"]
                completion(.success(images))
                
            } catch {
                completion(.failure(APIError.error))
            }
        }
        task.resume()
    }
    
                                              
}
