//
//  ViewController.swift
//  CountriesApp19
//
//  Created by Neria Jerafi on 24/06/2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var countriesTable: CountiresTableView!
    var selectedCountry:Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData(){
        DispatchQueue.global(qos: .background).async {
            ServerManager.getSharedInstance().getCountriesJson(completion: { (data) in
                if data != nil{
                    
                    self.countriesTable.countriesId = data!.sorted(by: {$0.name! < $1.name!})
                    
                    
                    self.countriesTable.countyTableDelege = self
                    DispatchQueue.main.async {
                        self.countriesTable.table.reloadData()
                    }
                    
                }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CountryViewController
        vc.selectedCountry = self.selectedCountry
    }
}
extension ViewController:CountryDelegate{
    func showAlert() {
        let alert = UIAlertController(title: Constants.alertTitle, message: nil, preferredStyle: UIAlertController.Style.alert);
        alert.addAction(UIAlertAction(title: "close", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func selectedCountry(country: Country) {
        self.selectedCountry = country
        performSegue(withIdentifier: "countrySegue", sender: self)
    }
    
    
}

