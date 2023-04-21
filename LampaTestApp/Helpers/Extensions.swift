//
//  Extensions.swift
//  LampaTestApp
//
//  Created by Олександр Макогоненко on 19.04.2023.
//

import UIKit

extension UIView {
    class var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let errorAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        errorAlertController.addAction(.init(title: "OK", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(errorAlertController, animated: true, completion: nil)
        }
    }
}
