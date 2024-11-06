//
//  YouTubeVideoView.swift
//  RecipeFetcher
//
//  Created by Adam Sadler on 11/6/24.
//

import SwiftUI
import WebKit

struct YouTubeVideoView: UIViewRepresentable {
    let videoURL: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let videoID = videoURL.split(separator: "=").last!
        let embedURL = URL(string: "https://www.youtube.com/embed/\(videoID)")!
        let request = URLRequest(url: embedURL)
        uiView.load(request)
    }
}
