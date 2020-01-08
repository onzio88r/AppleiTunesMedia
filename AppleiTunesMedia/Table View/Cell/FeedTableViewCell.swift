//
//  FeedTableViewCell.swift
//  AppleiTunesMedia
//
//  Created by Daniele Rapali on 08/01/2020.
//  Copyright © 2020 Daniele Rapali. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    var feed: FeedResult? {
        didSet {
            feedName.text = feed?.name
            feedDescription.text = feed?.artistName
            if let urlStr = feed?.artworkUrl100 {
                setImage(from: urlStr)
            }
        }
    }

    private let feedName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        return label
    }()
    
    private let feedDescription: UILabel = {
           let label = UILabel()
           label.textColor = .black
           label.font = UIFont.systemFont(ofSize: 13)
           label.textAlignment = .left
           return label
       }()
    
    private let feedImage : UIImageView = {
    let imgView = UIImageView(image: #imageLiteral(resourceName: "ITunesLogo.pdf"))
    imgView.contentMode = .scaleAspectFit
    imgView.clipsToBounds = true
    return imgView
    }()
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

            // just not to cause a deadlock in UI!
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.feedImage.image = image
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(feedName)
        addSubview(feedDescription)
        addSubview(feedImage)
        
        feedImage.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        feedName.anchor(top: topAnchor, left: feedImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        feedDescription.anchor(top: feedName.bottomAnchor, left: feedImage.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0, enableInsets: false)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
