//
//  TAWindowShower.swift
//  Target-App
//
//  Created by Alex Zimin on 10/04/15.
//  Copyright (c) 2015 Alex & Vadim. All rights reserved.
//

import UIKit

@objc
enum WindowAnimationState: Int {
    case Open, Close
}

@objc
protocol TAWindowShowerAnimationDataSource: class, NSObjectProtocol {
    optional func showerWindowRequstAnimationForWindow(window: UIWindow, state: WindowAnimationState) -> (()->())?
    optional func showerWindowRequstAnimationForViewController(viewController: UIViewController, state: WindowAnimationState) -> (()->())?
}

class TAWindowShower: NSObject {
    static let sharedInstance = TAWindowShower()
    
    var windowsStack: [UIWindow] = []
    var windowLevel: CGFloat = UIWindowLevelNormal
    
    var isPresented: Bool = false
    
    private override init() {
        super.init()
    }
    
    // MARK: - Helpers
    
    private func rootViewControllerForWindow(window: UIWindow) -> UIViewController {
        return window.rootViewController ?? UIViewController()
    }
    
    private var contentWindow: UIWindow {
        return windowsStack.last ?? UIWindow()
    }
    
    private var rootViewController: UIViewController {
        return windowsStack.last?.rootViewController ?? UIViewController()
    }
    
    // MARK: - Queue
    
    private enum ActionsQueue {
        case Open(value: OpenQueue)
        case Close
    }
    
    private class OpenQueue {
        let viewController: UIViewController
        let animationDataSource: TAWindowShowerAnimationDataSource?
        
        init(viewController: UIViewController, animationDataSource: TAWindowShowerAnimationDataSource?) {
            self.viewController = viewController
            self.animationDataSource = animationDataSource
        }
    }
    
    private var queue: [ActionsQueue] = []
    private var queueSize: Int {
        return queue.count
    }
    
    // MARK: - Present
    
    private var animationDataSources: [TAWindowShowerAnimationDataSource?] = []
    private var oldWindow: UIWindow?
    
    private func complition() {
        queue.removeAtIndex(0)
        
        if let action = queue.first {
            switch action {
            case let .Open(value: openQueue):
                presentViewController(openQueue.viewController, animationDataSource: openQueue.animationDataSource, skip: true)
            case .Close:
                closeTopWindow(true)
            }
        }
    }
    
    func presentViewController(viewController: UIViewController, animationDataSource: TAWindowShowerAnimationDataSource?) {
        presentViewController(viewController, animationDataSource: animationDataSource, skip: false)
    }
    
    private func presentViewController(viewController: UIViewController, animationDataSource: TAWindowShowerAnimationDataSource?, skip: Bool) {
        
        if !skip {
            queue.append(ActionsQueue.Open(value: OpenQueue(viewController: viewController, animationDataSource: animationDataSource)))
            if queueSize > 1 {
                return
            }
        }
        
        isPresented = true
        
        animationDataSources.append(animationDataSource)
        
        if windowsStack.count == 0 {
            oldWindow = UIApplication.sharedApplication().keyWindow
        }
        
        windowLevel += 0.1
        
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.backgroundColor = UIColor.clearColor()
        window.windowLevel = windowLevel
        
        window.makeKeyAndVisible()
        window.rootViewController = viewController
        window.rootViewController?.view.frame = window.bounds
        
        windowsStack.append(window)
        changeWindowState(.Open)
    }
    
    func closeTopWindow() {
        closeTopWindow(false)
    }
    
    private func closeTopWindow(skip: Bool) {
        if !skip {
            queue.append(.Close)
            if queueSize > 1 {
                return
            }
        }
        
        changeWindowState(.Close)
    }
    
    private func changeWindowState(state: WindowAnimationState) {
        
        let animationDataSource = animationDataSources.last!
        
        let viewContollerAnimation = animationDataSource?.showerWindowRequstAnimationForViewController?(rootViewController, state: state)
        let windowAnimation = animationDataSource?.showerWindowRequstAnimationForWindow?(contentWindow, state: state)
        
        if state == .Open && viewContollerAnimation == nil {
            rootViewController.view.center = CGPoint(x: rootViewController.view.center.x, y: rootViewController.view.center.y + contentWindow.bounds.height)
        }
        
        if state == .Open && windowAnimation == nil {
            contentWindow.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
        }
        
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            
            if let animation = viewContollerAnimation {
                animation()
            } else {
                self.playViewControllerAnimation(state)
            }
            
            if let animation = windowAnimation {
                animation()
            } else {
                self.playWindowAnimation(state)
            }
            
            }) { (isFinished) -> Void in
                if state == .Close {
                    self.animationDataSources.removeLast()
                    self.windowsStack.last?.rootViewController = nil
                    self.windowsStack.removeLast()
                    self.windowLevel -= 0.1
                    
                    if self.windowsStack.count == 0 {
                        self.isPresented = false
                        self.oldWindow?.makeKeyAndVisible()
                    } else {
                        self.windowsStack.last?.makeKeyAndVisible()
                    }
                }
                
                self.complition()
        }
    }
    
    private func playWindowAnimation(state: WindowAnimationState) {
        if state == .Open {
            contentWindow.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
        } else {
            contentWindow.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.0)
        }
    }
    
    private func playViewControllerAnimation(state: WindowAnimationState) {
        if state == .Open {
            rootViewController.view.center = CGPoint(x: rootViewController.view.center.x, y: rootViewController.view.center.y - contentWindow.bounds.height)
        } else {
            rootViewController.view.center = CGPoint(x: rootViewController.view.center.x, y: rootViewController.view.center.y + contentWindow.bounds.height)
        }
    }
}
