//
//  ViewController.swift
//  ParallaxScrollingLikeContactsInIphone
//
//  Created by Lokesh on 09/05/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    
    fileprivate let mMinStatusBarHeight : CGFloat = 20
    fileprivate var mMinNavigationHeight : CGFloat = 44
    fileprivate var mNavigationHeight : CGFloat = 200
    
    fileprivate var mCustomNavigationView : HomeNavigationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mMinNavigationHeight = (self.navigationController?.navigationBar.frame.height)!
        print("navigation min height",mMinNavigationHeight)
        self.view.layoutIfNeeded()
        let mMinStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
        print("status bar height",mMinStatusBarHeight)
        mNavigationHeight = UIScreen.main.bounds.height*0.4
        print("navigation Height",mNavigationHeight)
        
        mCustomNavigationView = HomeNavigationView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: mNavigationHeight))
        mCustomNavigationView?.mHeightOfImageBackgroundView.constant = mNavigationHeight * 0.5
        self.navigationController?.navigationBar.addSubview(mCustomNavigationView!)
        mCustomNavigationView?.mImageBackgroundView.layoutIfNeeded()
        mCustomNavigationView?.layoutIfNeeded()
        self.navigationItem.hidesBackButton = true
        
        let height : CGFloat = mNavigationHeight - mMinStatusBarHeight - mMinNavigationHeight
        mTableView.contentInset = UIEdgeInsets.init(top: height, left: 0, bottom: 0, right: 0)
        mTableView.scrollIndicatorInsets = UIEdgeInsets.init(top: height, left: 0, bottom: 0, right: 0)
        mTableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .bottom, animated: false)
        
    }
    override func viewWillAppear(_ animated: Bool) {
       self.navigationController?.navigationBar.addSubview(mCustomNavigationView!)
    }
    override func viewWillDisappear(_ animated: Bool) {
        mCustomNavigationView?.removeFromSuperview()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        return cell!
    }
    
    // scrollview methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        changeTheTopLayout(with: scrollView.contentOffset.y)
        print("Scrolling : -", scrollView.contentOffset.y)
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        print("begin dragging")
        print(scrollView.contentOffset.y)
        print("=====")
        
        checkingForExtraDragging(with: scrollView.contentOffset.y)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        print("==end dragging")
        print(scrollView.contentOffset.y)
        print(decelerate)
        print("=======")
        
        
        checkingForExtraDragging(with: scrollView.contentOffset.y)
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView){
        print("--begin deccelerating")
        print(scrollView.contentOffset.y)
        print("========")
        
        checkingForExtraDragging(with: scrollView.contentOffset.y)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        print("XXXX end deccelerating")
        print(scrollView.contentOffset.y)
        print("=========")
        
        checkingForExtraDragging(with: scrollView.contentOffset.y)
        
    }
    func changeTheTopLayout(with number: CGFloat)
    {
        let height = -number + mMinNavigationHeight
        let dragableHeight : CGFloat = -(mNavigationHeight - mMinNavigationHeight - mMinStatusBarHeight)
        if number <= 0 && number >= dragableHeight
        {
            if let navBarFrame = self.navigationController?.navigationBar.frame
            {
                self.mCustomNavigationView?.frame = CGRect.init(x: 0, y: 0, width: navBarFrame.width, height: height)
                var imageAlpfaValue : CGFloat = height/200 // 200 because half of the speed we have to decrease the alpha and alpha value is only 0 to 1 so we dividing 2 * 100
                
                var titleAlpha : CGFloat = 0
                if imageAlpfaValue > 0.8
                {
                    titleAlpha = (imageAlpfaValue - 0.8) * 10
                    print("Title alpha",titleAlpha)
                }
                mCustomNavigationView?.mTitleLabel.alpha = titleAlpha
                print("Alpha Value:- ",imageAlpfaValue)
                if imageAlpfaValue < 0.25
                {
                    imageAlpfaValue = 0
                }
                if imageAlpfaValue < 0.6
                {
                    imageAlpfaValue = imageAlpfaValue - 0.15
                }
                else
                {
                    imageAlpfaValue = imageAlpfaValue + 0.1
                }
                self.mCustomNavigationView?.mSchoolLogoImageView.alpha = imageAlpfaValue
                self.mCustomNavigationView?.layoutIfNeeded()
                self.mCustomNavigationView?.layoutSubviews()
            }
        }
        else if number > 0
        {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                self.mCustomNavigationView?.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.mMinNavigationHeight)
                self.mCustomNavigationView?.mSchoolLogoImageView.alpha = 0
                self.mCustomNavigationView?.mTitleLabel.alpha = 0
                self.mCustomNavigationView?.layoutIfNeeded()
                self.mCustomNavigationView?.layoutSubviews()
                
            }, completion: nil)
        }
        else if number < dragableHeight
        {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                self.mCustomNavigationView?.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.mNavigationHeight-self.mMinStatusBarHeight)
                self.mCustomNavigationView?.mSchoolLogoImageView.alpha = 1
                self.mCustomNavigationView?.mTitleLabel.alpha = 1
                self.mCustomNavigationView?.layoutIfNeeded()
                self.mCustomNavigationView?.layoutSubviews()
                
            }, completion: nil)
        }
    }
    func checkingForExtraDragging(with number : CGFloat)
    {
        if number > 10
        {
            self.changeTheTopLayout(with: 0)
        }
    }

}
