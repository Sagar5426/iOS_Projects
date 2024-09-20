import SwiftUI

struct trial: View {
    var body: some View {
        List {
            ForEach(1 ..< 10) { i in
                HStack {
                    Text("Item \(i)")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .listRowBackground(LinearGradient.lightBackground)
        }
        .scrollContentBackground(.hidden)
        .background(LinearGradient.darkBackground)
    }
}

#Preview {
    trial()
        .preferredColorScheme(.dark)
}
