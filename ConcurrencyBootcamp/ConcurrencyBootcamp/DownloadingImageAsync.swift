import SwiftUI
import Combine

extension DownloadAsyncLoader {
    // Helper Function
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
}

class DownloadAsyncLoader {
    let url = URL(string: "https://picsum.photos/200")!
    
    
    // MARK: Downloading Image using completion Handler
    
    /*
     - Why @escaping?
        - The closure is called after the function finishes (because network calls are asynchronous).
     - This function returns Void, but delivers the image or error asynchronously using a completion handler(which is a closure)
     - In this async pattern, the closure does not return values normally — it receives them.
     */
    
    func downloadWithEscaping(completionHandler: @escaping (_ image : UIImage?, _ error: Error?) -> ()) {
        
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            if let error = error {
                print(error.localizedDescription)
            }
            completionHandler(image, error)
        }
        .resume()
    }
    
    // MARK: Downloading Image with Combine
    
    // not important: just converting type Error to URLError .mapError({$0})
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({$0})
            .eraseToAnyPublisher()
    }
    
    // MARK: Downloading Image with Async (Swift concurrency)
    func downloadWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponse(data: data, response: response)
        } catch  {
            throw error
        }
    }
    
}

class DownloadAsyncViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let loader = DownloadAsyncLoader()
    var cancellables = Set<AnyCancellable>()
    
    func fetchImage() {
//        loader.downloadWithEscaping { [weak self] image, error in
//            DispatchQueue.main.async {
//                self?.image = image
//            }
//        }
        loader.downloadWithCombine()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)
    }
    
    func fetchImage2() async {
        // we use optional try? when we dont want to handle the error
        let image = try? await loader.downloadWithAsync()
        await MainActor.run {
            self.image = image
        }
    }
}

struct DownloadingImageAsync: View {
    @StateObject private var vm = DownloadAsyncViewModel()
    
    var body: some View {
        ZStack {
            if let image  = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else { ProgressView() }
                
        }
        .onAppear {
//            vm.fetchImage()
            
            // to call an async func we need to use Task
            Task {
                await vm.fetchImage2()
            }
        }
        
    }
}

#Preview {
    DownloadingImageAsync()
}
