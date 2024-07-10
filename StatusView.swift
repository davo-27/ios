import SwiftUI

struct StatusView: View {
    @EnvironmentObject private var navigation: Navigation
    var status: Status
    
    var body: some View {
        VStack {
            Spacer()
            logo
            text
            description
            Spacer()
            doneButton
        }

        .padding(.horizontal)
        }
    
    var logo: some View {
        Image(status.rawValue)
            .foregroundStyle(.white)
    }
    
    var text: some View {
        Text("Congratulations!")
            .font(.title)
            .padding(.top, 10)
            .bold()
    }
    
    var description: some View {
        Text(status.description)
            .font(.subheadline)
            .foregroundStyle(.gray)
            .multilineTextAlignment(.center)
    }
    
    var doneButton: some View {
        Button(action: {
            navigation.goToRoot()
        }, label: {
            Text("Done".uppercased())
                .bold()
                .frame(maxWidth: .infinity, minHeight: 60)
                .foregroundStyle(.white)
                .background(.darkOrange)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        })
    }
}

#Preview {
    StatusView(status: .success)
}
