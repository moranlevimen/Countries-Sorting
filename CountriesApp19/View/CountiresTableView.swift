//
//  CountiresTableView.swift
//  CountriesApp19
//
//  Created by Neria Jerafi on 24/06/2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//
protocol CountryDelegate {
    func selectedCountry(country: Country)
    func showAlert() 
}

import UIKit

class CountiresTableView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var table: UITableView!
    var alphCode:String?
    var countriesId:[String] = []
    var globalCoutries:[String:Country] = [:];
    var globalAlpha3Coodes:[String] = [];
    var countyTableDelege:CountryDelegate?
    
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
        self.table.estimatedRowHeight = 10
        let nib = UINib(nibName: "CountyCell", bundle: nil)
        self.table.register(nib, forCellReuseIdentifier: "CountyCell")
        self.table.tableFooterView = UIView()
    }
    
    func selectedCountryCell(coutry:Country) {
        if coutry.borders!.isEmpty {
            // show no border alert
            self.countyTableDelege?.showAlert()
        }
        else if alphCode == nil{
            // show country VC
            self.countyTableDelege?.selectedCountry(country: coutry)
        }
        else {
            self.countriesId = coutry.borders!
            self.countyTableDelege?.selectedCountry(country: coutry)
            self.table.reloadData()
        }
    }
    
    
}
extension CountiresTableView:UITableViewDelegate,UITableViewDataSource{
    
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
