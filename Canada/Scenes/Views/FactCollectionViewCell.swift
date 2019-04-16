//
//  FactCollectionViewCell.swift
//  Canada
//
//  Created by Philips on 4/12/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit

class FactCollectionViewCell: UICollectionViewCell {
    
    static let Id = "factCell"
    static let PlaceHolder = "Placeholder"
    static let imageSize: CGFloat = 60

    /* photoImageView: Image for cell */
    let photoImageView: UIImageView = {
        let iv =  UIImageView(frame: CGRect.zero)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.isUserInteractionEnabled = false
        iv.layer.masksToBounds = true
        iv.layer.borderWidth = 1.5
        return iv
    }()
    
    /* titleLabel: Title Label for cell */
    let titleLabel: UILabel = {
        let label = UILabel()
        let boldHelveticaFont = UIFont(name: "Helvetica Neue", size: 15)?.fontDescriptor.withSymbolicTraits(UIFontDescriptor.SymbolicTraits.traitBold)
        label.font = UIFont(descriptor: boldHelveticaFont!, size: 15)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /* descriptionLabel: Description for cell */
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = CanadaHelper.themeColor
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        //Layout with uiview extension file
        photoImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: FactCollectionViewCell.imageSize, heightConstant: FactCollectionViewCell.imageSize)
        
        titleLabel.anchor(self.topAnchor, left: self.photoImageView.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 12, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        descriptionLabel.anchor(titleLabel.bottomAnchor, left: titleLabel.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant:0, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)

        self.layoutIfNeeded()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
