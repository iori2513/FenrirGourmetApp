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
import MapKit

class DetailViewController: UIViewController {
    
    var searchResultVC: SearchResultViewController!
    var selectedRestaurant: Restaurant!
    
    @IBOutlet weak var tableView: UITableView!
    private var titles: [String] = ["店舗名", "住所", "営業時間", "予算", "写真", "アクセス"]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.register(MapTableViewCell.self, forCellReuseIdentifier: MapTableViewCell.identifier)
        
        
        
    }
    
    
    
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.textProperties.adjustsFontForContentSizeCategory = true
        content.textProperties.adjustsFontSizeToFitWidth = true
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            content.text = selectedRestaurant.name
            cell.contentConfiguration = content
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            content.text = selectedRestaurant.address
            cell.contentConfiguration = content
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            content.text = selectedRestaurant.businessHour
            cell.contentConfiguration = content
        case 3:
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            content.text = selectedRestaurant.budget
            cell.contentConfiguration = content
        case 4:
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else {return cell}
            guard let id = selectedRestaurant.id else {return cell}
            imageCell.getData(id: id)
            return imageCell
            
        case 5:
            switch indexPath.row {
            case 0:
                cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                content.text = selectedRestaurant.access
                cell.contentConfiguration = content
            case 1:
                guard let mapCell = tableView.dequeueReusableCell(withIdentifier: MapTableViewCell.identifier, for: indexPath) as? MapTableViewCell else {return cell}
                mapCell.setupMap(latitude: selectedRestaurant.latitude, longitude: selectedRestaurant.longitude)
                return mapCell
            default:
                return cell
            }
        default:
            return cell
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 5:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return 150
        case 4:
            return 200
        case 5:
            switch indexPath.row {
            case 1:
                return 400
            default:
                return 70
            }
        default:
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    
    
}


