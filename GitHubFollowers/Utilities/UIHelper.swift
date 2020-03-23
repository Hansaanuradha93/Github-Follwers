import UIKit

struct UIHelper {
    
    static func createCollectionViewFlowLayout(in view: UIView, for columns: CGFloat) -> UICollectionViewFlowLayout {
        let collectionViewWidth                 = view.bounds.width
        let padding: CGFloat                    = 12
        let minimumInterItemSpacing: CGFloat    = 10
        let spaceBetweenCells                   = minimumInterItemSpacing * (columns - 1)
        let adjustedWidth                       = collectionViewWidth - spaceBetweenCells - padding * 2
        let width: CGFloat                      = floor(adjustedWidth / columns)
        let height: CGFloat                     = width + 40
        
        let flowLayout                          = UICollectionViewFlowLayout()
        flowLayout.sectionInset                 = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                     = CGSize(width: width, height: height)
        
        return flowLayout
    }
}
