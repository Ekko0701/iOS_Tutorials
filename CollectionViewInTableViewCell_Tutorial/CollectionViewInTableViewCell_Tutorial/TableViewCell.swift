//
//  TableViewCell.swift
//  CollectionViewInTableViewCell_Tutorial

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    static let cellId = "tableViewCell"
    
    let tableLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "추천 음료"
        return label
    }()
    
    var collectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpCollectionView()
        setUpStyle()
        setUpLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.cellId)
        
        collectionView.backgroundColor = .blue
    }
}

extension TableViewCell {
    func setUpStyle() {
        addSubview(tableLabel)
        contentView.addSubview(collectionView) // contentView.addSubview로 해줘야함. https://zeddios.tistory.com/1204
        contentView.backgroundColor = .yellow
    }
    func setUpLayout() {
        tableLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(tableLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
}

//MARK: - CollectionView
extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellId, for: indexPath) as! CollectionViewCell
        
        cell.backgroundColor = .systemGreen
        
        let imageNumber: Int = indexPath.row % 6 + 1
        
        cell.foodImage.image = UIImage(named: "image\(imageNumber)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 10
        let size = CGSize(width: width, height: 50)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did Selected Item At : \(indexPath.row)")
    }
}
