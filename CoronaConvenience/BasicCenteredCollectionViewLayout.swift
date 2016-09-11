//
//  BasicCenteredCollectionViewLayout.swift
//  OmniSwift
//
//  Created by Cooper Knaak on 3/24/16.
//  Copyright © 2016 Cooper Knaak. All rights reserved.
//

#if os(iOS)
import UIKit

public class BasicCenteredCollectionViewLayout: UICollectionViewLayout {

    // MARK: - Properties
    
    public let numberOfCells:Int
    public let cellSize:CGSize
    public var interitemSpacing:CGFloat = 8.0
    public var scrollDirection = UICollectionViewScrollDirection.Vertical
    private var internalMajorAxisLength:CGFloat = 1024.0
    private var internalMinorAxisLength:CGFloat = 128.0
    public var majorAxisLength:CGFloat {
        get {
            /*
            if let owner = self.collectionOnwer {
                switch self.scrollDirection {
                case .Vertical:
                    return self.collectionOnwer
                }
            }
            return self.collectionView?.frameself.internalMajorAxisLength
             */
            return self.internalMajorAxisLength
        }
        set { self.internalMajorAxisLength = newValue }
    }
    public var minorAxisLength:CGFloat {
        get {
            if let owner = self.collectionView {
                switch self.scrollDirection {
                case .Vertical:
                    return owner.frame.width
                case .Horizontal:
                    return owner.frame.height
                }
            } else {
                return self.internalMinorAxisLength
            }
        }
        set { self.internalMinorAxisLength = newValue }
    }
    
    public var axisCount:Int {
        return Int(ceil(CGFloat(self.numberOfCells) / CGFloat(self.itemsInAxis)))
    }
    public var itemsInAxis:Int {
        let cellLength:CGFloat
        switch self.scrollDirection {
        case .Horizontal:
            cellLength = self.cellSize.height
        case .Vertical:
            cellLength = self.cellSize.width
        }
        return Int(floor((self.majorAxisLength - self.interitemSpacing) / (cellLength + self.interitemSpacing)))
    }
    
    // MARK: - Setup
    
    public init(numberOfCells:Int, cellSize:CGSize) {
        self.numberOfCells = numberOfCells
        self.cellSize = cellSize
        super.init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.numberOfCells = aDecoder.decodeIntegerForKey("numberOfCells")
        self.cellSize = aDecoder.decodeCGSizeForKey("cellSize")
        self.interitemSpacing = CGFloat(aDecoder.decodeDoubleForKey("interitemSpacing"))
        super.init(coder: aDecoder)
    }
    
    public override func encodeWithCoder(aCoder: NSCoder) {
        super.encodeWithCoder(aCoder)
        aCoder.encodeInteger(self.numberOfCells, forKey: "numberOfCells")
        aCoder.encodeCGSize(self.cellSize, forKey: "cellSize")
        aCoder.encodeDouble(Double(self.interitemSpacing), forKey: "interitemSpacing")
    }
    
    // MARK: - Logic
    
    public override func collectionViewContentSize() -> CGSize {
        let n = CGFloat(self.numberOfCells)
        let m = CGFloat(self.axisCount)
        let minorAxisLength = n * self.cellSize.height + (n + 1.0) * self.interitemSpacing
        switch self.scrollDirection {
        case .Horizontal:
            return CGSize(width: self.cellSize.width * m + self.interitemSpacing * (m + 1.0), height: minorAxisLength)
        case .Vertical:
            return CGSize(width: minorAxisLength, height: self.cellSize.height * m + self.interitemSpacing * (m + 1.0))
        }
    }
    
    public override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes:[UICollectionViewLayoutAttributes] = []
        for i in 0..<self.numberOfCells {
            if let attribute = self.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: i, inSection: 0))/* where attribute.frame.intersects(rect)*/ {
                attributes.append(attribute)
            }
        }
        
        return attributes
    }
    
    public override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard indexPath.item >= 0 && indexPath.item < self.numberOfCells else {
            return nil
        }
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        let itemsInAxis = self.itemsInAxis
        let majorIndex = indexPath.item / itemsInAxis
        let minorIndex = indexPath.item % itemsInAxis
        let itemCount:Int
        if majorIndex == self.numberOfCells / itemsInAxis {
            //Last axis, might not be full
            itemCount = self.numberOfCells % itemsInAxis
        } else {
            //Not the last axis, guaranteed to be full
            itemCount = itemsInAxis
        }
        let n = CGFloat(majorIndex)
        let offset = CGFloat(-itemCount) / 2.0 + 0.5 + CGFloat(minorIndex)
        let center:CGPoint
        switch self.scrollDirection {
        case .Horizontal:
            let y = self.minorAxisLength / 2.0 + self.cellSize.height * offset + self.interitemSpacing * offset
            center = CGPoint(x: self.cellSize.width * (n - 0.5) + n * self.interitemSpacing, y: y)
        case .Vertical:
            let x = self.minorAxisLength / 2.0 + self.cellSize.width * offset + self.interitemSpacing * offset
            center = CGPoint(x: x, y: self.cellSize.height * (n + 0.5) + n * self.interitemSpacing)
        }
        attributes.frame = CGRect(center: center, size: self.cellSize)
        return attributes
    }
    
    public override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }

}
#endif