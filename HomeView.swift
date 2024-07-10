//
//  HomeView.swift
//  DeliverflyNeliShahapuniG1
//
//  Created by user on 7/2/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var navigation: Navigation
    @EnvironmentObject private var firebase: Firebase
    var body: some View {
        if firebase.restaurants.isEmpty{
            ProgressView()
                .task {
                    await firebase.fetchData()
                }
        }else{
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        historyButton
                        deliveryAddress
                        Spacer()
                    }
                    restaurants
                    restaurantsList
                }
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .task {
                await firebase.fetchData()
            }
        }
    }
    
    var historyButton: some View {
        Button(action: {
            // go to History
        }, label: {
            Image(.history)
                .padding()
                .background(.lightGray)
                .clipShape(Circle())
        })
    }
    
    var deliveryAddress: some View {
        VStack(alignment: .leading) {
            Text("DELIVER TO")
                .font(.caption)
                .bold()
                .foregroundStyle(.darkOrange)
            Text("16 Halabyan St, Yerevan 0038")
                .font(.footnote)
                .foregroundStyle(.darkGray)
        }
        .padding()
    }
    
    var restaurants: some View {
        Text("Restaurants")
            .font(.title3)
            .padding(.vertical)
    }
    
    var restaurantsList: some View {
        ForEach(firebase.restaurants, id: \.self) { restaurant in
            Button(action: {
                navigation.goTo(view: .restaurant(info: restaurant))
            }, label: {
                RestaurantPreview(restaurant: restaurant)
            })
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Navigation())
        .environmentObject(Firebase())
    
}
