//
//  ViewController.swift

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var viewModels: [CollectionViewCellViewModel] = [
        CollectionViewCellViewModel(name: "Red", backgroundColor: .systemRed),
        CollectionViewCellViewModel(name: "Orange", backgroundColor: .systemOrange),
        CollectionViewCellViewModel(name: "Yellow", backgroundColor: .systemYellow),
        CollectionViewCellViewModel(name: "Green", backgroundColor: .systemGreen),
        CollectionViewCellViewModel(name: "Blue", backgroundColor: .systemBlue),
        CollectionViewCellViewModel(name: "Purple", backgroundColor: .systemPurple),
    ]
    
    let cellWidthMultiplier: CGFloat = 0.7
    let cellHeightMultiplier: CGFloat = 0.8
    let minimumLineSpacing: CGFloat = 20
    
    var currentIndex: CGFloat = 0 // 현재 CollectionView의 페이지 인덱스
    
    //  Create UICollectionView
    private let collectionView: UICollectionView = {
        //  Configure Layout
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemTeal
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureCollectionView()
    }

    //  SetUp AutoLayout with SnapKit
    func configureLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo((view.frame.size.height / 5 ) * 3)
            make.top.leading.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureCollectionView() {
        // Attach CollectionView Delegate & DataSource
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Regist Cell
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
    }
}

extension ViewController: UICollectionViewDelegate {
    
    /// ScrollViewWillEndDragging
    /// 드래그를 마칠때 호출되는 메서드
    /// 드래그를 마칠때 ContentOffset을 조절하자.
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // Cell의 너비
        let width: CGFloat = collectionView.frame.size.width * cellWidthMultiplier
        
        // Cell간 간격을 포함한 Cell의 너비
        let cellWidthIncludingSpacing = width + minimumLineSpacing
        
        // 스크롤 정지시 예상되는 위치
        var offset = targetContentOffset.pointee
        
        // 스크롤 정지시 예상되는 x축 위치와 스크롤뷰의 좌측 Inset을 더한 값을
        // Cell간 간격을 포함한 Cell의 너비로 나눈다.
        // 그 값이 index
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        
        // Index 값을 반올림한다.
        var roundedIndex = round(index)
        
        
        /*
        // 추가 1) https://jintaewoo.tistory.com/33
        // 스크롤 방향을 체크해 올림, 내림을 정한다.
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else {
            roundedIndex = ceil(index)
        }
         */
        
        // 추가 2) https://jintaewoo.tistory.com/33
        // 한 페이지씩 스크롤
        if scrollView.contentOffset.x > targetContentOffset.pointee.x {
            roundedIndex = floor(index)
        } else if scrollView.contentOffset.x < targetContentOffset.pointee.x {
            roundedIndex = ceil(index)
        } else {
            roundedIndex = round(index)
        }
        
        if currentIndex > roundedIndex {
            currentIndex -= 1
            roundedIndex = currentIndex
        } else if currentIndex < roundedIndex {
            currentIndex += 1
            roundedIndex = currentIndex
        }
        
        
        // 새로운 OffSet을 설정한다.
        // roundedIndex값에 cellWidthIncludingSpacing값을 곱하고 scrollView의 좌측 Inset만큼 빼준다.
        // (Rounded Index 번째의 Cell의 x축을 알기 위함)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        // Offset 적용
        targetContentOffset.pointee = offset
    }
}

extension ViewController: UICollectionViewDataSource {
    
    /// Number of Section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    /// Non-Optional
    /// NumberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    /// Non-Optional
    /// CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MyCollectionViewCell.identifier,
            for: indexPath
        ) as? MyCollectionViewCell else {
            fatalError()
        }
        
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    /// Cell Size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.frame.size.width * cellWidthMultiplier
        let height: CGFloat = collectionView.frame.size.height * cellHeightMultiplier
        
        let size: CGSize = CGSize(width: width, height: height)
        
        return size
    }
    
    /// MinimumLineSpacing
    /// Cell간 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    /// Inset
    /// Section의 Contents 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        // 첫번째 Cell이 가운데 오도록 설정하자.
        let width: CGFloat = collectionView.frame.size.width * cellWidthMultiplier
        
        let insetX = (view.frame.size.width - width) / 2.0
        
        let inset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        
        return inset
    }
}



