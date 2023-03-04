//
//  URLSessionDataTask+Utils.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

extension URLSessionDataTask: Cancellable {
    var isCancelled: Bool {
        state == .canceling
    }
}
