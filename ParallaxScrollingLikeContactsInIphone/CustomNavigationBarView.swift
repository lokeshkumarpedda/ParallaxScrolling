//
//  CustomNavigationBarView.swift
//  KeyValueObserving
//
//  Created by Next on 08/05/17.
//  Copyright © 2017 Next. All rights reserved.
//

import UIKit

class CustomNavigationBarView: UIView {

    @IBOutlet weak var mProfilePic: UIImageView!
    @IBOutlet var mContentView: UIView!
    
    @IBOutlet weak var mNameLabel: UILabel!
    
    @IBOutlet weak var mBackButton: UIButton!
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        mProfilePic.layer.cornerRadius = mProfilePic.frame.width/2
        layoutSubviews()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        mProfilePic.layer.cornerRadius = mProfilePic.frame.width/2
        mNameLabel.textAlignment = .center
    }
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
        UINib.init(nibName: "CustomNavigationBarView", bundle: nil).instantiate(withOwner: self, options: nil)
        mContentView.frame = bounds
        addSubview(mContentView)
        
    }

}
