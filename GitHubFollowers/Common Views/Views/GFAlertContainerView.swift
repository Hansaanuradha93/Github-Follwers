import UIKit

class GFAlertContainerView: UIView {

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Private methods
extension GFAlertContainerView {
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor     = .systemBackground
        layer.cornerRadius  = 16
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.white.cgColor
        
    }
}
