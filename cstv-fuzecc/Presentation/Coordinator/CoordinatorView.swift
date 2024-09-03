//
//  CoordinatorView.swift
//  cstv-fuzecc
//
//  Created by Vinicius Romani on 03/09/24.
//

import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = AppCoordinator()
    
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.white)]
        appearance.titleTextAttributes = [.foregroundColor: UIColor(Color.white)]
        appearance.backgroundColor = UIColor(Color("BackgroundColor"))
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                Color("BackgroundColor").ignoresSafeArea()
                coordinator.build(page: .home)
                    .navigationDestination(for: AppCoordinator.Pages.self) { page in
                        ZStack {
                            Color("BackgroundColor").ignoresSafeArea()
                            coordinator.build(page: page)
                        }
                    }
            }
        }.environmentObject(coordinator)
    }
}

#Preview {
    CoordinatorView()
}
