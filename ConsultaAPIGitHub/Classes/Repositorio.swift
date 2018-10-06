//
//  Repositorio.swift
//  ConsultaAPIGitHub
//
//  Created by Caio Araujo Mariano on 03/10/2018.
//  Copyright © 2018 Caio Araujo Mariano. All rights reserved.
//

import UIKit
import Alamofire

class Repository {
    
    var _name: String? //
    var _userAvatar: UIImage? //
    var _userLoginName: String? //
    var _userRealName: String? //
    var _description: String? //
    var _quantityOfForks: Int? //
    var _quantityOfStargazers: Int? //
    var _htmlUrl: String? //
    var _userAvatarUrl: URL?//
    
    
    //MARK: Verificacoes
    
    //Name
    var name : String {
        if _name == nil {
            _name = ""
            
        }
        return _name!
    }
    
    // UserAvatar
    var userAvatar : UIImage {
        if _userAvatarUrl == nil {
            _userAvatar = UIImage()
            
        }
        return _userAvatar!
        
    }
    
    // UserLoginName
    var userLoginName : String {
        if _userLoginName == nil {
            _userLoginName = ""
            
        }
        return _userLoginName!
        
    }
    
    // UserRealName
    var userRealName : String {
        if _userRealName == nil {
            _userRealName = ""
            
        }
        return _userRealName!
        
    }
    
    // Description
    var description : String {
        if _description == nil {
            _description = ""
            
        }
        return _description!
        
    }
    
    // quantityOfForks
    var quantityOfForks : Int {
        if _quantityOfForks == nil {
            _quantityOfForks = 0
            
        }
        return _quantityOfForks!
        
    }
    
    // quantityOfStargazers
    var quantityOfStargazers : Int {
        if  _quantityOfStargazers == nil {
            _quantityOfStargazers = 0
            
        }
        return _quantityOfStargazers!
        
    }
    
    // htmlUrl
    var htmlUrl : String {
        if _htmlUrl == nil{
            _htmlUrl = ""
            
        }
        return _htmlUrl!
        
    }
    
    init() {}
    
    init(respositorioDicionario item : Dictionary < String, AnyObject>) {
       
        if let name = item["name"] as? String {
            self._name = name
        }
        
        if let fullName = item["full_name"] as? String {
            self._userRealName = fullName
        }
        
        if let description = item["description"] as? String {
            self._description = description
        }
        if let forks = item["forks"] as? Int {
            self._quantityOfForks = forks
        }
        if let stars = item["stargazers_count"] as? Int {
            self._quantityOfStargazers = stars
        }
        if let htmlURL = item["html_url"] as? String {
            self._htmlUrl = htmlURL
        }
        if let ownerData = item["owner"] as? Dictionary<String, AnyObject> {
            if let loginName = ownerData["login"] as? String {
                self._userLoginName = loginName
            }
            if let avatarUrl = ownerData["avatar_url"] as? String {
                if let url = URL(string: avatarUrl) {
                    self._userAvatarUrl = url
                    
                    do {
                        let avatarImageData = try Data(contentsOf: _userAvatarUrl!)
                        self._userAvatar = UIImage(data: avatarImageData)
                    } catch {
                        self._userAvatar = UIImage()
                    }
                }
            }
        }
        
    } // Fechamento init
    
    static func downloadRepositories(page: Int, completed: @escaping ([Repository]) -> ()) {
        let repositoriesURL = URL(string: "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page\(page)")
        var repos = [Repository]()
        
        Alamofire.request(repositoriesURL!).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let items = dict["items"] as? [Dictionary<String, AnyObject>]{
                    for item in items {
                        repos.append(Repository(respositorioDicionario: item))
                    }
                }
            }
            completed(repos)
        }
        
       
    }
        
        
        
    }// Fechamento Classe
    


