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
    private let colors: [UIColor] = [.systemBlue, .systemOrange, .cyan, .magenta]
    
    // MARK: - Outlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup UI
    
    private func setupUI() {
        for i in 0...8 {
            let tabView = UIView()
            tabView.tag = i
            tabView.backgroundColor = colors.itemAt(i % colors.count)
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
        scrollView.addSubview(tabView)
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        items.enumerated().forEach { (index, tabView) in
            let screenWidth = UIScreen.main.bounds.width
            
            // This returns a value between 0 and 1 depending on the location of the tab view within the visible screen
            let xOffset = scrollView.convert(CGPoint(x: tabView.frame.minX, y: 0), to: view).x
            let percentViewMovedOnVisibleScreen: CGFloat = xOffset / screenWidth
            
            // Spacing - NOT CORRECT
            let someSpacingAmount: CGFloat = 80
            tabView.frame.origin.x = CGFloat(index) * percentViewMovedOnVisibleScreen * someSpacingAmount
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
