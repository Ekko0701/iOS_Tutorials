//
//  CollectionViewCell.swift
//  CollectionViewInTableViewCell_Tutorial
//
//  Created by Ekko on 2022/07/20.
//

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    // Reuse Identifier
    static let cellId = "collectionViewCell"
    
    // Set Cell Elements
    let foodImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image1")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionViewCell {
    func setUpCell() {
        addSubview(foodImage)
    }
    
    func setUpLayout() {
        
        // Autolayout with SnapKit
        
        foodImage.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
