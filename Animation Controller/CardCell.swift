//
//  CardCell.swift
//  Animation Controller
//
//  Created by 沈維庭 on 2021/9/2.
//

import UIKit

struct Card {
    var country: String
    var image: UIImage?
}

class CardCell: UICollectionViewCell {
    
    private(set) var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) var cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.contentView.addSubview(cellBackgroundView)
        self.cellBackgroundView.addSubview(coverImageView)
        [cellBackgroundView.leftAnchor.constraint(equalTo: self.leftAnchor),
         cellBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
         cellBackgroundView.rightAnchor.constraint(equalTo: self.rightAnchor),
         cellBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)].forEach { $0.isActive = true }
        [coverImageView.leftAnchor.constraint(equalTo: cellBackgroundView.leftAnchor),
         coverImageView.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor),
         coverImageView.rightAnchor.constraint(equalTo: cellBackgroundView.rightAnchor),
         coverImageView.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor)].forEach { $0.isActive = true }
    }
    
    func setData(_ data: Card) {
        self.coverImageView.image = data.image
    }
}
