//
//  DetailViewController.swift
//  FenrirGourmetApp
//
//  Created by 中田伊織 on 2022/07/20.
//
/*
 店舗名称
 ・住所
 ・営業時間
 ・画像
 */

import UIKit

class DetailViewController: UIViewController {
    
    var searchResultVC: SearchResultViewController!
    var selectedRestaurant: Restaurant!
    
    private var titles: [String] = ["店舗名", "住所", "営業時間", "予算"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedRestaurant.id)
        
    }
    
    
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.textProperties.adjustsFontForContentSizeCategory = true
        content.textProperties.adjustsFontSizeToFitWidth = true
        switch indexPath.section {
        case 0:
            content.text = selectedRestaurant.name
            cell.contentConfiguration = content
            return cell
        case 1:
            content.text = selectedRestaurant.address
            cell.contentConfiguration = content
            return cell
        case 2:
            content.text = selectedRestaurant.businessHour
            cell.contentConfiguration = content
            return cell
        case 3:
            content.text = selectedRestaurant.budget
            cell.contentConfiguration = content
            return cell
        default:
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return 120
        default:
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    
}


