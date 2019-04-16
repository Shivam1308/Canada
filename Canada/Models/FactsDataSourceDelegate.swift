//
//  CollectionDataSourceDelegate.swift
//  Canada
//
//  Created by Philips on 4/12/19.
//  Copyright © 2019 Shivam. All rights reserved.
//

import UIKit

class FactsDataSourceDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var facts: CanadaFacts?
    
    override init() {
        do {
            // fetch facts
            let data = try CanadaHelper.fetchFileWithName(CanadaHelper.factsEndpoint)
            facts = try JSONDecoder().decode(CanadaFacts.self, from: data!)
        } catch {
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return facts?.rows.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FactCollectionViewCell.Id, for: indexPath) as! FactCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.titleLabel.text = facts?.rows[indexPath.row].title
        cell.descriptionLabel.text = facts?.rows[indexPath.row].description
        if let imageUrl = facts?.rows[indexPath.row].imageHref {
            cell.photoImageView.loadImageUsingString(urlString: imageUrl)
        }else{
            cell.photoImageView.image = UIImage(named: FactCollectionViewCell.PlaceHolder)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //Check for data
        guard let data = facts?.rows[indexPath.item] else {
            return CGSize(width: 0, height: 0)
        }
        
        //if Data description is null
        if facts?.rows[indexPath.item].title == nil && facts?.rows[indexPath.item].imageHref == nil && facts?.rows[indexPath.item].description == nil {
            return CGSize(width: 0, height: 0)
        }

        //Screen size
        let screenSize = UIScreen.main.bounds
        let approximateWidth = screenSize.width
        let size = CGSize(width: approximateWidth, height: 1000)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]
        
        //Estimate height for Description text
        if let description = data.description {
            let estimatedFrame = NSString(string: description).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            return CGSize(width: approximateWidth, height: estimatedFrame.height + FactCollectionViewCell.imageSize)
        }
        return CGSize(width: approximateWidth, height: FactCollectionViewCell.imageSize)
    }
    
    
}
