//
//  ViewController.swift
//  Mafia
//
//  Created by Eugene Lu on 2018-05-18.
//  Copyright © 2018 Eugene Lu. All rights reserved.
//

import UIKit
import Alamofire

class HomeController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        homeView.delegate = self
    }
    
    let homeView: HomeView = {
        let hv = HomeView()
        hv.translatesAutoresizingMaskIntoConstraints = false
        return hv
    }()
    
    fileprivate func setupViews() {
        view.addSubview(homeView)
        updateViewConstraints()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        homeView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        homeView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

//Home view delegate methods
extension HomeController:HomeViewDelegate {
    func joinPressed() {
        let join = JoinController()
        present(join, animated: true, completion: nil)
    }
    
    func createPressed() {
        let create = CreateController()
        present(create, animated: true, completion: nil)
    }
    
    func rolesPressed() {
        
    }
}

