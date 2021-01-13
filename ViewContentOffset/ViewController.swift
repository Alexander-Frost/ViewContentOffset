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
        guard let firstScrollviewView = items.first else {return}
        let screenWidth = UIScreen.main.bounds.width
        
        // This should return a value between 0 and 1
        let xOffset = firstScrollviewView.convert(CGPoint(x: firstScrollviewView.frame.minX, y: 0), to: view).x
        var percentViewMovedOnVisibleScreen: CGFloat = xOffset / screenWidth
        
        let minValue: CGFloat = 0
        let maxValue: CGFloat = 1
        percentViewMovedOnVisibleScreen = max(min(percentViewMovedOnVisibleScreen, maxValue), minValue)
        
        // RETURN value between 0 and 1
        print("HERE x: ", percentViewMovedOnVisibleScreen)
    }
}

