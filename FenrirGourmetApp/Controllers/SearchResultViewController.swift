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
        
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        cell.backgroundColor = .tertiarySystemGroupedBackground
        let restaurant = searchRestaurants[indexPath.section]
        
        // cellの内容
        content.text = restaurant.keywords
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 15)
        content.secondaryText = restaurant.access
        content.image = getImageByUrl(url: restaurant.mainLogo ?? "")
        content.textProperties.adjustsFontForContentSizeCategory = true
        content.imageToTextPadding = 10
        content.secondaryTextProperties.adjustsFontForContentSizeCategory = true
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchRestaurants.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x:0, y:0, width: tableView.bounds.width, height: 70))
        label.text = searchRestaurants[section].name
        label.adjustsFontForContentSizeCategory = true
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .systemTeal
        return label
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension SearchResultViewController {
    //画像を取得する
    private func getImageByUrl(url: String) -> UIImage {
        guard let url = URL(string: url) else {return UIImage()}
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
