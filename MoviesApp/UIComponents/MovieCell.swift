//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Mahmoud Sallam on 02/10/2021.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var movieImg: UIImageView!
    func setMovieImage(imageLink:String){
        let url = URL(string: imageLink)
        let data = try! Data(contentsOf: url!)
        movieImg.image = UIImage(data: data)
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 12
        super.layoutSubviews()
    }
}
