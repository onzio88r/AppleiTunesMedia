//
//  HTTPRequestManager.swift
//  AppleiTunesMedia
//
//  Created by Daniele Rapali on 08/01/2020.
//  Copyright © 2020 Daniele Rapali. All rights reserved.
//

import Foundation

/// Create the URLRequest componene.
/// Default Method : GET
///
/// - Parameter url: url to call
/// - Returns: URLRequest
public func urlRequest(url: URL) -> URLRequest{
    
    /// Http request type
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    return request
}

func requestURLComponent() -> URLComponents {
    var component = URLComponents()
    component.scheme = "https"
    component.host = "rss.itunes.apple.com"
    component.path = "/api/v1/us/"
    
    return component
    
}


/// Main class for http requests
class HTTPRequest {
    
    func FeedList(mediaType: MediaType, completion: ((Result<HTTPMusicResponse,Error>) -> Void)?) {
        
        let session = URLSession.shared
        
        var urlComponent = requestURLComponent()
        urlComponent.path.append("\(mediaType.rawValue)/\(mediaType.feedType())")
        
        urlComponent.path.append("/all/10/explicit.json")
        
        guard let url = urlComponent.url else { fatalError("Could not create URL from components") }
        
        print(url)
        
        let request = urlRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.sync {
                if error != nil || data == nil {
                    print("Client error!")
                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Client error!"]) as Error
                    completion?(.failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    
                    guard let jsonData = data else {
                        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
                        completion?(.failure(error))
                        return
                    }
                    
                    let musicResults = try decoder.decode(HTTPMusicResponse.self, from: jsonData)
                                        
                    completion?(.success(musicResults))
                    
                    
                } catch {
                    print("JSON error: \(error)")
                }
                
            }
            
        }

        task.resume()

        
    }
    
}
