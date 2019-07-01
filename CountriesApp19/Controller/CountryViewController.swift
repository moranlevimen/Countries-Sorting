//
//  CountryViewController.swift
//  CountriesApp19
//
//  Created by Neria Jerafi on 24/06/2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    @IBOutlet var bordersTable:
    CountiresTableView!
    
    var selectedCountry: Country?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVC()
    }
    func initVC()  {
        self.title = self.selectedCountry?.name!
        self.bordersTable.alphCode = self.selectedCountry?.alpha3Code
        self.bordersTable.countriesId = (self.selectedCountry?.borders)!
        self.bordersTable.countyTableDelege = self
    }
}
extension CountryViewController: CountryDelegate{
    func selectedCountry(country: Country) {
        self.title = country.name!
    }
    
    func showAlert() {}
    
    
}

