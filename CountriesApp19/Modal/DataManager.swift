//
//  DataManager.swift
//  CountriesApp19
//
//  Created by moran levi on 24/06/2019.
//  Copyright © 2019 MoranLeviLtd. All rights reserved.


import Foundation

class DataManager {
    
    private static var sharedInstance:DataManager?;//singltone
    private var countriesDict:[String:Country] = [:];
    
    private init(){
    }
    
    public static func getSharedInstance()->DataManager
    {
        if DataManager.sharedInstance == nil{
            DataManager.sharedInstance = DataManager();
        }
        return DataManager.sharedInstance!
    }
    
    func setCountries(countries:[Country]) {
        for country in countries {
            self.countriesDict[country.alpha3Code!] = country
            
        }
    }
    
    func getCountriesDict() -> [String:Country] {
        return self.countriesDict
    }
    
    
}
