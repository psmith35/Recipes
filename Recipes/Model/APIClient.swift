//
//  APIClient.swift
//  Recipes
//
//  Created by Paul Smith on 12/14/24.
//

import Foundation

class APIClient {
    
    enum Endpoints {
        static let base = "https://d3jbb8n5wk0qxi.cloudfront.net/"
        
        case getRecipes
        case getMalformedData
        case getEmptyData
        
        var stringValue: String {
            switch self {
            case .getRecipes: return Endpoints.base + "recipes.json"
            case .getMalformedData: return Endpoints.base + "recipes-malformed.json"
            case .getEmptyData: return Endpoints.base + "recipes-empty.json"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getRecipes(url: URL, completion: @escaping ([Recipe]?, Error?) -> Void) {
        _ = taskForGETRequest(url: url, responseType: RecipeResults.self, completion: {
            (response, error) in
            if let response = response {
                completion(response.recipes, error)
            }
            else {
                completion([], error)
            }
        })
    }
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, removeSecurity: Bool = false , responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        let request = URLRequest(url: url)
        let task = taskForData(urlRequest: request, removeSecurity: removeSecurity, responseType: responseType, completion: completion)
        return task
    }
    
    @discardableResult class func taskForData<ResponseType: Decodable>(urlRequest: URLRequest, removeSecurity: Bool, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: urlRequest) {
            data, response, error in
            guard var data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            if(removeSecurity) {
                let range : Range = 5..<data.count
                data = data.subdata(in: range)
            }
            do {
                //print(String(data: data, encoding: .utf8)!)
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, error)
                }
            }
            catch {
                do {
                    let errorObject = try decoder.decode(ErrorResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, errorObject)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }
        
}
