//
//  MoviesVCViewController.swift
//  MoviesApp
//
//  Created by Mahmoud Sallam on 03/10/2021.
//

import UIKit

class MoviesVC: UIViewController,
                UICollectionViewDataSource ,
                    UICollectionViewDelegateFlowLayout ,
                UITabBarControllerDelegate, UITabBarDelegate{
    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet var collectionView:UICollectionView!
   
    var moviesList:[Result] = []
    var popularMoviesList:[Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?.first
        navigationController?.hidesBarsOnTap = false 
        
//        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPopularMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.setMovieImage(imageLink: Constants.URLS.baseImageUrl + moviesList[indexPath.row].posterPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:180, height: 300)
    }

    func showAlert( title:String , message:String){
        let alert = UIAlertController(title: title, message:message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = moviesList[indexPath.row]
        let detailsVC = self.storyboard!.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        _ = detailsVC.view
        detailsVC.movieDesc.text = movie.overview
        detailsVC.movieName.text = movie.originalTitle
        detailsVC.movieDate.text = movie.releaseDate

        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func getTopRatedMovies(){
        let session = URLSession.shared
        let urlString = "\(Constants.URLS.baseURL)top_rated?api_key=\(Constants.APIKeys.kClientKey)"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
                do{
                    let movie:MovieModel = try JSONDecoder().decode(MovieModel.self, from: data!)
                    DispatchQueue.main.async {
                        self.moviesList = movie.results
                        self.collectionView.reloadData()
                    }

                }
                catch{
                    self.showAlert(title: "Error", message: "Something went wrong!")
                
                }
                
         
                
        })
        task.resume()
    }
    
    func getPopularMovies(){
        let session = URLSession.shared
        let urlString = "\(Constants.URLS.baseURL)popular?api_key=\(Constants.APIKeys.kClientKey)"
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = session.dataTask(with: urlRequest, completionHandler: { data, response, error in
                do{
                    let movie:MovieModel = try JSONDecoder().decode(MovieModel.self, from: data!)
                    DispatchQueue.main.async {
                        self.moviesList = movie.results
                        self.collectionView.reloadData()
                    }

                }
                catch{
                    self.showAlert(title: "Error", message: "Something went wrong!")
                }
                
         
                
        })
        task.resume()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openDetails"
        {
            let index = sender as! NSIndexPath
            let vc = segue.destination as! DetailsVC
            vc.movieDetails = moviesList[index.row]
        }
    }
    
   
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
     
        if item.title == "Top Rated"{
            getPopularMovies()
        }
        else {
            getTopRatedMovies()
           
        }
    }
    
    
}
