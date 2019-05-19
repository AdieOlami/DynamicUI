//
//  BaseVC.swift
//  Softcom
//
//  Created by Olar's Mac on 5/18/19.
//  Copyright © 2019 Adie Olalekan. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    private var pageController: UIPageViewController?
    
    var base = [BaseModel]()
    var pg = [PagesModel]()
    var elements = [ElementsModel]()
    var sections = [SectionsModel]()
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parseJSON()
        
        let pgs = base.flatMap{$0.pages}
        pg.append(contentsOf: pgs)
        
        let first = pg[currentIndex].sections.flatMap{$0.elements}
        elements.append(contentsOf: first)
        setupPageController()
    }
    
    func removeSwipeGesture(){
        for view in self.pageController!.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    
}

//MARK:- PageController
extension BaseVC: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! TableVC).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return viewControllerAtIndex(index: index)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! TableVC).pageIndex
        if index == NSNotFound {return nil}
        index += 1
        if (index == self.pg.count) {
            return nil
        }
        return viewControllerAtIndex(index: index)
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pg.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    private func setupPageController() {
        
        self.pageController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.pageController?.dataSource = self
        self.pageController?.delegate = self
        
        let startingViewController: TableVC = viewControllerAtIndex(index: 0)!
        let viewControllers = [startingViewController]
        pageController?.setViewControllers(viewControllers , direction: .forward, animated: false, completion: nil)
        pageController?.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height);
        
        addChild(pageController!)
        view.addSubview(pageController!.view)
        removeSwipeGesture()
        
    }
    
    func viewControllerAtIndex(index: Int) -> TableVC? {
        if self.pg.count == 0 || index >= self.pg.count {
            return nil
        }
        
        let pageContentViewController = TableVC()
        pageContentViewController.pageM = pg
        pageContentViewController.pageIndex = index
        currentIndex = index
        pageContentViewController.tableView.reloadData()
        pageContentViewController.nextClick = {[unowned self] in
            self.nextBtnClicked()
        }
        pageContentViewController.backClick = {[unowned self] in
            self.backBtnClicked()
        }
        return pageContentViewController
    }
    
    func backBtnClicked() {

        guard currentIndex - 1 >= 0 else { return }
        currentIndex -= 1
        guard let startingViewController = viewControllerAtIndex(index: currentIndex) else { return }
        pageController?.setViewControllers([startingViewController], direction: .reverse, animated: false)
        
    }
    
    @objc func nextBtnClicked() {

        guard currentIndex + 1 < pg.count else { return }
        currentIndex  += 1
        guard let startingViewController = viewControllerAtIndex(index: currentIndex) else { return }
        pageController?.setViewControllers([startingViewController], direction: .forward, animated: false)
        
    }
}
    

//MARK:- JSON Parsing
extension BaseVC {
    
    fileprivate func parseJSON() {
        guard let data = stubbedResponse("pet_adoption") else {return}
        do {
            let decoded = try JSONDecoder().decode(BaseModel.self, from: data)
            base.append(decoded)
            
        } catch {
            
        }
        
        let array = base.compactMap {$0}
            .flatMap{$0.pages}
        array.forEach { (pg) in
            sections.append(contentsOf: pg.sections)
        }

    }
    
    fileprivate func stubbedResponse(_ filename: String) -> Data! {
        @objc class TestClass: NSObject {}
        
        let bundle = Bundle(for: TestClass.self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
        
    }
}


