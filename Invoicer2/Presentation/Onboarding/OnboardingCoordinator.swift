//
//  OnboardingCoordinator.swift
//  Invoicer2
//
//  Created by Pedro Alvarez on 12/04/25.
//

import UIKit

protocol OnboardingCoordinatorProtocol {
    func navigateToInvoiceList()
}

class OnboardingCoordinator: OnboardingCoordinatorProtocol {
    weak var viewController: UIViewController?
    
    init() {}
    
    func navigateToInvoiceList() {
        // TO DO
    }
}
