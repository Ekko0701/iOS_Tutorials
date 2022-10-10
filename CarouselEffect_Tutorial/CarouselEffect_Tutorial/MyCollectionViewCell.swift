//
//  MyCollectionViewCell.swift
//

import Foundation
import UIKit



class MyCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //  Congifure Label
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 6
        contentView.layer.borderWidth = 1.5
        contentView.layer.borderColor = UIColor.quaternaryLabel.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds    // label의 프레임을 cell의 바운드와 같게 조정
    }
    
    func configure(with viewModel: CollectionViewCellViewModel) {
        contentView.backgroundColor = viewModel.backgroundColor
        label.text = viewModel.name
    }
}


