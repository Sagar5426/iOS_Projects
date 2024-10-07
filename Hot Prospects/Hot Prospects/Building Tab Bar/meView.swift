//
//  meView.swift
//  Hot Prospects
//
//  Created by Sagar Jangra on 09/10/2024.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct meView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "example@gmail.com"
    @State private var qrCode = UIImage()
    
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                    
                
                TextField("Email Address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Image(uiImage: qrCode)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.horizontal, 60)
                    .contextMenu {
                        // can only share SwiftUI image not ui image
                        ShareLink(item: Image(uiImage: qrCode), preview: SharePreview("My QR Code", image: Image(uiImage: qrCode)))
                    }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateCode)
            .onChange(of: name, updateCode)
            .onChange(of: emailAddress, updateCode)
        }
    }
    
    func updateCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }
    
    // Conversion from string to QR is done in following order:
    // String -> Data -> CI Image -> CG Image -> UI Image
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
                
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
}

#Preview {
    meView()
}
