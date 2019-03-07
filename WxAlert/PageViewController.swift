//
//  PageViewController.swift
//  WxAlert
//
//  Created by macbook on 2/20/19.
//  Copyright © 2019 Jaminya. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    // Empty array of views
    var pages = Pages()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        if let firstVC = pages.array.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
} //class

extension PageViewController: UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.array.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        
        if previousIndex < 0 {
            return nil
        } else {
            return pages.array[previousIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.array.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        
        if nextIndex < pages.array.count {
            return pages.array[nextIndex]
        } else {
            return nil
        }
    }
}
