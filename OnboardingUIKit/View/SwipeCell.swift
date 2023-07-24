//
//  SwipeCell.swift
//  OnboardingUIKit
//
//  Created by Indah Nurindo on 24/07/2566 BE.
//

import UIKit

class SwipeCell: UICollectionViewCell {
    static let reuseIdentifierr = "SwipeCell"
    
    let imageView = UIImageView()
    let headlineLabel = UILabel()
    let subHeadlineLabel = UILabel()
    let descriptionStackView = UIStackView()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        configure()
     }

     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    func update(image: String, headline: String, subheadline: String) {
        imageView.image = UIImage(named: image)
        headlineLabel.text = headline
        subHeadlineLabel.text = subheadline
    }
    
    func configure() {
        backgroundColor = .systemBackground
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)

        headlineLabel.textAlignment = .left
        headlineLabel.textColor = .label
        headlineLabel.numberOfLines = 0
        headlineLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        subHeadlineLabel.textAlignment = .left
        subHeadlineLabel.font = UIFont.systemFont(ofSize: 17)
        subHeadlineLabel.textColor = .secondaryLabel
        subHeadlineLabel.numberOfLines = 0
        descriptionStackView.addArrangedSubview(headlineLabel)
        descriptionStackView.addArrangedSubview(subHeadlineLabel)
        
        descriptionStackView.axis = .vertical
        descriptionStackView.spacing = 10
        descriptionStackView.alignment = .leading
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(descriptionStackView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 390),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalToConstant: 460),
            
            descriptionStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            descriptionStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            descriptionStackView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
}
