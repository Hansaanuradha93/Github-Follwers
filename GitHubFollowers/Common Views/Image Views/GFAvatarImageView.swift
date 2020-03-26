import UIKit

class GFAvatarImageView: UIImageView {
    
    // MARK: - Properties
    private let placeholderImage = Images.placeHolder
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Methods
extension GFAvatarImageView {
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromUrl url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self          = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
}
