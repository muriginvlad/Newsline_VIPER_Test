//
//  NetworkService.swift
//  Test App
//
//  Created by Vladislav on 15.03.2022.
//

import Foundation

protocol NetworkServiceProtocol: class {
    func getNewsApiData(completion: @escaping (NewsApiModel?, Error?) -> Void)
    func getMediaStackApiData(completion: @escaping (MediaStackModel?, Error?) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    private let decoder = JSONDecoder()
        
    func getNewsApiData(completion: @escaping (NewsApiModel?, Error?) -> Void) {
        let apiKey = "8d9390f81adc4e3b8c538aa8548e9625"
        let url = "https://newsapi.org/v2/top-headlines?country=ru&apiKey=" + apiKey
        if let URL = URL(string: url) {
            performRequest(URL: URL, completion: completion)
        }
    }
    
    func getMediaStackApiData(completion: @escaping (MediaStackModel?, Error?) -> Void) {
        let apiKey = "161a931e300ae12c2962fadae9cb74c0"
        let url = "http://api.mediastack.com/v1/news?access_key=" + apiKey +  "&languages=ru&countries=ru"
        if let URL = URL(string: url) {
            performRequest(URL: URL, completion: completion)
        }
    }
    
    private func performRequest<T: Decodable>(URL: URL, completion: @escaping (T?, Error?) -> Void) {
        let sharedSession = URLSession.shared
        let dataTask = sharedSession.dataTask(with: URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print("Error to load: \(String(describing: error?.localizedDescription))")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            if let dataResponse = data {
                do {
                    
                    let newdata = try self.decoder.decode(T.self, from: dataResponse)
                    print("Data: \(newdata), error: \(String(describing: error))")
                    
                    DispatchQueue.main.async {
                        completion(newdata, nil)
                    }
                   
                    return
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                  
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                  
                }
            }
        })
        dataTask.resume()
    }
}
