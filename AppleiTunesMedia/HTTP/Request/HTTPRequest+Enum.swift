//
//  HTTPRequest+Enum.swift
//  AppleiTunesMedia
//
//  Created by Daniele Rapali on 08/01/2020.
//  Copyright © 2020 Daniele Rapali. All rights reserved.
//

import Foundation

enum MediaType: String {
    case iTunesMusic    = "itunes-music"
    case iOSApps        = "ios-apps"
}

enum iTunesMusic: String {
    case NewMusic   = "new-music"
    case HotTracks  = "hot-tracks"
}

enum iOSApp: String {
    case TopFree = "top-free"
}
