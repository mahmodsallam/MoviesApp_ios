//
//  DetailsVC.swift
//  MoviesApp
//
//  Created by Mahmoud Sallam on 09/10/2021.
//

import UIKit

class DetailsVC: UIViewController {
    @IBOutlet var movieName: UILabel!
    @IBOutlet var movieDate: UILabel!
    @IBOutlet var movieDesc: UILabel!
    
    var movieDetails: Result? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movieDetails?.title
        
    
    }
    
    

}
