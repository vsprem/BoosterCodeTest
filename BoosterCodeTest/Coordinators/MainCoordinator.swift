//
//  MainCoordinator.swift
//  BoosterCodeTest
//
//  Created by Vlatko Šprem on 29.10.2021..
//

import UIKit
import CoreLocation

class MainCoordinator {
    private var navigationController: UINavigationController
    
    private var mainViewController: MainViewController? {
        let mainViewController = MainViewController.instantiate(fromStoryboard: .main)
        mainViewController?.viewModel = MainViewModel(delegate: self)
        return mainViewController
    }
    
    required public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        setupWindow()
    }
    
    public func setupWindow() {
        let appDelegate = AppUtility.appDelegate
        appDelegate?.window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = appDelegate?.window,
           let mainViewController = mainViewController {
            window.rootViewController = navigationController
            navigationController.setViewControllers([mainViewController], animated: false)
            window.makeKeyAndVisible()
        }
    }
}

extension MainCoordinator: MainCoordinatorDelegate {
    func didTapOrder(data: OrderedData) {
        if let orderedViewController = OrderedViewController.instantiate(fromStoryboard: .main) {
            orderedViewController.viewModel = OrderedViewModel(orderedData: data, delegate: self)
            navigationController.pushViewController(orderedViewController, animated: true)
        }
    }
    
    func didTapMainNext(fuelData: FuelData, location: CLLocationCoordinate2D) {
        if let orderViewController = OrderViewController.instantiate(fromStoryboard: .main) {
            orderViewController.viewModel = OrderViewModel(fuelData: fuelData, location: location, delegate: self)
            navigationController.pushViewController(orderViewController, animated: true)
        }
    }
    
    func didTapeCancel() {
        self.navigationController.popToRootViewController(animated: true)
    }
}

