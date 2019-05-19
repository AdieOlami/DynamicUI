//
//  TableVC.swift
//  Softcom
//
//  Created by Olar's Mac on 5/19/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

class TableVC: UIViewController {

    var customElements: [ElementsModel]!
    var pageM = [PagesModel]()
    var elements = [ElementsModel]()
    var pageIndex : Int = 0
    var maxHeight: CGFloat = UIScreen.main.bounds.size.height
    
    var nextClick: (() -> ())?
    var backClick: (() -> ())?
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 10
        sv.distribution = .fillEqually
        return sv
    }()
    
    let nextBtn: DefaultButton = {
        let nextBtn = DefaultButton()
        nextBtn.setTitle("Next", for: .normal)
        return nextBtn
    }()
    
    let backBtn: DefaultButton = {
        let backBtn = DefaultButton()
        backBtn.setTitle("Back", for: .normal)
        return backBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let first = pageM[pageIndex].sections.flatMap{$0.elements}
        elements.append(contentsOf: first)
        layout()
    }
    
    func configureUI() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        customView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -16).isActive = true
        stackView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: 0).isActive = true
        stackView.addArrangedSubview(backBtn)
        stackView.addArrangedSubview(nextBtn)
        nextBtn.addTarget(self, action: #selector(nxtAction), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        tableView.tableFooterView = customView
    }
    
    @objc func nxtAction(_ sender: UIButton!) {
        if let nextClick = nextClick {
            nextClick()
        }
    }
    
    @objc func backAction(_ sender: UIButton!) {
        if let backClick = backClick {
            backClick()
        }
    }
    
    //MARK:- Layouts
    fileprivate func layout() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        elements.forEach { (el) in
            guard let id  = el.unique_id else {return}
            self.tableView.register(ElementsCell.self, forCellReuseIdentifier: id)
        }
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            ])
        
    }

}

extension TableVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = elements[indexPath.row]
        let cellIdentifier = cellModel.unique_id
        let customCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath) as! CustomElementCell
        
        customCell.configure(withModel: cellModel)
        
        
        return customCell as! UITableViewCell
    }
}

