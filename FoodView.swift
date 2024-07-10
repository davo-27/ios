import SwiftUI

struct FoodView: View {
    let food: Food
    @Environment (\.dismiss) private var dismiss
    @State private var selectedIngredients: [Ingredient] = []
    @State private var quantity: Int = 1
    private var total:  Double {
        food.price*Double(quantity)
    }
    @Binding var orderItems: [Item]
    
    var body: some View {
        VStack {
            ScrollView {
                image
                VStack(alignment: .leading) {
                    title
                    description
                    
                    if !food.ingredients.isEmpty {
                        Text("INGREDIENTS")
                            .font(.headline)
                            .foregroundStyle(.gray)
                            .padding(.vertical)
                        ingredientsList
                    }
                }
                .padding(.horizontal)
            }
        }
        
        Group {
            Divider()
            HStack {
                totalPrice
                Spacer()
                itemQuantity
            }
            addToCrat
        }
        .padding(.horizontal)
        .scrollIndicators(.hidden)
    }
    
    var image: some View {
        Image(food.image)
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .clipShape(.rect(topLeadingRadius: 0, bottomLeadingRadius: 30, bottomTrailingRadius: 30, topTrailingRadius: 0))
            .allowsHitTesting(false)
    }
    
    var title: some View {
        Text(food.name)
            .font(.title2)
            .bold()
            .foregroundStyle(.darkBlue)
            .padding(.vertical, 5)
    }
    
    var description: some View {
        Text(food.description)
            .font(.subheadline)
            .lineSpacing(10)
            .foregroundStyle(.gray)
    }
    
    var ingredientsList: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70), alignment: .top)], content: {
            ForEach(food.ingredients, id: \.self) { ingredient in
                Button(action: {
                    ingredientTapped(ingredient)
                }, label: {
                    ingredientButton(ingredient)
                })
            }
        })
    }
    
    @ViewBuilder func ingredientButton(_ ingredient: Ingredient) -> some View {
        VStack {
            Image(ingredient.rawValue)
                .renderingMode(.template)
                .frame(width: 50, height: 50)
                .foregroundStyle(isSelected(ingredient) ? .lightOrange : .darkOrange)
                .background(isSelected(ingredient) ? .darkOrange : .lightOrange)
                .clipShape(Circle())
                .padding(.trailing)
            
            Text(ingredient.rawValue.capitalized)
                .foregroundStyle(.darkGray)
                .font(.footnote)
                .padding(.trailing)
        }
    }
    
    func isSelected(_ ingredient: Ingredient) -> Bool {
        selectedIngredients.contains {$0 == ingredient}
    }
    
    func ingredientTapped(_ ingredient: Ingredient) {
        if selectedIngredients.contains(where: {$0 == ingredient}) {
            selectedIngredients.removeAll { $0 == ingredient }
        }
        else if selectedIngredients.count < 3 {
            selectedIngredients.append(ingredient)
        }
    }
    
    var totalPrice: some View {
        Text(total, format: .currency(code: "USD"))
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .fontWeight(.medium)
            .padding(.vertical, 10)
    }
    
    var itemQuantity: some View {
        Group {
            Button(action: {
                if quantity > 0 {
                    quantity -= 1
                }
            }, label: {
                Text("-")
                    .bold()
                    .foregroundStyle(.darkGray)
                    .frame(width: 25, height: 25)
                    .background(.lightGray)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            })
            
            Text("\(quantity)")
                .bold()
                .padding(.horizontal)
            
            Button(action: {
                if quantity < 10 {
                    quantity += 1
                }
            }, label: {
                Text("+")
                    .bold()
                    .foregroundStyle(.darkGray)
                    .frame(width: 25, height: 25)
                    .background(.lightGray)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            })
        }
    }
    
    var addToCrat: some View {
        Button(action: {
            let item = Item(
                food: food,
                quantity: quantity,
                extras: selectedIngredients
            )
            orderItems.append(item)
            dismiss()
        }, label: {
            Text("Add to Cart".uppercased())
                .bold()
                .frame(maxWidth: .infinity, minHeight: 60)
                .foregroundStyle(quantity == 0 ? .gray : .white)
                .background(quantity == 0 ? .lightGray : .darkOrange)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
        .disabled(quantity == 0)
    }
}

#Preview {
    FoodView(food: .doubleDouble, orderItems: .constant(.previewDataArray))
}
