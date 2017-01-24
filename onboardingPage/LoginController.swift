//
//  ViewController.swift
//  onboardingPage
//
//  Created by Xin Zou on 1/23/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    lazy var collection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        // 7: set scroll direction, and space between pages:
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.dataSource = self // 1: lazy var, add delegate for class extension,
        c.delegate = self   // 2: lazy var, also needs numberOfItemsInSection, cellForItemAtIndexPath;
        c.backgroundColor = UIColor.white
        // 8: make it snap as pages: 
        c.isPagingEnabled = true
        return c
    }()
    
    let pages : [Page] = {
        let firstPage = Page(title: "first page title", text: "first page test and a lot of text here ha ha ha hah haha ha ah a hah a ah  ah aha!!!", imgName: "page1")
        let secondPage = Page(title: "2nd page title", text: "2 2 2 2 2     2  2 2 2 2 22222 222 2 2 2 2 2  2 2 2 2 2 2 22  2 2", imgName: "page2")
        let thirdPage = Page(title: "3rd page title", text: "3333  333 3 3 3 3 3 3 3 3 3 3 3  3 3333 33  33 3  3 3 3 3  3 3 3  3", imgName: "page3")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    lazy var pageDotController : UIPageControl = {
        let p = UIPageControl()
        p.pageIndicatorTintColor = UIColor.lightGray
        p.currentPageIndicatorTintColor = UIColor(red: 0.9, green: 0.5, blue: 0.1, alpha: 1)
        p.numberOfPages = self.pages.count + 1
        return p
    }()
    
    lazy var skipButton : UIButton = {
        let b = UIButton(type: .system)
        b.setTitleColor(UIColor(red: 0.9, green: 0.6, blue: 0.3, alpha: 1), for: .normal)
        b.setTitle("Skip", for: .normal)
        b.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return b
    }()
    lazy var nextButton : UIButton = {
        let b = UIButton(type: .system)
        b.setTitleColor(UIColor(red: 0.9, green: 0.6, blue: 0.3, alpha: 1), for: .normal)
        b.setTitle("Next", for: .normal)
        b.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return b
    }()
    func nextButtonTapped(){
        if pageDotController.currentPage == pages.count {
            return
        }
        if pageDotController.currentPage == pages.count - 1 {
            moveControlConstranOffScreen()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { 
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        let indexPath = IndexPath(item: pageDotController.currentPage + 1, section: 0)
        collection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageDotController.currentPage += 1
    }
    func skipButtonTapped(){
        pageDotController.currentPage = pages.count - 1
        nextButtonTapped()
    }
    
    let cellId = "CellId"
    let loginCellId = "loginCellId"
    
    var pageControlBottomAnchor : NSLayoutConstraint?
    var skipButtonTopAnchor :     NSLayoutConstraint?
    var nextButtonTopAnchor :     NSLayoutConstraint?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotifications()
        
        view.addSubview(collection)
        //collection.frame = self.view.frame // but it will not fit in Landscape;
        // 3: so we use extension UIView{} to override the constants;
        collection.anchorToTop(top: view.topAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
        // 5: regist cell class: 
        // collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        registerCells()
        // 9: new file for PageCell to replace above UICollectionViewCell;
        
        view.addSubview(pageDotController)
        pageControlBottomAnchor = pageDotController.anchor(nil, view.leftAnchor, view.bottomAnchor, view.rightAnchor, topConstraint: 0, leftConstraint: 0, bottomConstraint: 0, rightConstraint: 0, widthConstraint: 0, heightConstraint: 30)[1] // take the 2nd one:botm anchor;
        
        view.addSubview(skipButton)
        skipButtonTopAnchor = skipButton.anchor(view.topAnchor, view.leftAnchor, nil, nil, topConstraint: 16, leftConstraint: 20, bottomConstraint: 0, rightConstraint: 0, widthConstraint: 60, heightConstraint: 60).first
        
        view.addSubview(nextButton)
        nextButtonTopAnchor = nextButton.anchor(view.topAnchor, nil, nil, view.rightAnchor, topConstraint: 16, leftConstraint: 0, bottomConstraint: 0, rightConstraint: 20, widthConstraint: 60, heightConstraint: 60).first
    }
    
    fileprivate func registerCells(){ // different cells register:
        collection.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        // this one for the last login page:
        collection.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    // 4: for UICollectionViewDataSource:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1 // pages for on boarding, one more for login page;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == pages.count { // for the last page cell;
            let loginCell = collection.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            loginCell.loginController = self // passing self pointer into LoginCell.swift for LoginButton; 
            return loginCell
        }
        
        let cell = collection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell // already regist as PageCell;
        //cell.backgroundColor = UIColor.white
        let pageAtRow = pages[indexPath.item]
        cell.page = pageAtRow
        
        return cell
    }
    
    // to find which page currently on:
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //print(targetContentOffset.pointee.x)
        let pageNum = Int(targetContentOffset.pointee.x / self.view.frame.width)
        pageDotController.currentPage = pageNum
        
        // while on the last page: 
        if pageNum == pages.count {
            moveControlConstranOffScreen()
        }else if pageNum == pages.count - 1 {
            pageControlBottomAnchor?.constant = 0
            skipButtonTopAnchor?.constant = 16
            nextButtonTopAnchor?.constant = 16
        }
        //UIView.animate(withDuration: 0.5, animations: {
        //    self.view.layoutIfNeeded()
        //}) // use a better animate:
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { 
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
        // hide keyboard and move view back down: 
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { 
            self.view.frame.origin.y = 0
        }, completion: nil)
    }
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    func keyboardShow(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { 
            let y: CGFloat = (UIDevice.current.orientation.isLandscape) ? 200 : 50
            self.view.frame.origin.y = -y
            //self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    fileprivate func moveControlConstranOffScreen(){
        pageControlBottomAnchor?.constant = 40
        skipButtonTopAnchor?.constant = -40
        nextButtonTopAnchor?.constant = -40
    }
    
    
    // 6: set size for all cells: sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.view.frame.size
    }
    
    func finishLoggingIn(){ // will be call in LoginCell.swift;
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootViewController as? MainNavigationController else {return}
        mainNavigationController.viewControllers = [HomeController()]
        
        // save login statues into UserDefault: 
        //UserDefaults.standard.set(true, forKey: "isLoggedIn")
        //UserDefaults.standard.synchronize() // save it;
        // replace above lines after self define the func: 
        UserDefaults.standard.setIsLoggedIn(value: true)
        
        dismiss(animated: true, completion: nil)
    }

    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        //print(UIDevice.current.orientation.isPortrait)
        collection.collectionViewLayout.invalidateLayout() // for Portrait to Landscape;
        
        let indexPath = IndexPath(item: pageDotController.currentPage, section: 0)
        DispatchQueue.main.async {
            // for reload cell items:
            self.collection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collection.reloadData() // could also rename image if need;
        }
    }
    
    
    

}
