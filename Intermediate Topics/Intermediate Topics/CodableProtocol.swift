
import SwiftUI


// Codable = Decodable + Encodable
// The Codable protocol is a type alias that combines both Decodable and Encodable protocols.
// - Decodable allows us to convert JSON data into Swift objects.
// - Encodable allows us to convert Swift objects into JSON data.
// Behind the scenes, Swift automatically generates a CodingKeys enum (used to identify object properties)
// and provides default initializers for encoding and decoding, making the process easier.
struct customerModel: Identifiable, Codable {
    let id: String
    let name: String
    let age: Int
    let isPremium: Bool
}

class codableViewModel: ObservableObject {
    @Published var customer: customerModel? = nil
    
    init() {
        getData()
    }
    
    func getData() {
        guard let data = getJsonData() else { return }
        self.customer = try? JSONDecoder().decode(customerModel.self, from: data)
    }
    
    func getJsonData() -> Data? {
        // This is mock data for testing purposes.
        // In a real-world scenario, data would typically come from an API or a database.
        let customer = customerModel(id: "111", name: "Sagar", age: 20, isPremium: true)
        
        let jsonData = try? JSONEncoder().encode(customer)
        return jsonData
    }
}

struct CodableProtocol: View {
    @StateObject var vm = codableViewModel()
    
    var body: some View {
        if let customer = vm.customer {
            Text(customer.id)
            Text(customer.name)
            Text("\(customer.age)")
            Text("\(customer.isPremium)")
        }
    }
}

#Preview {
    CodableProtocol()
}
