//
//  ViewController.swift
//  FenrirGourmetApp
//
//  Created by 中田伊織 on 2022/07/20.
//

import UIKit
import CoreLocation
import PKHUD

class SearchViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var distancePicker: UIPickerView!
    @IBOutlet weak var button: UIButton!
    
    let locationManager = CLLocationManager()
    var userLocation: Location!
    var selectedDistanceIndex: Int = 0
    var indicator = UIActivityIndicatorView()
    
    let dataList = [300, 500, 1000, 2000, 3000]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if locationManager.authorizationStatus == .authorizedWhenInUse ||
            locationManager.authorizationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchResult"{
            let destination = segue.destination as! SearchResultViewController
            destination.searchVC = self
        }
        
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        performSegue(withIdentifier: "searchResult", sender: self)
    }
    
    // 位置情報を取得した場合
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         guard let newLocation = locations.last else { return }

          let location:CLLocationCoordinate2D
                 = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
         userLocation = Location(latitude: location.latitude, longitude: location.longitude)
         DispatchQueue.main.async {
             HUD.hide()
         }
         
     }
    
    //位置情報取得に失敗した場合
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            HUD.hide()
        }
        print("\(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
         let status = manager.authorizationStatus
         switch status {
           case .authorizedAlways, .authorizedWhenInUse:
             locationManager.desiredAccuracy = kCLLocationAccuracyBest
             DispatchQueue.main.async {
                 HUD.show(.progress)
             }
             locationManager.startUpdatingLocation()
           case .notDetermined, .denied, .restricted:
            return
            
           default:
            return
        }
    }
    
    
}






extension SearchViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
     
    // UIPickerViewの行数、要素の全数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
     
    // UIPickerViewに表示する配列
    internal func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return "\(dataList[row])"
    }
     
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        // 処理
        selectedDistanceIndex = row
        return
    }
    
}

