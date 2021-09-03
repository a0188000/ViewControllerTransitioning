//
//  ViewController.swift
//  Animation Controller
//
//  Created by 沈維庭 on 2021/9/2.
//

import UIKit

protocol animTransitionable {
    var coverImageView: UIImageView { get }
    var backgroundColor: UIView { get }
    var cellBackground: UIView { get }
}

class ViewController: UIViewController, animTransitionable {
    
    var coverImageView: UIImageView {
        guard let cell = self.collectionView.cellForItem(at: self.selectedIndexPath) as? CardCell else { return UIImageView() }
        return cell.coverImageView
    }
    
    var backgroundColor: UIView {
        return self.view
    }
    
    var cellBackground: UIView {
        guard let cell = self.collectionView.cellForItem(at: self.selectedIndexPath) as? CardCell else { return UIView() }
        return cell.cellBackgroundView
    }
    
    let transition = TransitionCoordinator()
    
    private var collectionView: UICollectionView!
    private var selectedIndexPath: IndexPath!
    
    private var dataSource = [Card(country: "", image: UIImage(named: "1")),
                              Card(country: "", image: UIImage(named: "2")),
                              Card(country: "", image: UIImage(named: "3")),
                              Card(country: "", image: UIImage(named: "4")),
                              Card(country: "", image: UIImage(named: "5"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.setUI()
    }

    private func setUI() {
        self.setCollectionView()
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        self.collectionView.backgroundColor = .white
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(CardCell.self, forCellWithReuseIdentifier: "Card")
        self.view.addSubview(collectionView)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath) as? CardCell else { return UICollectionViewCell() }
        cell.setData(dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
        self.navigationController?.delegate = self.transition
        self.navigationController?.pushViewController(CardViewController(dataSource[indexPath.row]), animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 16 * 3) / 2
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
