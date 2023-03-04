//
//  Cancellable.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

protocol Cancellable {
    var isCancelled: Bool { get }

    func cancel()
}
