//
//  ViewController.swift
//  CollectionView_Programmatically_Tutorial


import UIKit
import SnapKit

class ViewController: UIViewController {

    var collectionView: UICollectionView!
    var data = ["Goulash", "Maple Syrup", "Nasi Goreng", "Paella", "Pasta", "Spring rolls","Goulash", "Maple Syrup", "Nasi Goreng", "Paella", "Pasta", "Spring rolls","Goulash", "Maple Syrup", "Nasi Goreng", "Paella", "Pasta", "Spring rolls"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setUpView()
        setUpLayout()
    }
}

extension ViewController {
    
    func setUpCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal // Scroll 방향 설정
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // Delegate, DataSource, Register Cell
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.cellId)
        
        //Background Color
        collectionView.backgroundColor = .blue
    }
    
    func setUpView() {
        view.addSubview(collectionView)
    }
    
    func setUpLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(160)
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did Selected Item At : \(indexPath.row)")
    }
}

extension ViewController: UICollectionViewDataSource {
    // Section의 Item 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    // cell 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellId, for: indexPath) as! CollectionViewCell
        cell.backgroundColor = .systemGreen
        
        let imageNumber: Int = indexPath.row % 6 + 1
        
        cell.foodImage.image = UIImage(named: "image\(imageNumber)")
        cell.foodLabel.text = data[indexPath.row]
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 200)
    }
}
