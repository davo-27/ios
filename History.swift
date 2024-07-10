//
//  History.swift
//  DeliverflyDavidGevorgyan
//
//  Created by user on 7/9/24.
//

import SwiftUI

struct History: View {
    
    @EnvironmentObject private var navigation: Navigation
    @EnvironmentObject private var firebase: Firebase
    @State private var selectedOrder: Order?
    @State private var loadingOrders = true
    
    @ViewBuilder func viewOrderButton(_ order: Order) -> some View{
        Button(action: {
            selectedOrder = order
            if let selectedOrder = Binding<Order>($selectedOrder){
                navigation.goto(view: .order(info: selectedOrder, isOrdering: false))
            }
        }, label: {
            Text("View Order")
                .bold()
                .frame(minWidth: .infinity, minHeight: 60)
                .foregroundStyle(.darkOrange)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.darkOrange, lineWidth: 2)
                }
        })
        
        
    }
    var body: some View {
        VStack{
            HStack{
                backButton
                Text("History")
                Spacer()
            }.padding(.horizontal)
            Spacer()
            HistoryView
            Spacer()
        }
        .task{
            await firebase.fetchOrders()
        }
        .onDisappear{
            firebase.resetOrders()
            loadingOrders = true
        }
    }
    
    
    @ViewBuilder var HistoryView: some View{
        if firebase.orders.isEmpty{
            if loadingOrders{
                ProgressView()
                    .task {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            loadingOrders = false
                        }
                    }
            }else{
                Text("NO Orders")
            }
        }else{
            VStack{
                ScrollView{
                    ForEach(firebase.orders, id: \.self){order in
                        VStack(alignment: .center){
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
    
    
    
    var backButton: some View {
        Button(action: {
            navigation.goBack()
        }, label: {
            Image(.backArrow)
                .frame(width: 50, height: 50)
                .background(.darkGray)
                .clipShape(Circle())
                .padding(.trailing)
        })
        
    }
}
    
    
#Preview {
    History()
        .environmentObject(Navigation())
        .environmentObject(Firebase())
}
