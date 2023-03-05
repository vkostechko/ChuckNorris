//
//  AppFlow.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import UIKit

enum AppFlow {
    static func ramdomJokesView() -> JokesView {
        #warning("Add R.swift to avoid force type casting")
        return UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "JokesViewController") as! JokesView
    }
}
