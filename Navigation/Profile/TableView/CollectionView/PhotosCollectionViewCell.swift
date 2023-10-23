//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Sergey on 02.07.2023.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        
        static let verticalSpacing: CGFloat = 8.0
        static let horizontalPadding: CGFloat = 8.0
        static let profileDescriptionVerticalPadding: CGFloat = 8.0
    }
    
    // MARK: - Subviews
    
    lazy var photoGalleryView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        setupSubviews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func setupView() {
        contentView.clipsToBounds = true
    }
    
    private func setupSubviews() {
        contentView.addSubview(photoGalleryView)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            photoGalleryView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoGalleryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoGalleryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoGalleryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            photoGalleryView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        ])
    }
    // MARK: - Public
    
    func setup(
        with photo: PhotoGallery
    ){
        photoGalleryView.image = UIImage(named: photo.imageName)
    }
}
