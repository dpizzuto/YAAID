//
//  UIImageViewExtension.swift
//
//  Created by Dario Pizzuto on 01/05/17.
//  Copyright © 2017 CesarePozzo. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setImage(withUrl url : String, filename : String){
        let urlSession  = URLSession(configuration: .default)
        let request = URLRequest(url: URL(string: url)!)
        print(request)
        if let img = FastCache.sharedInstance.retrieve(key: filename) as? UIImage{
            DispatchQueue.main.async {
                self.image = img
            }
        }
        else{
            DispatchQueue.global(qos: .background).async { [weak self] () -> Void in
                urlSession.dataTask(with: request) { (data, urlResponse, error) in
                    
                    if let response = urlResponse as? HTTPURLResponse{
                        
                        if response.statusCode == 404{
                            //Manage your error
                            print("404")
                        }
                        else if let respData = data{
                            print(respData)
                            UIView.transition(with: self!, duration: 0.2, options: .transitionCrossDissolve, animations: {
                                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                                let fileURL = documentsURL.appendingPathComponent(filename)
                                print(fileURL)
                                do{
                                    try respData.write(to: fileURL)
                                    DispatchQueue.main.async {
                                        FastCache.sharedInstance.put(object: UIImage(data: respData)!, forKey: filename)
                                        self?.image = UIImage(data: respData)
                                    }
                                }catch{
                                    //manage your error
                                    fatalError()
                                }
                            }, completion: nil)
                        }
                    }
                    }.resume()
            }
        }
    }
}
