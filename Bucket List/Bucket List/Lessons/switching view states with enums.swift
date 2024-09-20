//
//  switching view states with enums.swift
//  Bucket List
//
//  Created by Sagar Jangra on 22/08/2024.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct switching_view_states_with_enums: View {
    
    enum LoadingState {
        case loading, success, failed
    }
    
    @State private var loadingState = LoadingState.success
    
    var body: some View {
        switch loadingState {
        case .loading:
            LoadingView()
        case .success:
            SuccessView()
        case .failed:
            FailedView()
        }
    }
}

#Preview {
    switching_view_states_with_enums()
}
