//
//  TableViewFooterView.swift
//  themoviedb
//
//  Created by Laurent Meert on 03/05/2018.
//  Copyright © 2018 Laurent Meert. All rights reserved.
//

import UIKit

/**
 The custom view for the table view footer.
 */
class TableViewFooterView: UIView {
    
    /// The nib name to load the view
    static let nibName = "TableViewFooter"
    
    /// The activity indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
}
