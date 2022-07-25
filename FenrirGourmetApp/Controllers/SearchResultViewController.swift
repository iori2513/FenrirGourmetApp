//
//  SearchResultTableViewController.swift
//  FenrirGourmetApp
//
//  Created by 中田伊織 on 2022/07/20.
//

import UIKit

class SearchResultViewController: UITableViewController {
    
    var searchRestaurants = [Restaurant]()
    var selectedIndex: Int!
    var searchVC: SearchViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let location = searchVC.userLocation else {print(1)
            return}
        API.shared.getRestaurantData(latitude: location.latitude,
                                     longitude: location.longitude,
                                     range: searchVC.selectedDistanceIndex + 1)
        { [weak self] result in
            switch result {
            case .success(let searchRestaurants):
                self?.searchRestaurants = searchRestaurants
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                self?.alert(message: error.localizedDescription)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail"{
            let destination = segue.destination as! DetailViewController
            destination.selectedRestaurant = searchRestaurants[selectedIndex]
        }
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchRestaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let restaurant = searchRestaurants[indexPath.row]
        
        // cellの内容
        content.text = restaurant.name
        content.secondaryText = restaurant.budget
        content.image = getImageByUrl(url: restaurant.mainLogo ?? "")
        content.textProperties.adjustsFontForContentSizeCategory = true
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.secondaryTextProperties.adjustsFontForContentSizeCategory = true
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    
}

extension SearchResultViewController {
    //画像を取得する
    public func getImageByUrl(url: String) -> UIImage {
        guard let url = URL(string: url) else {return UIImage(systemName: "camera.metering.none") ?? UIImage()}
        do {
            let data = try Data(contentsOf: url)
            guard let image = UIImage(data: data) else {return UIImage()}
            return image
        } catch let error {
            print(error.localizedDescription)
        }
        return UIImage()
    }
    
    //アラート表示
    private func alert(message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(button)
        present(alert, animated: true, completion: nil)
    }

}
