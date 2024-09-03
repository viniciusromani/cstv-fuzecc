//
//  Coordinator.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import Foundation
import SwiftUI

protocol PagesProtocol: Hashable { }
protocol Coordinator: ObservableObject {
    var path: NavigationPath { get set }
    associatedtype Pages: PagesProtocol
    associatedtype _View: View
    
    func push(page: Pages)
    func pop()
    func popToRoot()
    func build(page: Pages) -> _View
    
}
extension Coordinator {
    func push(page: Pages) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
