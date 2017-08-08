//
//  HomeNavigationView.swift
//  ParallaxScrollingLikeContactsInIphone
//
//  Created by Next on 23/05/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

class HomeNavigationView: UIView {

    @IBOutlet var mContentView: UIView!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mSchoolNameLabel: UILabel!
    @IBOutlet weak var mSchoolLogoImageView: UIImageView!
    
    @IBOutlet weak var mHeightOfImageBackgroundView: NSLayoutConstraint!
    
    @IBOutlet weak var mImageBackgroundView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    /// Loading the the nib, registering cells, adding swipe gestures
    private func loadNib() {
        UINib.init(nibName: "HomeNavigationView", bundle: nil).instantiate(withOwner: self, options: nil)
        mContentView.frame = bounds
        addSubview(mContentView)
        
    }

}
