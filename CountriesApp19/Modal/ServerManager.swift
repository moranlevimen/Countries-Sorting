//
//  ServerManager.swift
//  Flicks2019
//
//  Created by Neria Jerafi on 24/06/2019.
//  Copyright © 2019 Neria Jerafi. All rights reserved.
//



import Foundation

class ServerManager {
    
    private static var sharedInstance:ServerManager?;
    private init(){
    }
    public static func getSharedInstance()->ServerManager
    {
        if ServerManager.sharedInstance == nil{
            ServerManager.sharedInstance = ServerManager();
        }
        return ServerManager.sharedInstance!
    }
    
    func getCountriesJson(completion:@escaping ([String:Country]?)->())  {
        guard let url = URL(string: "https://restcountries.eu/rest/v2/all") else{return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if data == nil{
                completion(nil);
            }
            else{
                do{
                    let countriesJson = try JSONDecoder().decode([Country].self,from: data!);
                    DataManager.getSharedInstance().setCountries(countries: countriesJson)
                    completion(DataManager.getSharedInstance().getCountriesDict())
                }
                catch{
                    completion(nil)
                }
            }
            }.resume()
    }
}
