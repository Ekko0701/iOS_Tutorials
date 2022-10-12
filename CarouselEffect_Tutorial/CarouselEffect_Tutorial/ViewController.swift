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
    var previousIndex = 0
    
    //  Create UICollectionView
    private let collectionView: UICollectionView = {
        //  Configure Layout
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        
        configureLayout()
        configureCollectionView()
        
        pagingTimer()
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
    
    /// Scroll View Did Scroll
    /// Add Hight Effect
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Cell의 너비
        let width: CGFloat = collectionView.frame.size.width * cellWidthMultiplier
        
        // Cell간 간격을 포함한 Cell의 너비
        let cellWidthIncludingSpacing = width + minimumLineSpacing
        
        let offsetX = collectionView.contentOffset.x
        let index = (offsetX + collectionView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        let indexPath = IndexPath(item: Int(roundedIndex), section: 0)
        
        // 1번 방법
        // 작동 but 비정상
        if let cell = collectionView.cellForItem(at: indexPath) {
            applyAnimation(cell: cell)
        }
        
        if Int(roundedIndex) != previousIndex {
            let preIndexPath = IndexPath(item: previousIndex, section: 0)
            if let preCell = collectionView.cellForItem(at: preIndexPath) {
                removeAnimation(cell: preCell)
            }
            previousIndex = indexPath.item
        }
    }
    
    /// willDisplay
    /// 첫번째 Item 크기 조절
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        if indexPath.row == 0 {
            applyAnimation(cell: cell)
        }
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
        
        // 첫번째 Cell이 중앙에 오도록 설정하자.
        let width: CGFloat = collectionView.frame.size.width * cellWidthMultiplier
        
        let insetX = (view.frame.size.width - width) / 2.0
        
        let inset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        
        return inset
    }
}

//UICollectionView Auto Scroll
extension ViewController {
    func pagingTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { Timer in
            self.moveToNextPage()
        }
    }
    
    func moveToNextPage() {
        // Cell의 너비
        let width: CGFloat = collectionView.frame.size.width * cellWidthMultiplier
        let height: CGFloat = collectionView.frame.size.height * cellHeightMultiplier
    
        // Cell간 간격을 포함한 Cell의 너비
        let cellWidthIncludingSpacing = width + minimumLineSpacing * 2
        
        // Inset
        let insetX = (view.frame.size.width - width) / 2.0
        
        // ContentOffset: 현재 스크롤 위치
        let contentOffset = collectionView.contentOffset
        
        // if - 마지막 페이지가 아닌 경우
        if Int(currentIndex) != viewModels.count - 1 {
            collectionView.scrollRectToVisible(CGRectMake(contentOffset.x + cellWidthIncludingSpacing + insetX, contentOffset.y, cellWidthIncludingSpacing, height ), animated: true)
            
            currentIndex += 1
        }
        
        // else - 마지막 페이지인 경우
        else {
            collectionView.scrollRectToVisible(CGRectMake( 0, contentOffset.y, cellWidthIncludingSpacing, height), animated: true)
            
            currentIndex = 0
        }
    }
}

// Focus Cell Animations
extension ViewController {
    func applyAnimation(cell: UICollectionViewCell) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                cell.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        },
            completion: nil
        )
    }
    
    func removeAnimation(cell: UICollectionViewCell) {
        UIView.animate(
                    withDuration: 0.4,
                    delay: 0,
                    options: .curveEaseOut,
                    animations: {
                        cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                },
                    completion: nil)
    }
}

