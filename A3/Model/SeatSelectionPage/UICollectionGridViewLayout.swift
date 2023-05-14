//
//  UICollectionGridViewLayout.swift
//
import Foundation
import UIKit


class UICollectionGridViewLayout: UICollectionViewLayout {
    //Records the layout properties for each cell
    private var itemAttributes: [[UICollectionViewLayoutAttributes]] = []
    private var itemsSize: [NSValue] = []
    private var contentSize: CGSize = CGSize.zero
    
    var viewController: UICollectionGridViewController!
    

    override func prepare() {
        if collectionView!.numberOfSections == 0 {
            return
        }
        
        var column = 0
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var contentWidth: CGFloat = 0
        var contentHeight: CGFloat = 0
        
        if itemAttributes.count > 0 {
            return
        }
        
        itemAttributes = []
        itemsSize = []
        
        if itemsSize.count != viewController.cols.count {
            calculateItemsSize()
        }
        
        for section in 0 ..< (collectionView?.numberOfSections)! {
            var sectionAttributes: [UICollectionViewLayoutAttributes] = []
            for index in 0 ..< viewController.cols.count {
                let itemSize = itemsSize[index].cgSizeValue
                
                let indexPath = IndexPath(item: index, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                //Prevents two border lines from showing up between left and right cells
                if index == 0{
                    attributes.frame = CGRect(x:xOffset, y:yOffset, width:itemSize.width,
                                              height:itemSize.height).integral
                }else {
                    attributes.frame = CGRect(x:xOffset-1, y:yOffset,
                                              width:itemSize.width+1,
                                              height:itemSize.height).integral
                }
                
             
                if section == 0 {
                    //Position fixation
                    var frame = attributes.frame
                    frame.origin.y = self.collectionView!.contentOffset.y
                    attributes.frame = frame
                    attributes.zIndex = 1024
                }
                
                sectionAttributes.append(attributes)
                
                xOffset = xOffset+itemSize.width
                column += 1
                
                if column == viewController.cols.count {
                    if xOffset > contentWidth {
                        contentWidth = xOffset
                    }
                    
                    column = 0
                    xOffset = 0
                    yOffset += itemSize.height
                }
            }
            itemAttributes.append(sectionAttributes)
        }
        
        let attributes = itemAttributes.last!.last! as UICollectionViewLayoutAttributes
        contentHeight = attributes.frame.origin.y + attributes.frame.size.height
        contentSize = CGSize(width:contentWidth, height:contentHeight)
    }
    
    //Called when you update layout
    override func invalidateLayout() {
        itemAttributes = []
        itemsSize = []
        contentSize = CGSize.zero
        super.invalidateLayout()
    }
    
   
    override var collectionViewContentSize: CGSize {
        get {
            return contentSize
        }
    }
    
    // Location and size
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
        return itemAttributes[indexPath.section][indexPath.row]
    }
    
    // Returns all cell location properties
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var attributes: [UICollectionViewLayoutAttributes] = []
            for section in itemAttributes {
                attributes.append(contentsOf: section.filter(
                    {(includeElement: UICollectionViewLayoutAttributes) -> Bool in
                        return rect.intersects(includeElement.frame)
                }))
            }
            return attributes
    }
    
    //Refresh the layout.
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    func calculateItemsSize() {
        var remainingWidth = collectionView!.frame.width -
            collectionView!.contentInset.left - collectionView!.contentInset.right
        
        var index = viewController.cols.count-1
        while index >= 0 {
            let newItemSize = sizeForItemWithColumnIndex(columnIndex: index,
                                                         remainingWidth: remainingWidth)
            remainingWidth -= newItemSize.width
            let newItemSizeValue = NSValue(cgSize: newItemSize)
            
            itemsSize.insert(newItemSizeValue, at: 0)
            index -= 1
        }
    }
    
    //Calculated dimension
    func sizeForItemWithColumnIndex(columnIndex: Int, remainingWidth: CGFloat) -> CGSize {
        let columnString = viewController.cols[columnIndex]
        
        let size = NSString(string: columnString).size(withAttributes: [
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),
            NSAttributedString.Key.underlineStyle:NSUnderlineStyle.single.rawValue
            ])
        
        //All columns are equally distributed
        let width = remainingWidth/CGFloat(columnIndex+1)
        
        return CGSize(width: ceil(width), height:size.height + 10)
    }
}
