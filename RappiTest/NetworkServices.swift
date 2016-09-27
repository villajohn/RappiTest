//
//  NetworkServices.swift
//  RappiTest
//
//  Created by Jhon Villalobos on 9/25/16.
//  Copyright © 2016 Jhon Villalobos. All rights reserved.
//

import Foundation

class NetworkServices
{
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    let url: NSURL
    
    init(url: NSURL) {
        self.url = url
    }
    
    typealias ImageDataHandler = ((NSData) -> Void)
    
    func downloadImage(completion: @escaping ImageDataHandler)
    {
        let request = NSURLRequest(url: self.url as URL)
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch (httpResponse.statusCode) {
                    case 200:
                        if let data = data {
                            completion(data as NSData)
                        }
                    default:
                        print(httpResponse.statusCode)
                    }
                }
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
        
        dataTask.resume()
    }
}

extension NetworkServices
{
    static func parseJSONFromData(jsonData: NSData?) -> [String : AnyObject]?
    {
        if let data = jsonData {
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]
                return jsonDictionary
                
            } catch let error as NSError {
                print("error processing json data: \(error.localizedDescription)")
            }
        }
        
        return nil
    }
}
