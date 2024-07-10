//
//  ItemPreview.swift
//  DeliverflyDavidGevorgyan
//
//  Created by user on 7/4/24.
//

import SwiftUI

struct ItemPreview: View {
    let item: Item
    var body: some View {
        HStack(alignment: .center){
            itemImage
            VStack(alignment: .leading, spacing: 5){
                itemName
                extras
                Spacer()
                itemPrice
            }
        }
    
    }
    
    var itemImage: some View{
        Image(item.food.image)
            .resizable()
            .frame(width: 150, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    var itemName: some View{
        Text(item.food.name)
            .padding(.bottom, 10)
            .bold()
            .font(.title2)
    }
    var extras: some View{
        VStack{
            ForEach( item.extras, id:\.self){ extra in
                Text(" + \(extra.rawValue)")
            }
        }.padding(.bottom,30)
            .font(.title3)
            .foregroundStyle(.gray)
    }
    
    var itemPrice: some View{
        HStack(alignment: .lastTextBaseline) {
            Text(item.food.price, format: .currency(code: "USD"))
                .font(.title2)
                .bold()
            
            if item.quantity > 1 {
                Text("x\(item.quantity)")
                    .padding(.leading)
            }
        }
    }
}




#Preview {
    ItemPreview(item: .previewData)
}

