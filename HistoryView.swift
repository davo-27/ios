import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var navigation: Navigation
    @EnvironmentObject private var firebase: Firebase
    @State private var selectedOrder: Order?
    @State private var loadingOrders = true
    
    var body: some View {
        VStack {
            HStack {
                backButton
                Text("Restaurant")
                
                Spacer()
                
                //cartButton
            }
            .padding(.horizontal)
            Spacer()
            historyView
            Spacer()
                .task {
                    await firebase.fetchOrders()
                }
                .onDisappear {
                    firebase.resetOrders()
                    loadingOrders = true
                }
        }
    }
    
    @ViewBuilder var historyView: some View {
        if firebase.orders.isEmpty {
            if loadingOrders {
                ProgressView()
                    .task {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            loadingOrders = false
                        }
                    }
            }
            else {
                VStack {
                    logo
                    text
                    description
                }
                .padding(.horizontal)
            }
        }
        else {
            VStack {
                ScrollView {
                    ForEach(firebase.orders, id: \.self) { order in
                        VStack(alignment: .center) {
                            OrderPreview(order: order)
                            viewOrderButton(order)
                        }
                        .padding(.horizontal)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
    @ViewBuilder func viewOrderButton(_ order: Order) -> some View {
        Button(action: {
            selectedOrder = order
            if let selectedOrder = Binding<Order>($selectedOrder) {
                navigation.goTo(view: .order(info: selectedOrder, isOrdering: false))
            }
        }, label: {
            Text("View Order")
                .bold()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 40)
                .foregroundStyle(.darkOrange)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.darkOrange, lineWidth: 2)
                )
        })
    }
    
    var backButton: some View {
        Button(action: {
            navigation.goBack()
        }, label: {
            Image(.backArrow)
                .frame(width: 50, height: 50)
                .background(.lightGray)
                .clipShape(Circle())
                .padding(.trailing)
        })
    }
    
    var logo: some View {
        Image(.error)
            .foregroundStyle(.white)
    }
    
    var text: some View {
        Text("Aw Snap!")
            .font(.title)
            .padding(.top, 10)
            .bold()
    }
    
    var description: some View {
        Text("There was an issue, \n please make an order and try again!")
            .font(.subheadline)
            .foregroundStyle(.gray)
            .multilineTextAlignment(.center)
    }
}

#Preview {
    HistoryView()
        .environmentObject(Navigation())
        .environmentObject(Firebase())
}
