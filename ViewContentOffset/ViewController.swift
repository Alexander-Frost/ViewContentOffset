//
//  ViewController.swift
//  ViewContentOffset
//
//  Created by Alex Frost on 1/12/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    private var items: [UIView] = []
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup UI
    
    private func setupUI() {
        for i in 0...3 {
            let tabView = UIView()
            tabView.tag = i
            items.append(tabView)
        }
        
        // Add views to scrollview
        items.forEach { (tabView) in
            addViewToScrollview(tabView: tabView)
        }
        
        // Scrollview
        scrollView.backgroundColor = .systemPink
        scrollView.delegate = self
        
        // Set scrollview content offset
        let contentSizeWidth: CGFloat = view.frame.width * 2
        let contentSize = CGSize(width: contentSizeWidth, height: view.frame.height)
        scrollView.contentSize = contentSize
    }
    
    private func addViewToScrollview(tabView: UIView) {
        let horizontalSpacing: CGFloat = 200
        let x: CGFloat = horizontalSpacing * CGFloat(tabView.tag)
        tabView.frame = CGRect(x: x, y: 0, width: 150, height: 400)
        tabView.center.y = scrollView.center.y
        tabView.backgroundColor = .orange
        scrollView.addSubview(tabView)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        items.forEach { (tabView) in
            let screenWidth = UIScreen.main.bounds.width
            
            // This should return a value between 0 and 1
            let xOffset = scrollView.convert(CGPoint(x: tabView.frame.minX, y: 0), to: view).x
            var percentViewMovedOnVisibleScreen: CGFloat = xOffset / screenWidth
            
            let minValue: CGFloat = 0.6
            let maxValue: CGFloat = 1
            percentViewMovedOnVisibleScreen =  minValue + (maxValue - minValue) * percentViewMovedOnVisibleScreen
            
            let scaleSize = CGAffineTransform(scaleX: percentViewMovedOnVisibleScreen, y: percentViewMovedOnVisibleScreen)
            tabView.transform = scaleSize
        }
    }
}

extension Array {
    /// Safe way to get item in an array without crashing app when going out of bounds
    func itemAt(_ index: Int) -> Element? {
        if self.indices.contains(index) {
            return self[index]
        } else {
            return nil
        }
    }
    
}
