//
//  AsyncResult.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

typealias AsyncResult<Success> = Result<Success, Error>

typealias AsyncCompletion<T> = (AsyncResult<T>) -> Void
