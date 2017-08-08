//
//  SecondViewController.swift
//  ParallaxScrollingLikeContactsInIphone
//
//  Created by Lokesh on 09/05/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    
    // These values just references not actual values
    private var mMinNavigationHeight : CGFloat = 44
    private var mMinStatusBarHeight : CGFloat = 20
    private var mNavigationHeight : CGFloat = 100
    private var mCustomNavigationView : CustomNavigationBarView?
    private var mNavigationFrame : CGRect?
    override func viewDidLoad() {
        super.viewDidLoad()
        mMinNavigationHeight = (self.navigationController?.navigationBar.frame.height)!
        print("navigation min height",mMinNavigationHeight)
        self.view.layoutIfNeeded()
        mMinStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
        print("status bar height",mMinStatusBarHeight)
        mNavigationHeight = UIScreen.main.bounds.height*0.3
        print("navigation Height",mNavigationHeight)
        
        
        mNavigationFrame = self.navigationController?.navigationBar.frame
        
        mCustomNavigationView = CustomNavigationBarView.init(frame: CGRect.init(x: 0, y: 0, width: mNavigationFrame!.width, height: mNavigationHeight-mMinStatusBarHeight))
        self.navigationController?.navigationBar.addSubview(mCustomNavigationView!)
        
        self.navigationController?.navigationBar.clipsToBounds = false
        
        mCustomNavigationView?.layoutIfNeeded()
        self.view.layoutIfNeeded()
        self.navigationItem.hidesBackButton = true
        let height = mNavigationHeight - mMinStatusBarHeight - mMinNavigationHeight
        mTableView.contentInset = UIEdgeInsets.init(top: height, left: 0, bottom: 0, right: 0)
        mTableView.scrollIndicatorInsets = UIEdgeInsets.init(top: height, left: 0, bottom: 0, right: 0)
        mCustomNavigationView?.mBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        mCustomNavigationView?.removeFromSuperview()
        mCustomNavigationView = nil
    }
    func backButtonPressed() {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        changeTheTopLayout(with: scrollView.contentOffset.y)
        
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
    func changeTheTopLayout(with number: CGFloat) {
        let height = mMinNavigationHeight
        if number <= 0{
            if let navBarFrame = self.navigationController?.navigationBar.frame
            {
                self.mCustomNavigationView?.frame = CGRect.init(x: 0, y: 0, width: navBarFrame.width, height: -number + height)
                self.mCustomNavigationView?.layoutIfNeeded()
                self.mCustomNavigationView?.layoutSubviews()
            }
        }
    }
    func checkingForExtraDragging(with number : CGFloat) {
        if number > 0{
            UIView.animate(withDuration: 0.2, animations: {
                self.changeTheTopLayout(with: 0)
            })
        }
    }

}
extension SecondViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00000001
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 20
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        return cell!
    }
    
}
extension UIColor{
    convenience init(hexString: String)
    {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
