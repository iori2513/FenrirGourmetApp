//
//  ViewController.swift
//  FenrirGourmetApp
//
//  Created by 中田伊織 on 2022/07/20.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var distancePicker: UIPickerView!
    @IBOutlet weak var button: UIButton!
    
    let locationManager = CLLocationManager()
    var userLocation: Location!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocationManager()
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        performSegue(withIdentifier: "searchResult", sender: self)
    }
    
    
    private func setLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() //ユーザーに現在地情報をアプリに共有するか尋ねる
        
        //許可されれば現在地を取得する
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        else {
            //アラート表示
        }
    }
    
    // 位置情報を取得した場合
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         guard let newLocation = locations.last else { return }

          let location:CLLocationCoordinate2D
                 = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
         userLocation = Location(latitude: location.latitude, longitude: location.longitude)
         print(userLocation.latitude, userLocation.longitude)
     }
    
    //位置情報取得に失敗した場合
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error.localizedDescription)")
    }


}

