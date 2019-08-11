//
//  ViewController.swift
//  Collection View App
//
//  Created by Saliou DJALO on 07/08/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let pages: [Page] = {
        let firstPage = Page(title: "Hundreds of restaurants", desc: "FoodApp has hundreds of restaurants to choose from. When you open the app, you can scroll through the feed for inspiration or search for a particular restaurant or cuisine.", imageName: IMAGE_PAGE_1)
        let secondPage = Page(title: "Easy to order", desc: "When you’re ready to check out, you’ll see your address, an estimated delivery time and the price of the order including tax and delivery fee.", imageName: IMAGE_PAGE_2)
        let thirdPage = Page(title: "Enjoy what you love", desc: "Restaurants you love, delivered to you. Almost everything is available : Pizza, Sushi, Burger, Tandoori, Noodles, Kebab, Waffles, Donuts, Cookies.", imageName: IMAGE_PAGE_3)
        return [firstPage, secondPage, thirdPage]
    }()
    // create a collection programmatically
    // with some properties
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout() // sens de la mise en page
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0 // pas despace entre les collections view
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.isPagingEnabled = true // la collection view se comporte alors comme les pages d'un livre
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.numberOfPages = self.pages.count + 1
        pc.currentPageIndicatorTintColor = UIColor.green
        return pc
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(skipAction), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor.green, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(nextAction), for: .touchUpInside)
        return button
    }()
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotifications()
        
        // Do any additional setup after loading the view.
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        // _ = recupere le resultat renvoye
        
        // pageControl.anchor revoit un tableau de NSLayoutContraint
        // de ce tableau je recupere le second element, qui est bottom et que je stocke dans pageControlBottomAnchor
        
        pageControlBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 15, rightConstant: 0, widthConstant: 0, heightConstant: 30)[1]
        collectionView.delegate = self
        collectionView.dataSource = self
        
        skipButtonTopAnchor = skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 35, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 50).first
        
        nextButtonTopAnchor = nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 35, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 80, heightConstant: 50).first
        
        collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        // c'est la prototype cell en mode programmatique
        
        registerCells()
        
    }
    
    // quand un utilisateur scrolle, cette methode est appele
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // je cache le keyboard, dismiss
        view.endEditing(true)
    }
    
    // comme son nom lindique cette methode est appele quand un drag sur la scroll view vient de se terminer
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        
        // en gros si cest la derniere page
        if pageNumber == pages.count {
            //print("animated control off screen")
            moveControlContraintsOffScreen()
            
        } else {
            pageControlBottomAnchor?.constant = -15 // le decalage sera de 0 par rapport a sa valeur initiale
            skipButtonTopAnchor?.constant = 35
            nextButtonTopAnchor?.constant = 35
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        //print(targetContentOffset.pointee.x)
        //print(view.frame.width)
        //print(pageNumber)
    }
    
    // file private only for this current swift file
    fileprivate func registerCells(){
        collectionView.register(CellModel.self, forCellWithReuseIdentifier: REUSE_IDENTIFIER)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: LOGIN_CELL_ID)
    }
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    // en gros a chaque fois que le clavier apparait je lance cette methode
    @objc func keyboardShow() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
        //print("Keyboard shown")
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            
        }, completion: nil)
        //print("Keyboard shown")
    }
    
    @objc func skipAction(){
        //print("skip pressed")
        
        // Saliou Method
        let indexPath = IndexPath(item: pages.count, section: 0) // item pour collection view et row pour table view
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        moveControlContraintsOffScreen()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        /*
         // Brian Method
         pageControl.currentPage == pages.count - 1
         nextAction()
         */
        
    }
    
    @objc func nextAction(){
        //print("next pressed")
        
        if pageControl.currentPage == pages.count { return } // we are on last page
        
        if pageControl.currentPage == pages.count - 1 {
            moveControlContraintsOffScreen()
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0) // item pour collection view et row pour table view
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
        
    }
    
    fileprivate func moveControlContraintsOffScreen() {
        pageControlBottomAnchor?.constant = 40
        skipButtonTopAnchor?.constant = -40
        nextButtonTopAnchor?.constant = -40
    }
    
}
