//
//  TableViewController.swift
//  AppleiTunesMedia
//
//  Created by Daniele Rapali on 08/01/2020.
//  Copyright © 2020 Daniele Rapali. All rights reserved.
//

import UIKit

let cellIdentifier = "cell"

class TableViewController: UIViewController {

    private let httpRequestManager = HTTPRequest()
    
    fileprivate let tableView: UITableView = {
        
        let tv = UITableView(frame: .zero)
        tv.register(FeedTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        return tv
    }()
    
    var feedResults = [FeedResult]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var mainFeedResult:Feed?
    
    var mediaTypeRequested = MediaType.iTunesMusic {
        didSet {
            httpRequestManager.FeedList(mediaType: .iTunesMusic, feedType: .HotTracks) { ( response ) in
                switch response {
                case .failure(let error) :
                    NSLog(error.localizedDescription)
                case .success(let result):
                    self.mainFeedResult = result.feed
                    self.feedResults = result.feed.results
                }
            }
        }
    }

}


extension TableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = "Apple Feed"

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
       
        makeConstraints()
        
        loadFirstData()

    }
    
    private func makeConstraints(){
        
        let margin = view.layoutMarginsGuide
        
        tableView.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalToSystemSpacingBelow: margin.topAnchor, multiplier: 1.0).isActive = true
        tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: margin.bottomAnchor, multiplier: 1.0).isActive = true
    }
    
    private func loadFirstData(){
        mediaTypeRequested = MediaType.iTunesMusic
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
