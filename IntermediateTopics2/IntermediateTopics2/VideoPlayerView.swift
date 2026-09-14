
import SwiftUI
import AVKit
import AVFoundation // Optional for AVPlayer, but good practice

struct VideoPlayerView: View {
    // 1. Create an AVPlayer instance
    //    We use an @State property wrapper to ensure the player persists
    //    and the view updates when its state changes (though AVPlayer itself
    //    doesn't typically trigger view updates directly for simple playback).
    //    For local files, use Bundle.main.url(forResource:withExtension:)
    @State private var player: AVPlayer?

    // Add a state to control playback (optional, VideoPlayer has built-in controls)
    @State private var isPlaying: Bool = false

    var body: some View {
        VStack {
            // 2. Use the VideoPlayer view
            if let player = player {
                VideoPlayer(player: player)
                    .frame(height: 300) // Set a frame for your video player
                    .onAppear {
                        // Optional: Start playing automatically when the view appears
                        player.play()
                        isPlaying = true
                    }
                    .onDisappear {
                        // Optional: Pause when the view disappears
                        player.pause()
                        isPlaying = false
                    }
            } else {
                Text("Error loading video.")
            }

            // Optional: Custom playback controls (VideoPlayer provides its own)
            Button(action: {
                if let player = player {
                    if isPlaying {
                        player.pause()
                    } else {
                        player.play()
                    }
                    isPlaying.toggle()
                }
            }) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.largeTitle)
                    .padding()
            }
        }
        .onAppear {
            // Initialize the AVPlayer when the view first appears
            guard let url = Bundle.main.url(forResource: "sample", withExtension: "mp4") else {
                print("Video file not found.")
                return
            }
            player = AVPlayer(url: url)
        }
    }
}

// MARK: - Preview

#Preview {
    VideoPlayerView()
}
