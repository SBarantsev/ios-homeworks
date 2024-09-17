//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Sergey on 29.06.2023.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    let imageProcessor = ImageProcessor()
    
    //    let imagePublisherFasade = ImagePublisherFacade()
    //    var newPhoto: [UIImage] = []
    
    fileprivate lazy var photos: [PhotoGallery] = PhotoGallery.make()
    var userPhotoAlbum = PhotoGallery.makeUserAlbum(from: PhotoGallery.make())
    
    private enum CellReuseID: String {
        case photoGalleryCell = "PhotoGalleryViewCell_ReuseID"
    }
    
    // MARK: - Subviews
    
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
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
    
    // MARK: - LifeStyle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupSubviews()
        setupLayouts()
        
        //        imagePublisherFasade.subscribe(self)
        //        imagePublisherFasade.addImagesWithTimer(
        //            time: 0.5,
        //            repeat: 20,
        //            userImages: userPhotoAlbum
        //        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //        imagePublisherFasade.removeSubscription(for: self)
        //        imagePublisherFasade.rechargeImageLibrary()
        tabBarController?.tabBar.isHidden = false
        
        print("Подписка отменена")
    }
    
    // MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        title = "Photo Gallery".localize
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "paintbrush.fill"), style: .plain, target: self, action: #selector(setupFilters))
    }
    
    private func processImage() {
        let startTime = NSDate()
        
        imageProcessor.processImagesOnThread(
            sourceImages: userPhotoAlbum,
            filter: .colorInvert,
            qos: .utility) {images in
                DispatchQueue.main.async {
                    self.userPhotoAlbum = []
                    for image in images {
                        guard let image = image else {return}
                        self.userPhotoAlbum.append(UIImage(cgImage: image))
                    }
                    
                    let finishTime = NSDate()
                    
                    let timer = finishTime.timeIntervalSince(startTime as Date)
                    print("Время выполнения \(timer)")
                    self.collectionView.reloadData()
                }
            }
    }
    
    @objc private func setupFilters() {
        processImage()
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupLayouts() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 8.0
    }
}

// MARK: - Extension

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        //        newPhoto.count
        userPhotoAlbum.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CellReuseID.photoGalleryCell.rawValue,
            for: indexPath) as! PhotosCollectionViewCell
        //        guard let user = testUserServise.checkUser(login: testUserServise.user.login) else {return}
        //        let photo = newPhoto[indexPath.row]
        let photo = userPhotoAlbum[indexPath.row]
        cell.setup(with: photo)
        cell.photoGalleryView.clipsToBounds = false
        
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(
        for width: CGFloat,
        spacing: CGFloat
    ) -> CGFloat {
        let itemsInRow: CGFloat = 3
        
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = itemWidth(
            for: view.frame.width,
            spacing: LayoutConstant.spacing
        )
        let hight = width
        
        return CGSize(width: width, height: hight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: LayoutConstant.spacing,
            left: LayoutConstant.spacing,
            bottom: LayoutConstant.spacing,
            right: LayoutConstant.spacing
        )
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        LayoutConstant.spacing
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        LayoutConstant.spacing
    }
}
