import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.backgroundColor    = backgroundColor
    }
   
    
    private func configure() {
        layer.cornerRadius      = 10
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setup(backgroundColor: UIColor, title: String) {
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
    }
}


