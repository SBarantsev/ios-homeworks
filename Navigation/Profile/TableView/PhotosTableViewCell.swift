//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Sergey on 28.06.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    
    fileprivate lazy var photos: [PhotoGallery] = PhotoGallery.make()
    
    private enum CellReuseID: String {
        case photoGalleryCell = "PhotoGalleryViewCell_ReuseID"
    }
    
    let headerLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Photos".localize
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let symbolView: UIImageView = {
        let symbol = UIImageView()
        symbol.image = UIImage(systemName: "arrow.right")
        symbol.tintColor = .black
        symbol.translatesAutoresizingMaskIntoConstraints = false
        
        return symbol
    }()
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground

        collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: CellReuseID.photoGalleryCell.rawValue
        )
        
        return collectionView
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .value1,
            reuseIdentifier: reuseIdentifier
        )
        
        tuneView()
        setupSubviews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        isHidden = false
        isSelected = false
        isHighlighted = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        guard let view = selectedBackgroundView else {
            return
        }

        contentView.insertSubview(view, at: 0)
        selectedBackgroundView?.isHidden = !selected
    }
    
    // MARK: - Private
    
    private func tuneView() {
        backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground
        textLabel?.backgroundColor = .clear
        
        accessoryView = nil
        accessoryType = .disclosureIndicator
        
        selectionStyle = .gray
        let selectedView = UIView()
        selectedView.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        
        contentView.addSubview(headerLabel)
        contentView.addSubview(symbolView)
        contentView.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupLayouts() {
                
        NSLayoutConstraint.activate([
            
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            symbolView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            symbolView.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            collectionView.heightAnchor.constraint(equalToConstant: 90),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
    }
}

// MARK: - Extension

extension PhotosTableViewCell: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        photos.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CellReuseID.photoGalleryCell.rawValue,
            for: indexPath) as! PhotosCollectionViewCell
        
        let photo = UIImage(named: photos[indexPath.row].imageName)
        cell.setup(with: photo!)
        cell.photoGalleryView.clipsToBounds = true
        cell.photoGalleryView.layer.cornerRadius = 6
        
        return cell
    }
}

extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (contentView.bounds.width - LayoutConstant.spacing * 3 - 24) / 4
        let hight = width
        
        return CGSize(width: width, height: hight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        LayoutConstant.spacing
    }
}

