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
    public var scrollDirection = UICollectionViewScrollDirection.vertical
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
                case .vertical:
                    return owner.frame.width
                case .horizontal:
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
        case .horizontal:
            cellLength = self.cellSize.height
        case .vertical:
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
        self.numberOfCells = aDecoder.decodeInteger(forKey: "numberOfCells")
        self.cellSize = aDecoder.decodeCGSize(forKey: "cellSize")
        self.interitemSpacing = CGFloat(aDecoder.decodeDouble(forKey: "interitemSpacing"))
        super.init(coder: aDecoder)
    }
    
    
    public override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(self.numberOfCells, forKey: "numberOfCells")
        aCoder.encode(self.cellSize, forKey: "cellSize")
        aCoder.encode(Double(self.interitemSpacing), forKey: "interitemSpacing")
    }
    
    // MARK: - Logic
    public override var collectionViewContentSize:CGSize {
        let n = CGFloat(self.numberOfCells)
        let m = CGFloat(self.axisCount)
        let minorAxisLength = n * self.cellSize.height + (n + 1.0) * self.interitemSpacing
        switch self.scrollDirection {
        case .horizontal:
            return CGSize(width: self.cellSize.width * m + self.interitemSpacing * (m + 1.0), height: minorAxisLength)
        case .vertical:
            return CGSize(width: minorAxisLength, height: self.cellSize.height * m + self.interitemSpacing * (m + 1.0))
        }
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes:[UICollectionViewLayoutAttributes] = []
        for i in 0..<self.numberOfCells {
            if let attribute = self.layoutAttributesForItem(at: IndexPath(item: i, section: 0))/* where attribute.frame.intersects(rect)*/ {
                attributes.append(attribute)
            }
        }
        
        return attributes
    }

    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        guard indexPath.item >= 0 && indexPath.item < self.numberOfCells else {
            return nil
        }
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
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
        case .horizontal:
            let y = self.minorAxisLength / 2.0 + self.cellSize.height * offset + self.interitemSpacing * offset
            center = CGPoint(x: self.cellSize.width * (n - 0.5) + n * self.interitemSpacing, y: y)
        case .vertical:
            let x = self.minorAxisLength / 2.0 + self.cellSize.width * offset + self.interitemSpacing * offset
            center = CGPoint(x: x, y: self.cellSize.height * (n + 0.5) + n * self.interitemSpacing)
        }
        attributes.frame = CGRect(center: center, size: self.cellSize)
        return attributes
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}
#endif
