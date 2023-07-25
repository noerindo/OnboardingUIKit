//
//  SwipeViewController.swift
//  OnboardingUIKit
//
//  Created by Indah Nurindo on 24/07/2566 BE.
//

import UIKit


class SwipeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let swipeItems = [
        SwipeItem(
            imageSwipe: "onBoarding1",
            headlineSwipe: " Let's Get Started",
            subheadlineSwipe: "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact."),
        SwipeItem(
            imageSwipe: "onBoarding2",
            headlineSwipe: "Your Onboarding Journey Begins!",
            subheadlineSwipe: "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact."),
        SwipeItem(
            imageSwipe: "onBoarding3",
            headlineSwipe: "Your First Steps to Success",
            subheadlineSwipe: "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact.")
    ]
    
   private let skipButton = UIButton(type: .system)
    private let nextButton = UIButton(type: .system)
    private var pageControl = [UIView]()
    private var indicatorLeadingConstraint: NSLayoutConstraint!
    private var selectedCellIndex = 0
    private let bottomStackView = UIStackView()
//    private let bottomBtnStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configurePageControl()

        indicatorLeadingConstraint = pageControl[0].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100)
        indicatorLeadingConstraint.isActive = true
        
    }    
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("swipeItems",swipeItems.count)
        return swipeItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SwipeCell.reuseIdentifierr, for: indexPath) as! SwipeCell
        let swipeItem = swipeItems[indexPath.item]
        cell.update(image: swipeItem.imageSwipe, headline: swipeItem.headlineSwipe, subheadline: swipeItem.subheadlineSwipe)
        // Update the indicator colors based on the selected cell index
               updateIndicatorColors(for: indexPath.item)
        if indexPath.item == 2 {
            skipButton.isHidden = true
        } else {
            skipButton.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let contentWidth = collectionView.contentSize.width
        let contentOffsetX = scrollView.contentOffset.x
        let collectionViewWidth = collectionView.bounds.width
        let indicatorPosition = (contentOffsetX / contentWidth) * collectionViewWidth
        // Update the indicator's position
        indicatorLeadingConstraint.constant = 100 + indicatorPosition
        
        // Update the indicator colors based on the current selected index
        let currentIndex = Int(round(contentOffsetX / collectionViewWidth))
        if selectedCellIndex != currentIndex {
            selectedCellIndex = currentIndex
            updateIndicatorColors(for: currentIndex)
            
        }
    }
    
    @objc func skipButtonDidTap() {

    }
    
    @objc func nextButtonDidTap() {
        var selectedIndex = selectedCellIndex + 1
        if selectedIndex >= pageControl.count {
            selectedIndex -= 1
        }
        if selectedIndex == selectedCellIndex { return }
        
        selectedCellIndex = selectedIndex
        updateIndicatorColors(for: selectedCellIndex)
        
        collectionView.selectItem(
            at: IndexPath(item: selectedCellIndex, section: 0),
            animated: true,
            scrollPosition: .centeredHorizontally)
    }
    
    func configurePageControl() {
        print("Count: \(swipeItems.count)")
        for lineIndex in 0..<swipeItems.count {
            
            let line = UIView()
            view.addSubview(line)
            pageControl.append(line)
            
            pageControl[0].frame = CGRect(x: 0, y: 0, width: 100, height: 5)
            pageControl[lineIndex].translatesAutoresizingMaskIntoConstraints = false
            pageControl[lineIndex].layer.cornerRadius = 4.0
            NSLayoutConstraint.activate([
                pageControl[lineIndex].bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
                pageControl[lineIndex].widthAnchor.constraint(equalToConstant: 30.5),
                pageControl[lineIndex].heightAnchor.constraint(equalToConstant: 5),
                pageControl[lineIndex].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50+(CGFloat(lineIndex*35))),
            ])
            view.addSubview(pageControl[lineIndex])
           
        }
    }
    
    func updateIndicatorColors(for index: Int) {
        for indexActive in 0..<swipeItems.count {
            pageControl[indexActive].backgroundColor = index == indexActive ? .black : UIColor(named: "pageControl")
        }
      }
    
    func configureBtnBottomStackView() {
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(.systemGray, for: .normal)
        skipButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        skipButton.addTarget(self, action: #selector(skipButtonDidTap), for: .touchUpInside)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(skipButton)
        
        nextButton.setTitle("Next →", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        nextButton.tintColor = .white
        nextButton.backgroundColor = .black
        nextButton.layer.cornerRadius = 15
        nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
//        bottomBtnStackView.addArrangedSubview(skipButton)
//        bottomBtnStackView.addArrangedSubview(nextButton)
//
//        bottomBtnStackView.axis = .horizontal
//               bottomBtnStackView.distribution = .fillEqually
//               bottomBtnStackView.translatesAutoresizingMaskIntoConstraints = false
//
//               view.addSubview(bottomBtnStackView)
    }
    
    func configureViewController() {
        let safeArea = view.safeAreaInsets
        
        view.addSubview(collectionView)
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SwipeCell.self, forCellWithReuseIdentifier: SwipeCell.reuseIdentifierr)

        configureBtnBottomStackView()
        
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30 - safeArea.bottom),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 41),
            
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30 - safeArea.bottom),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -41),
            nextButton.widthAnchor.constraint(equalToConstant: 100),
            nextButton.heightAnchor.constraint(equalToConstant: 40)
//            bottomBtnStackView.heightAnchor.constraint(equalToConstant: 40),
//                    bottomBtnStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                    bottomBtnStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                    bottomBtnStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
          
        ])
    }
    
}
