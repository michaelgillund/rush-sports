//
//  PageView.swift
//  Rush
//
//  Created by Michael Gillund on 10/18/22.
//

import SwiftUI

struct PageView<Page: View>: UIViewControllerRepresentable {
    
    var pages: [Page]
    @Binding var currentPage: Int
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.view.backgroundColor = .systemGroupedBackground
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

        return pageViewController
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        var direction: UIPageViewController.NavigationDirection = .forward
        var animated: Bool = false
        
        if let previousViewController = pageViewController.viewControllers?.first,
            let previousPage = context.coordinator.controllers.firstIndex(of: previousViewController) {
            direction = (currentPage >= previousPage) ? .forward : .reverse
            animated = (currentPage != previousPage)
        }
        
        let currentViewController = context.coordinator.controllers[currentPage]
        pageViewController.setViewControllers([currentViewController], direction: direction, animated: animated)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self, pages: pages)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        
        var parent: PageView
        var controllers: [UIViewController]

        init(parent: PageView, pages: [Page]) {
            self.parent = parent
            self.controllers = pages.map({
                let hostingController = UIHostingController(rootView: $0)
                hostingController.view.backgroundColor = .systemGroupedBackground
                return hostingController
            })
            self.controllers.forEach {
                $0.view.backgroundColor = .systemGroupedBackground
            }
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return nil
            }
            return controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return nil
            }
            return controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
                let currentViewController = pageViewController.viewControllers?.first,
                let currentIndex = controllers.firstIndex(of: currentViewController)
            {
                parent.currentPage = currentIndex
            }
        }
    }
}
