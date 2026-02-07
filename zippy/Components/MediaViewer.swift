//
//  MediaViewer.swift
//  zippy
//
//  Created by zclee on 2026/2/7.
//

import AVKit
import SwiftUI

struct MediaViewer: View {
    let mediaItem: MediaItem
    var aspectRatio: ContentMode = .fill
    
    var body: some View {
        Group {
            if mediaItem.type == .image {
                if mediaItem.fileName.hasPrefix("fish") {
                    // Bundled image
                    Image(mediaItem.fileName)
                        .resizable()
                        .aspectRatio(contentMode: aspectRatio)
                } else if let image = DataService.shared.loadImage(filename: mediaItem.fileName) {
                    // User-uploaded image
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: aspectRatio)
                } else {
                    // Placeholder
                    ZStack {
                        Color.gray.opacity(0.3)
                        Image(systemName: "photo")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                    }
                }
            } else {
                LoopingVideoPlayer(fileName: mediaItem.fileName)
            }
        }
    }
}

struct LoopingVideoPlayer: View {
    let fileName: String
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                if let player = player {
                    PlayerView(player: player)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    // Play Overlay
                    if !isPlaying {
                        ZStack {
                            Color.black.opacity(0.3)
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.white.opacity(0.8))
                                .shadow(radius: 4)
                        }
                    }
                } else {
                    ZStack {
                        Color.black
                        MediaActivityIndicator(style: .medium)
                    }
                    .onAppear {
                        setupPlayer()
                    }
                }
            }
            .onTapGesture {
                togglePlay()
            }
        }
    }
    
    private func togglePlay() {
        guard let player = player else { return }
        
        if isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
    
    private func setupPlayer() {
        // Handle "fish.mp4" -> name "fish", ext "mp4"
        let name = (fileName as NSString).deletingPathExtension
        let ext = (fileName as NSString).pathExtension.isEmpty ? "mp4" : (fileName as NSString).pathExtension
        
        if let url = Bundle.main.url(forResource: name, withExtension: ext) {
            let item = AVPlayerItem(url: url)
            let newPlayer = AVPlayer(playerItem: item)
            // Removed isMuted = true to enable sound
            self.player = newPlayer
            // Do not auto-play
            
            // Loop functionality
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: item, queue: .main) { _ in
                newPlayer.seek(to: .zero)
                newPlayer.play()
            }
        } else {
            print("Could not find video: \(fileName)")
        }
    }
}

struct PlayerView: UIViewRepresentable {
    let player: AVPlayer
    
    func makeUIView(context: Context) -> PlayerUIView {
        return PlayerUIView(player: player)
    }
    
    func updateUIView(_ uiView: PlayerUIView, context: Context) {
        // No update needed
    }
}

class PlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var player: AVPlayer?
    
    init(player: AVPlayer) {
        self.player = player
        super.init(frame: .zero)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill
        layer.addSublayer(playerLayer)
        
        // Observer for background playback
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    
    @objc private func applicationDidEnterBackground() {
        // Detach player from layer to allow background audio playback
        playerLayer.player = nil
    }
    
    @objc private func applicationWillEnterForeground() {
        // Re-attach player
        playerLayer.player = player
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

struct MediaActivityIndicator: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: style)
        view.startAnimating()
        view.color = .white
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        uiView.style = style
    }
}
