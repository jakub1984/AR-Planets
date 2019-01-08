//
//  PlanetSelectionVC.swift
//  AR Planets
//
//  Created by Jakub Perich on 06/01/2019.
//  Copyright © 2019 Jakub Perich. All rights reserved.
//

import UIKit

class PlanetSelectionVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var planetToPass : String!
    @IBOutlet weak var planetTableView: UITableView!
    var planets = ["mercury", "venus", "earth", "mars", "jupiter", "saturn", "uranus", "neptune"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        planetTableView.delegate = self
        planetTableView.dataSource = self
        planetTableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = planetTableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath) as? PlanetsDirectoryCell {
            cell.setupPlanetCell(planet: planets[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        planetToPass = planets[indexPath.row]
        performSegue(withIdentifier: "segueToPlanet", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let planetVC = segue.destination as? ArPlanetsVC {
            planetVC.passedPlanet = planetToPass
        }
        return
    }
    
}
