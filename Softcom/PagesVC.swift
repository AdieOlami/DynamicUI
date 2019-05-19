//
//  PagesVC.swift
//  Softcom
//
//  Created by Olar's Mac on 5/19/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

//MARK:- USING STACKVIEW {not a good way. can not handle longer view}
class PagesVC: UIViewController {

    var pageIndex : Int = 0
    var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        return sv
    }()
    var pageM = [PagesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ])
        
        let first = pageM[pageIndex].sections.flatMap{$0.elements}
        first.forEach { (element) in
            guard let type = element.type else {return}
            stackView.addArrangedSubview(TypeView.typeRet(type: type, placeholder: element.label))
        }

    }

}
