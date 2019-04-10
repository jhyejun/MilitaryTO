//
//  HJLeftAlignCollectionViewFlowLayout.swift
//  MilitaryTO
//
//  Created by 장혜준 on 11/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class HJLeftAlignCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}
