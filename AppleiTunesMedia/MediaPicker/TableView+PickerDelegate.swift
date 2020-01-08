//
//  TableView+PickerDelegate.swift
//  AppleiTunesMedia
//
//  Created by Daniele Rapali on 08/01/2020.
//  Copyright © 2020 Daniele Rapali. All rights reserved.
//

import Foundation
import UIKit

extension TableViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return mediaTypeAvailable[row].label()
      }
      
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        feedResults.removeAll()
        tableView.reloadData()
        
        let mediaSelected = mediaTypeAvailable[row]
          
          mediaTypeRequested = mediaSelected
      }
}
