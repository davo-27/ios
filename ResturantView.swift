import SwiftUI

struct RestaurantView: View {
    let restaurant: Restaurant
    @State private var selectedFood: Food?
    @State private var hasCartItems = false
    @State private var order = Order(id: String(Int.random(in: 100000..<99999)),
                                     date: Date().formatted(.dateTime.day(.twoDigits).month(.wide).year(.defaultDigits)),
                                     restaurant: .init(name: "Dummy Restaurant", image: "dummyImage"),
                                     items: [],
                                     deliveryPrice: 0.0)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    backButton
                    Text("Restaurant")
                    Spacer()
                    bagButton
                }
                restaurantImage
                nameText
                descriptionText
                menuText
                foodsGrid
            }
            .padding(.horizontal)
        }
        .sheet(item: $selectedFood) { item in
            FoodView(food: item, orderItems: $order.items)
                .presentationDetents(item.ingredients.isEmpty ? [.fraction(0.63)] : [.fraction(0.93)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(30)
        }
        .scrollIndicators(.hidden)
        .onChange(of: order.items.isEmpty) {
            withAnimation(.easeInOut(duration: 0.3)) {
                hasCartItems.toggle()
            }
        }
    }

    var backButton: some View {
        Button(action: {
            // Assuming navigation is defined elsewhere
            // navigation.goto(view: .order(info: $order))
        }, label: {
            Image("backArrow")
                .frame(width: 50, height: 50)
                .background(hasCartItems ? Color.blue : Color.gray)
                .clipShape(Circle())
                .padding(.trailing)
                .overlay(
                    Text(String(order.items.count))
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .background(Color.orange)
                        .clipShape(Circle())
                        .offset(y: -5)
                        .transition(.scale)
                        .opacity(hasCartItems ? 1 : 0)
                )
        })
        .disabled(hasCartItems)
    }

    var bagButton: some View {
        Button(action: {
            // Add your bag button action
        }, label: {
            Image("bag")
                .frame(width: 50, height: 50)
                .background(Color.gray)
                .clipShape(Circle())
                .padding(.leading)
        })
    }

    var restaurantImage: some View {
        Image(restaurant.image)
            .resizable()
            .scaledToFill()
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.vertical)
            .allowsHitTesting(false)
    }

    var nameText: some View {
        Text(restaurant.name)
            .font(.title2)
            .bold()
            .foregroundColor(.blue)
            .padding(.vertical, 5)
    }

    var descriptionText: some View {
        Text(restaurant.description)
            .font(.subheadline)
            .lineSpacing(10)
            .foregroundColor(.gray)
    }

    var menuText: some View {
        Text("Menu")
            .font(.title3)
            .padding(.vertical)
    }

    var foodsGrid: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 40)], content: {
            ForEach(restaurant.foods, id: \.self) { food in
                Button(action: {
                    selectedFood = food
                }, label: {
                    FoodPreview(food: food)
                        .frame(height: 200)
                })
            }
        })
    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantView(restaurant: .inNOut)
    }
}

