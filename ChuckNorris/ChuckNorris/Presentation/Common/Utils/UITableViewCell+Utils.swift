//
//  UITableViewCell+Utils.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import UIKit

extension UITableViewCell {
    class var reuseIdentifier: String { name }

    class func registerCellNib(in tableView: UITableView,
                               with nibName: String? = nil,
                               bundle: Bundle? = nil,
                               reuseIdentifier identifier: String? = nil) {
        let nib = UINib(nibName: nibName ?? name, bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: identifier ?? Self.reuseIdentifier)
    }

    class func registerCellClass(in tableView: UITableView,
                                 with reuseIdentifier: String? = nil) {
        tableView.register(self, forCellReuseIdentifier: reuseIdentifier ?? Self.reuseIdentifier)
    }
}

extension UIView {
    class var name: String {
        return String(describing: self)
    }
}
