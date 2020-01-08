//
//  HTTPRequest+Enum.swift
//  AppleiTunesMedia
//
//  Created by Daniele Rapali on 08/01/2020.
//  Copyright © 2020 Daniele Rapali. All rights reserved.
//

import Foundation

enum MediaType: String {
     case iTunesMusic   = "itunes-music"
    case iOSApps        = "ios-apps"
    
    /// Wi'll return the description label of the media type
    /// it is possible in multiple, easy and different way but for a quick code i decided for this implementation
    func label() -> String {
        switch self {
        case .iOSApps:
            return "iOS Apps"
        case .iTunesMusic:
            return "iTunes Music"
        }
    }
}

enum iTunesMusic: String {
    case NewMusic   = "new-music"
    case HotTracks  = "hot-tracks"
}

enum iOSApp: String {
    case TopFree = "top-free"
}
