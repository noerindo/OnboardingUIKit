//
//  SwipeViewController.swift
//  OnboardingUIKit
//
//  Created by Indah Nurindo on 24/07/2566 BE.
//

import UIKit

class SwipeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let swipeItems = [SwipeItem(imageSwipe: "onBoarding1", headlineSwipe: " Let's Get Started", subheadlineSwipe: "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact."), SwipeItem(imageSwipe: "onBoarding2", headlineSwipe: "Your Onboarding Journey Begins!", subheadlineSwipe: "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact."), SwipeItem(imageSwipe: "onBoarding3", headlineSwipe: "Your First Steps to Success", subheadlineSwipe: "Our goal is to ensure that you have everything you need to feel comfortable, confident, and ready to make an impact.")]
    
    let skipButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    
    let pageControl = UIPageControl()
    let bottomStackView = UIStackView()
     let bottomBtnStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
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
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    @objc func skipButtonDidTap() {
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControl.currentPage = prevIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func nextButtonDidTap() {
        let nextIndex = min(pageControl.currentPage + 1, swipeItems.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func configureBottomStackView() {
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(.systemGray, for: .normal)
        skipButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        skipButton.addTarget(self, action: #selector(skipButtonDidTap), for: .touchUpInside)
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = swipeItems.count
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .systemGray
        
        nextButton.setTitle("Next →", for: .normal)
        nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        nextButton.tintColor = .white
        nextButton.backgroundColor = .black
        nextButton.layer.cornerRadius = 15
        nextButton.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        
       
                
        bottomBtnStackView.addArrangedSubview(skipButton)
//        bottomBtnStackView.addArrangedSubview(pageControl)
        bottomBtnStackView.addArrangedSubview(nextButton)

        
        bottomBtnStackView.axis = .horizontal
        bottomBtnStackView.distribution = .fillEqually
        bottomBtnStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomBtnStackView)

//        bottomStackView.addArrangedSubview(pageControl)
//        bottomStackView.addArrangedSubview(bottomStackView)
//        bottomStackView.axis = .vertical
//        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(bottomStackView)
        
    }
    
    func configureViewController() {
        view.addSubview(collectionView)
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SwipeCell.self, forCellWithReuseIdentifier: SwipeCell.reuseIdentifierr)
        view.addSubview(pageControl)
        
        configureBottomStackView()
        
        NSLayoutConstraint.activate([
            bottomBtnStackView.heightAnchor.constraint(equalToConstant: 40),
            bottomBtnStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomBtnStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomBtnStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
