//
//  BaseTableViewCell.swift
//  Navigation
//
//  Created by Sergey on 27.05.2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    private let headingNews: UILabel = {
        
        let headingLabel = UILabel()
        
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        headingLabel.font = .systemFont(ofSize: 20, weight: .bold)
        headingLabel.textColor = .black
        headingLabel.numberOfLines = 2
        
        return headingLabel
    }()
    
    private let newsImage: UIImageView = {

        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "Avatar")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        
        return imageView
    }()
    
    private let descriptionNews: UILabel = {
        
        let textLabel = UILabel()
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.textColor = .systemGray
        
        return textLabel
    }()
    
    private let likes: UILabel = {
        
        let textLabel = UILabel()
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = .boldSystemFont(ofSize: 16)
        textLabel.textColor = .black
        
        return textLabel
    }()
    
    private let views: UILabel = {
        
        let textLabel = UILabel()
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .right
        textLabel.font = .boldSystemFont(ofSize: 16)
        textLabel.textColor = .black
        
        return textLabel
    }()
    
    // MARK: - Lyfecycle
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(
            style: .value1,
            reuseIdentifier: reuseIdentifier
        )
        
        tuneView()
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
        backgroundColor = .tertiarySystemBackground
        contentView.backgroundColor = .tertiarySystemBackground
        textLabel?.backgroundColor = .clear
        
        accessoryView = nil
        accessoryType = .disclosureIndicator
        
        selectionStyle = .gray
        let selectedView = UIView()
        selectedView.backgroundColor = .systemGray

        contentView.addSubview(headingNews)
        contentView.addSubview(newsImage)
        contentView.addSubview(descriptionNews)
        contentView.addSubview(likes)
        contentView.addSubview(views)
        
        NSLayoutConstraint.activate([
            
            headingNews.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            headingNews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headingNews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            newsImage.topAnchor.constraint(equalTo: headingNews.bottomAnchor, constant: 12),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImage.heightAnchor.constraint(equalTo: newsImage.widthAnchor, multiplier: 1),
            
            descriptionNews.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 16),
            descriptionNews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionNews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likes.topAnchor.constraint(equalTo: descriptionNews.bottomAnchor, constant: 16),
            likes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likes.widthAnchor.constraint(equalToConstant: 100),
            likes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            views.topAnchor.constraint(equalTo: descriptionNews.bottomAnchor, constant: 16),
            views.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            views.widthAnchor.constraint(equalToConstant: 100),
            views.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    // MARK: - Public
    
    func update(_ model: Post) {
        headingNews.text = model.author
        newsImage.image = UIImage(named: model.image)
        descriptionNews.text = model.description
        likes.text = "Likes: " + String(model.likes)
        views.text = "Views: " + String(model.views)
    }
}
