//
//  ViewController.swift
//  CountriesApp19
//
//  Created by moran levi on 24/06/2019.
//  Copyright © 2019 MoranLeviLtd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var countriesTable: CountiresTableView!
    override func viewDidLoad() {
    super.viewDidLoad()
      getData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func getData(){
        DispatchQueue.global(qos: .background).async {
            ServerManager.getSharedInstance().getCountriesJson(completion: { (data) in
                if data != nil{
                    DispatchQueue.main.async {
                        self.countriesTable.countriesId =  Array(DataManager.getSharedInstance().getCountriesDict().keys)
                        self.countriesTable.table.reloadData()
                    }
                    
                }
            })
        }
    }

}

