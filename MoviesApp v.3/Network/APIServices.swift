//
//  APIServices.swift
//  MoviesApp v.3
//
//  Created by VuTQ10 on 12/18/19.
//  Copyright © 2019 VuTQ10. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum APIName: String {
    case popular = "movie/popular"
    case configuration = "configuration"
    case none
    case top = "movie/top_rated"
    case credits = "movie/"
}

class APIService: NSObject {
    class func callAPI(withAPIName apiName: APIName? = .none,
                       movieId: Int? = nil,
                       method: HTTPMethod,
                       param: [String: Any] = [:],
                       success: @escaping (_ data: JSON) -> Void,
                       failure: @escaping (_ error: String) -> Void) {
        let baseURL = "https://api.themoviedb.org/3/"
        var urlStr = baseURL
        if let movieId = movieId {
            urlStr = urlStr + "movie/" + String(movieId) + "/credits"
        } else {
            urlStr += (apiName?.rawValue)!
        }
        let url = URL(string: urlStr)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        var params = [String: Any]()
        if method == .get {
            params = param
            params["api_key"] = "e7631ffcb8e766993e5ec0c1f4245f93"
        }
        if method == .get {
            urlRequest.url = NSURL.URL(withString: urlStr, queryString: APIService.queryString(withDictionary: params)) as URL?
        } else if method == .post {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: param, options: [])
        }
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, reponse, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "Reponse Error")
                return
            }
            guard let data = data else {
                failure("404")
                return
            }
            do {
                if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    DispatchQueue.main.async {
                        success(jsonData)
                    }
                }
            } catch {
                failure("404")
            }
        }
        dataTask.resume()
    }
    
    
    // MARK: Support for param
    class func queryString(withDictionary dictionary: [String: Any]) -> String {
        let arrayDic = dictionary.keys
        var keys = arrayDic.sorted()
        
        keys = keys.filter({ key -> Bool in
            let value = dictionary[key]
            if value is NSNull {
                return false
            }
            return !(value == nil)
        })
        return keys.map({ key -> String in
            let value = dictionary[key]
            return self.keyValueString(withKey: key, value: value)
        }).joined(separator: "&")
    }
    private class func keyValueString(withKey key: String, value: Any?) -> String {
        if let arrayValue = value as? [Any] {
            //例: foo=bar&foo=bar2
            return arrayValue.map { singleValue -> String in
                self.keyValueString(withKey: key, value: singleValue)
                }.joined(separator: "&")
        }
        
        var strValue = ""
        if let number = value as? NSNumber {
            strValue = number.stringValue
        } else if let str = value as? String {
            strValue = str
        }
        let keyAndValue = [key, (strValue as String) as String]
        return keyAndValue.joined(separator: "=")
    }
    
}
extension NSURL {
    class func URL(withString urlString: String, queryString: String) -> NSURL? {
        if queryString.isEmpty {
            return NSURL(string: urlString)
        } else {
            let strJoiner = urlString.range(of: "?") != nil ? "&" : "?"
            return NSURL(string: urlString + strJoiner + queryString)
        }
    }
}
