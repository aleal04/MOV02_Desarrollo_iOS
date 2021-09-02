//
//  PlayerController.swift
//  storyboards
//
//  Created by Andrey Leal on 2/9/21.
//
import UIKit

class PlayerController: UIViewController , UITableViewDataSource, UITableViewDelegate , AddPlayerDelegate
{
    func addPlayer(name: String, stars: String) {
        print(shapeList.count)
        if shapeList.count < 10 {
            shapeList.append(Players(playerName: name, stars:stars))
            refreshList()
        }
        
    }
    
    @IBOutlet var shapeTableView: UITableView!
    var shapeList = [Players]()
    var refreshControl: UIRefreshControl?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        shapeList.append(Players( playerName: "Luis", stars: "1"))
        shapeList.append(Players( playerName: "Carlos", stars: "2"))
    }
    
    // MARK: - Refresh Table
    
    func addRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.red
        refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        shapeTableView.addSubview(refreshControl!)
    }
    
    @objc func refreshList(){
        shapeList.sort(by: {$0.stars > $1.stars})
        refreshControl?.endRefreshing()
        shapeTableView.reloadData()
    }
    
    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shapeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "table_view_cell_ID") as! PlayerListViewCell
        
        let thisShape = shapeList[indexPath.row]
        
        tableViewCell.shapeName.text = thisShape.playerName
        tableViewCell.shapeGame.text = "Default Game"
        
        tableViewCell.shapeImageStars.image = UIImage(named: thisShape.stars + "Stars")
        
        return tableViewCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "aux"{
            if let destVC = segue.destination as? UINavigationController ,
               let targetController = destVC.topViewController as? AddPlayerController
            {
                targetController.delegate = self
            }
        }
    }
}
