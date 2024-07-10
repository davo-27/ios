//
//  DeliverflyDavidGevorgyanApp.swift
//  DeliverflyDavidGevorgyan
//
//  Created by user on 7/8/24.
//

import SwiftUI
import FirebaseCore

@main
struct DeliverflyDavidGevorgyanApp: App {
    @ObservedObject private var navigation = Navigation()
    @State private var isSplash = true
    @ObservedObject private var firebase: Firebase
    
    init() {
        FirebaseApp.configure()
        firebase = Firebase()
    }
                                
        var body: some Scene {
            WindowGroup {
                if isSplash {
                    SplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                              isSplash = false
                            }
                        }
                    
                } else {
                   
                    NavigationStack(path: $navigation.path){
                        HomeView()
                            .navigationBarBackButtonHidden()
                            .navigationDestination(for: Navigation.View.self){ view in
                                switch view{
                                case .restaurant(info: let info):
                                    RestaurantView(restaurant: info)
                                        .navigationBarBackButtonHidden()
                                case .order(info: let info, isOrdering: let isOrdering):
                                    OrderView(order: info, isOrdering: isOrdering)
                                case .history:
                                    HistoryView()
                                        .navigationBarBackButtonHidden()
                                case .status(info: let info):
                                    StatusView(status: info)
                                        .navigationBarBackButtonHidden()
                                }
                            }
                    }
                    .environmentObject(firebase)
                    .environmentObject(Navigation())
                    
                }
            }
        }
    
}
