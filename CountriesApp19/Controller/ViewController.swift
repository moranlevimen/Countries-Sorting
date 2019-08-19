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
    var isCheckedAb = true
    var isSize = false
    
    @IBOutlet var sortBySIzeOutlet: UIView!
    @IBOutlet weak var sortAreaOutlet: UIButton!
    @IBAction func sortBySize(_ sender: Any) {
        isSize = !isSize
        if isSize{
            (sender as AnyObject).setTitle("Low->high", for: .normal)
            (sender as AnyObject).setTitleColor(.green, for: .normal)
            print("sort by size desending")
            self.countriesTable.countriesId = self.countriesTable.countriesId.sorted {Float($0.area ?? 0) < Float($1.area ?? 0)}

            print(self.countriesTable.countriesId)
            self.countriesTable.table.reloadData()
           
        }else{
            (sender as AnyObject).setTitle("higt->low", for: .normal)
            (sender as AnyObject).setTitleColor(.red, for: .normal)
            print("sort by size asending")
            self.countriesTable.countriesId = self.countriesTable.countriesId.sorted {Float($0.area ?? 0) > Float($1.area ?? 0)}
            
            self.countriesTable.table.reloadData()
       }
 
      //  }
    }
    
    @IBAction func soryByName(_ sender: Any) {
        isCheckedAb = !isCheckedAb
        if isCheckedAb{
            (sender as AnyObject).setTitle("A-Z", for: .normal)
            (sender as AnyObject).setTitleColor(.green, for: .normal)

            print("sort by name desending")
            self.countriesTable.countriesId = self.countriesTable.countriesId.sorted(by: {$0.name! < $1.name!})
            self.countriesTable.table.reloadData()
            
        }else{
            (sender as AnyObject).setTitle("Z-A", for: .normal)
            (sender as AnyObject).setTitleColor(.red, for: .normal)
            print("sort by name asending")
            self.countriesTable.countriesId = self.countriesTable.countriesId.sorted(by: {$0.name! > $1.name!})
            self.countriesTable.table.reloadData()
        }
        
    }
    
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

