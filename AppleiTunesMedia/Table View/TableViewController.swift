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

    
    /// Class object to manage the http request
    private let httpRequestManager = HTTPRequest()
    
    
    /// Type of media available from the picker selection
    var mediaTypeAvailable = [MediaType.iTunesMusic, MediaType.iOSApps]
    
    fileprivate let mediaPicker: UIPickerView = {
        let picker = UIPickerView(frame: .zero)
        
        return picker
    }()

    
     let tableView: UITableView = {
        
        let tv = UITableView(frame: .zero)
        tv.register(FeedTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        return tv
    }()
    
    
    /// Feed results, this is the data will be showed in the table view
    var feedResults = [FeedResult]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    /// Main feed result, in this object we have some data like the apple copyright label, visible in the table footer 
    var mainFeedResult:Feed?
    
    
    /// With this component we can manage the table view data. In the first time it is popolated like the first element of the picker. Every time
    /// the picker change value, this object will be changed, a new request it's sent and the table view will be refreshed when completed the http call
    var mediaTypeRequested = MediaType.iTunesMusic {
        didSet {
            httpRequestManager.FeedList(mediaType: mediaTypeRequested) { ( response ) in
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

        view.addSubview(mediaPicker)
        mediaPicker.translatesAutoresizingMaskIntoConstraints = false
        
        mediaPicker.delegate = self
        mediaPicker.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
       
        makeConstraints()
        
        loadFirstData()

    }
    
    
    /// Making contraint for picker and table below
    private func makeConstraints(){
        
        let margin = view.layoutMarginsGuide
        
        mediaPicker.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        mediaPicker.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        mediaPicker.topAnchor.constraint(equalToSystemSpacingBelow: margin.topAnchor, multiplier: 1.0).isActive = true
        
        tableView.trailingAnchor.constraint(equalTo: margin.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: margin.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalToSystemSpacingBelow: mediaPicker.bottomAnchor, multiplier: 1.0).isActive = true
        tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: margin.bottomAnchor, multiplier: 1.0).isActive = true
    }
    
    
    /// loading the first data for the table
    private func loadFirstData(){
        mediaTypeRequested = mediaTypeAvailable[0]
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
