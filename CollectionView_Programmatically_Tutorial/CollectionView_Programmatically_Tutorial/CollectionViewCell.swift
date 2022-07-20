//
//  CollectionViewCell.swift
//  CollectionView_Programmatically_Tutorial

import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    // Reuse Identifier
    static let cellId = "CollectionCellId"
    
    // Set Cell Elements
    let foodImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image1")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let foodLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Goulash"
        label.textAlignment = .center
        return label
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
        addSubview(foodLabel)
    }
    
    func setUpLayout() {
        
        // Autolayout with SnapKit
        
        foodImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-32)
            make.trailing.equalToSuperview().offset(-32)
        }
        foodLabel.snp.makeConstraints { make in
            make.top.equalTo(foodImage.snp.bottom).offset(-16)
            make.leading.trailing.equalTo(foodImage)
            
        }
    }
}
