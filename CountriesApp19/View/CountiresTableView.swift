//
//  CountiresTableView.swift
//  CountriesApp19
//
//  Created by moran levi on 24/06/2019.
//  Copyright © 2019 MoranLeviLtd. All rights reserved.
//
protocol CountryDelegate {
    func selectedCountry(country: Country)
}

import UIKit

class CountiresTableView: UIView,UITableViewDelegate,UITableViewDataSource {
   //code var myIndex = 0
    var globalCoutries:[String:Country] = [:];
    var globalAlpha3Coodes:[String] = [];

    var countyTableDelege:CountryDelegate?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countriesId.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountyCell") as! CountyCell
        
        cell.setLabels(county: DataManager.getSharedInstance().getSpesificCountry(countryId:self.countriesId[indexPath.row] )!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCountryCell(coutry: DataManager.getSharedInstance().getCountriesDict()[self.countriesId[indexPath.row]]!)
    }
    
    func selectedCountryCell(coutry:Country) {
        if coutry.borders!.isEmpty {
            // show no border alert
        }
        else if alphCode == nil{
            // show country VC
            self.countyTableDelege?.selectedCountry(country: coutry)
        }
        else {
            
        }
    }
 

    @IBOutlet var contentView: UIView!
    @IBOutlet var table: UITableView!
    var alphCode:String?
    var countriesId:[String] = []
    override init(frame: CGRect) {
        super.init(frame:frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
    Bundle.main.loadNibNamed("CountiresTableView", owner: self, options: nil)
        addSubview(self.contentView)
        self.contentView.frame = self.bounds
        self.table.dataSource = self
        self.table.delegate = self
        self.contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.table.rowHeight = UITableView.automaticDimension
        self.table.estimatedRowHeight = 120
        let nib = UINib(nibName: "CountyCell", bundle: nil)
        self.table.register(nib, forCellReuseIdentifier: "CountyCell")
        self.table.tableFooterView = UIView()
    }
    
 

}
