//
//  RepositorioViewController.swift
//  ConsultaAPIGitHub
//
//  Created by Caio Araujo Mariano on 04/10/2018.
//  Copyright © 2018 Caio Araujo Mariano. All rights reserved.
//

import UIKit

class RepositorioViewController: UITableViewController {
    
    //MARK: Propriedades
    var searchURL = "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1"
    var userURL = "https://api.github.com/users/"
    var indexOfPageToRequest = 1
    var numberOfRows = 0
    var numberOfRowsInPage = 30
    var repos = [Repository]()
    var loadedPages = 0
    
    // Indicador -- aparece quando a lista carrega no final
    private let indicatorFooter = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorFooter.frame.size.height = 100
        indicatorFooter.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        indicatorFooter.startAnimating()
        
        getData()
    }
    
    //MARK: Funcoes
    func getData(){
        
        self.loadedPages += 1
        
        Repository.downloadRepositories(page: self.loadedPages) { repos in
            self.repos += repos
            self.tableView.tableFooterView = nil
            self.tableView.reloadData()
        }
    }
    
    //MARK: tableView -- numberOfRowsInSection
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos.count
        
    }
    
    //MARK: tableView -- cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let mainImageView = cell?.viewWithTag(2) as! UIImageView
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        let descriptionLabel = cell?.viewWithTag(3) as! UILabel
        let userNameLabel = cell?.viewWithTag(4) as! UILabel
        let forkCountLabel = cell?.viewWithTag(5) as! UILabel
        let starCountLabel = cell?.viewWithTag(6) as! UILabel
        let userRealNameLabel = cell?.viewWithTag(7) as? UILabel
        
        
        
        
        let repo = self.repos[indexPath.row]
        
        mainImageView.image = repo.userAvatar
        mainLabel.text = repo.name
        descriptionLabel.text = repo.description
        userNameLabel.text = repo.userLoginName
        userRealNameLabel?.text = repo.userRealName
        forkCountLabel.text = String(repo.quantityOfForks)
        starCountLabel.text = String(repo.quantityOfStargazers)
        
        return cell!
    }
    
    //MARK: tableView -- willDisplay cell
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == repos.count {
            tableView.tableFooterView = indicatorFooter
            self.getData()
        }
        
    }
    //MARK: Prepare -- segue PullsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        let vc = segue.destination as! PullsViewController
        let repo = self.repos[indexPath!]
        vc.repo = repo
    }
    
}
