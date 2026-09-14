import SwiftUI


class EscapingViewModel: ObservableObject {
    @Published var text: String = ""

    // Function to fetch data asynchronously
    func getData() {
        downloadData { [weak self] (returnedResult) in
            DispatchQueue.main.async {
                self?.text = returnedResult.data
            }
        }
    }

    // Function simulating an asynchronous download process
    private func downloadData(completionHandler: @escaping DownloadCompletion) {
        /*
         What is @escaping?
         - In Swift, closures (functions passed as arguments) are non-escaping by default.
         - If a closure is marked as @escaping, it means it can be executed after the function has returned.
         - Here, `completionHandler` is executed inside `DispatchQueue.global().asyncAfter`, which delays execution.
         - Without @escaping, Swift would think the closure is no longer needed once the function exits.
        */
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            let result = DownloadResult(data: "New Data!")
            completionHandler(result)
        }
    }
}

// Struct to hold the downloaded data
struct DownloadResult {
    let data: String
}

// Typealias is used to create a shorter name for a complex type
/*
 What is typealias?
 - Instead of writing `(DownloadResult) -> ()` every time, we define a simpler name `DownloadCompletion`.
 - This improves code readability and maintainability.
*/
typealias DownloadCompletion = (DownloadResult) -> ()

struct escapingUseCase: View {
    @StateObject var vm = EscapingViewModel()

    var body: some View {
        VStack {
            Text(vm.text.isEmpty ? "Tap to Load Data" : vm.text)
                .font(.title.bold())
                .foregroundStyle(.blue)
                .onTapGesture {
                    vm.getData()
                }
        }
    }
}

#Preview {
    escapingUseCase()
}
