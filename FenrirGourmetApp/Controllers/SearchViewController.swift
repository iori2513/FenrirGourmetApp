//
//  ViewController.swift
//  FenrirGourmetApp
//
//  Created by 中田伊織 on 2022/07/20.
//

import UIKit

class SearchViewController: UIViewController {

    
    @IBOutlet weak var distancePicker: UIPickerView!
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        performSegue(withIdentifier: "searchResult", sender: self)
    }
    


}

