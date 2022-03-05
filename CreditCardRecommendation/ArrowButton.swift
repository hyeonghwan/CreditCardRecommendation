
import UIKit

class ArrowButton: UIButton {
    var indexPath: IndexPath?
    convenience init( index : IndexPath) {
        self.init()
        self.indexPath = index
    }
}
