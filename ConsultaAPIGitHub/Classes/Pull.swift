//
//  Pull.swift
//  ConsultaAPIGitHub
//
//  Created by Caio Araujo Mariano on 03/10/2018.
//  Copyright © 2018 Caio Araujo Mariano. All rights reserved.
//

import UIKit

class Pull {
    
    var _name: String?
    var _image: UIImage?
    var _autorName: String?
    var _title: String?
    var _date: String?
    var _body: String?
    var _URL: String?
    var _id: String?
    var _htmlURL: String?
    
    var pulls = [Pull]()
    
    // Name
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name!
    }
    
    // Image
    var image: UIImage {
        if _image == nil {
            _image = UIImage()
        }
        
        return _image!
    }
    
    // autorName
    var autorName: String {
        if _autorName == nil {
            _autorName = ""
        }
        
        return _autorName!
    }
    
    // title
    var title: String {
        if _title == nil {
            _title = ""
        }
        
        return _title!
    }
    
    // body
    var body: String {
        if _body == nil {
            _body = ""
        }
        
        return _body!
    }
    
    // htmlURL
    var htmlURL: String {
        if _htmlURL == nil {
            _htmlURL = ""
        }
        
        return _htmlURL!
    }
    
    // Date
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        return _date!
    }
    
    init() {}
    
    init(name : String, autorImage: UIImage, autorName: String) {
        
        self._autorName = autorName
        self._name = name
        self._image = autorImage
    }
    
    init(pullDicionario dict: Dictionary<String, AnyObject>) {
        
        if let repo = dict["repo"] as? Dictionary<String, AnyObject>{
            
            if let name = repo["name"] as? String {
                self._name = name
            }
        }
        //Title
        if let title = dict["title"] as? String{
            self._title = title
        }
        //Url
        if let url = dict["url"] as? String {
            self._URL = url
        }
        //htmlUrl
        if let htmlUrl = dict["html_url"] as? String {
            self._htmlURL = htmlUrl
        }
        //Id
        if let id = dict["id"] as? Int {
            self._id = String(id)
        }
        //body
        if let body = dict["body"] as? String {
            self._body = body
        }
        //Date
        if let date = dict["created_at"] as? String{
            
            self._date = date
        }
        // user--avatarImage
        if let user = dict["user"] as? Dictionary<String, AnyObject> {
            
            if let imageURL = user["avatar_url"] as? String {
                
                do {
                    let avatarImageData = try Data(contentsOf: URL(string: imageURL)!)
                    self._image = UIImage(data: avatarImageData)
                } catch {
                    self._image = UIImage()
                    
                }
            }
            //user--login
            if let UserName = user["login"] as? String {
                self._name = UserName
            }
        }
        
    } // Fechamento Init
    
    static func getPulls(pullArray array:[AnyObject]) -> [Pull]{
        
        var pulls = [Pull]()
        for item in array {
            if let dict = item as? Dictionary<String, AnyObject> {
                pulls.append(Pull(pullDicionario: dict))
            }
        }
        return pulls
        
    }
    
    
}// Fechamento da Classe

