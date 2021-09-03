//
//  CardViewController.swift
//  Animation Controller
//
//  Created by 沈維庭 on 2021/9/2.
//

import UIKit

class CardViewController: UIViewController {

    private var card: Card
    private var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 91, width: UIScreen.main.bounds.width, height: 300))
        return imageView
    }()
    
    init(_ card: Card) {
        self.card = card
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.setCoverImageView()
    }
    
    private func setCoverImageView() {
//        self.imageView = UIImageView()
        imageView.image = card.image
//        imageView.isHidden = true
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        self.view.addSubview(imageView)
        [imageView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
         imageView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
         imageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
         imageView.heightAnchor.constraint(equalToConstant: 300)].forEach { $0.isActive = true }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardViewController: animTransitionable {
    var coverImageView: UIImageView {
        return self.imageView
    }
    
    var backgroundColor: UIView {
        return self.view
    }
    
    var cellBackground: UIView {
        return UIView()
    }
}
