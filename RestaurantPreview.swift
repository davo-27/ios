//
//  RestaurantPreview.swift
//  DeliverflyNeliShahapuniG1
//
//  Created by user on 7/2/24.
//

import SwiftUI

struct RestaurantPreview: View {
    let restaurant: Restaurant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            headerImage
            restaurantName
            menuItems
            HStack {
                info(.star, String(restaurant.rating))
                info(.truck, "Free")
                info(.clock, "\(restaurant.time) min")
            }
            .padding(.vertical)
        }
    }
    
    var headerImage: some View {
        Image(restaurant.image)
            .resizable()
            .scaledToFill()
            .frame(height: 140)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
    
    var restaurantName: some View {
        Text(restaurant.name)
            .font(.title2)
            .foregroundStyle(.darkBlue)
    }
    
    var menuItems: some View {
        Text(restaurant.foods.map {$0.name}.joined(separator: " - "))
            .font(.subheadline)
            .foregroundStyle(.gray)
            .lineLimit(1)
    }
    
    @ViewBuilder func info(_ image: ImageResource,_ text: String) -> some View {
        Image(image)
            .renderingMode(.template)
            .foregroundStyle(.darkOrange)
        Text(text)
            .fontWeight(.light)
            .foregroundStyle(.darkBlue)
            .padding(.trailing)
    }
}

#Preview {
    RestaurantPreview(restaurant: .inNOut)
}
