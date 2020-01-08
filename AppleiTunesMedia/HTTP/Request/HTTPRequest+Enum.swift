//
//  HTTPRequest+Enum.swift
//  AppleiTunesMedia
//
//  Created by Daniele Rapali on 08/01/2020.
//  Copyright © 2020 Daniele Rapali. All rights reserved.
//

import Foundation

/// Wi'll return the description label of the media type
/// it is possible in multiple, easy and different way but for a quick code i decided for this implementation
enum MediaType: String {
    
    case iTunesMusic   = "itunes-music"
    case iOSApps        = "ios-apps"
    
    
    /// Label to display in the table header by selection
    func label() -> String {
        switch self {
        case .iOSApps:
            return "iOS Apps"
        case .iTunesMusic:
            return "iTunes Music"
        }
    }
    
    
    /// Feed type for the http call, it changes by media type selected
    func feedType() -> String {
        switch self {
        case .iTunesMusic: return "hot-tracks"
        case .iOSApps: return "top-free"
        }
    }
    
    
    /// Label to display for the media - feed type selected
    func feedLabel() -> String {
        switch self {
        case .iTunesMusic: return "Hot Tracks"
        case .iOSApps: return "Top Free"
        }
    }
}
