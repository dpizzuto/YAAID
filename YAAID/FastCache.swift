//
//  FastCache.swift
//
//  Created by Dario Pizzuto on 01/05/17.
//  Copyright © 2017 CesarePozzo. All rights reserved.
//

import UIKit

class FastCache: NSObject {
    static let sharedInstance = FastCache()
    private let cache = NSCache<AnyObject, AnyObject>()
    
    
    func put(object: AnyObject, forKey key: String){
        cache.setObject(object, forKey: key as NSString)
    }
    
    func retrieve(key: String) -> AnyObject? {
        
        if let obj = cache.object(forKey: key as NSString){
            return obj
        }
        
        return nil
    }
    
    func invalidate(){
        cache.removeAllObjects()
    }
    
    
    func putImage(fromUrl url: String, forKey key: String){
        
        let urlSession : URLSession = URLSession(configuration: .default)
        let request = URLRequest(url: URL(string: url)!)
        
        DispatchQueue.global(qos: .background).async { () -> Void in
            urlSession.dataTask(with: request) { (data, urlResponse, error) in
                
                if let respData = data {
                    self.cache.setObject(UIImage(data: respData)!, forKey: key as NSString)
                }
                }.resume()
        }
    }
}
