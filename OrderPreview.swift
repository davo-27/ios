import SwiftUI

struct OrderPreview: View {
    let order: Order
    var body: some View {
        VStack (alignment: .leading) {
            orderDate
            Divider ()
            HStack (alignment: .center) {
                orderImage
                orderInfo
            }
            .padding(.top)
        }

    }
    
    var orderDate: some View {
        Text(order.date)
            .padding(.vertical)
            .font(.callout)
            .bold()
            .foregroundStyle(.gray)
    }
    
    var orderImage: some View {
        Image(order.restaurant.image)
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.vertical)
    }
    
    var orderInfo: some View {
        HStack(alignment: .top) {
            VStack(alignment: .listRowSeparatorLeading) {
                Text(order.restaurant.name)
                    .fontWeight(.heavy)
                    .bold()
                    .padding(.horizontal)
                HStack(alignment: .center) {
                    Text(order.total, format: .currency(code: "USD"))
                        .fontWeight(.bold)
                    Divider()
                        .frame(width: 1.5, height: 20)
                        .background(.lightGray)
                        .padding(.horizontal, 10)
                    Text("\(order.items.count) Items")
                        .font(.footnote)
                        .fontWeight(.light)
                        .foregroundStyle(.darkGray)
                }
                .padding(.top, 5)
            }
            Spacer()
            Text("#\(order.id)")
                .foregroundStyle(.darkGray)
        }
    }
}

#Preview {
    OrderPreview(order: .previewData)
}
