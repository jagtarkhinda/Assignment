//
//  MainViewController.swift
//  APIDemo
//
//  Created by Jagtar Singh on 2019-07-02.
//  Copyright © 2019 Parrot. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import WatchConnectivity

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,  WCSessionDelegate {

    
    var session: WCSession!
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //Variables for storing API data
    var arraysemi1: [Any] = []
     var arraysemi2: [Any] = []
    var arrayquarter1: [Any] = []
     var arrayquarter2: [Any] = []
     var arrayquarter3: [Any] = []
     var arrayquarter4: [Any] = []
     var arraythird: [Any] = []
     var arrayfinal: [Any] = []
    
    var mainArray: [[Any]] = []
    var abc = ["a","b","c"]
   public var semifinal1 = [String : Any]()
    var semifinal2 = [String : Any]()
    var quarterfinal1 = [String : Any]()
    var quarterfinal2 = [String : Any]()
    var quarterfinal3 = [String : Any]()
    var quarterfinal4 = [String : Any]()
    var matchthird = [String: Any]()
    var matchfinal = [String: Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (WCSession.isSupported()) {
            
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
        else{
           print ("not able to connect to watch")
        }
        
     
        let URL = "https://matchapi.firebaseio.com/matches.json"
        
        Alamofire.request(URL).responseJSON {
            response in
            let apiData = response.result.value
            if (apiData == nil) {
                print("Error when getting API data")
                return
            }
           
            let jsonResponse = JSON(apiData!)
            //adding API data to dictionary variable
            self.semifinal1 = jsonResponse["semi-final"][0].dictionary as! [String : Any]
            self.semifinal2 = jsonResponse["semi-final"][1].dictionary as! [String : Any]
              self.quarterfinal1 = jsonResponse["quarter-final"][0].dictionary as! [String : Any]
            self.quarterfinal2 = jsonResponse["quarter-final"][1].dictionary as! [String : Any]
            self.quarterfinal3 = jsonResponse["quarter-final"][2].dictionary as! [String : Any]
            self.quarterfinal4 = jsonResponse["quarter-final"][3].dictionary as! [String : Any]
            self.matchthird = jsonResponse["match of third place"][0].dictionary as! [String : Any]
            self.matchfinal = jsonResponse["final"][0].dictionary as! [String : Any]
            
            
            //FillIng arrays
            self.arraysemi1 = [self.semifinal1["date"]!,self.semifinal1["time"]!,self.semifinal1["location"]!,self.semifinal1["teama"]!,self.semifinal1["teamb"]!]
            self.arraysemi2 = [self.semifinal2["date"]!,self.semifinal2["time"]!,self.semifinal2["location"]!,self.semifinal2["teama"]!,self.semifinal1["teamb"]!]
            self.arrayquarter1 = [self.quarterfinal1["date"]!,self.quarterfinal1["time"]!,self.quarterfinal1["location"]!,self.quarterfinal1["teama"]!,self.quarterfinal1["teamb"]!]
            self.arrayquarter2 = [self.quarterfinal2["date"]!,self.quarterfinal2["time"]!,self.quarterfinal2["location"]!,self.quarterfinal2["teama"]!,self.quarterfinal2["teamb"]!]
            
            self.arrayquarter3 = [self.quarterfinal3["date"]!,self.quarterfinal3["time"]!,self.quarterfinal3["location"]!,self.quarterfinal3["teama"]!,self.quarterfinal3["teamb"]!]
            self.arrayquarter4 = [self.quarterfinal4["date"]!,self.quarterfinal4["time"]!,self.quarterfinal4["location"]!,self.quarterfinal4["teama"]!,self.quarterfinal4["teamb"]!]
            self.arraythird = [self.matchthird["date"]!,self.matchthird["time"]!,self.matchthird["location"]!,self.matchthird["teama"]!,self.matchthird["teamb"]!]
            self.arrayfinal = [self.matchfinal["date"]!,self.matchfinal["time"]!,self.matchfinal["location"]!,self.matchfinal["teama"]!,self.matchfinal["teamb"]!]
            
            self.mainArray.append(self.arraysemi1)
            self.mainArray.append(self.arraysemi2)
            self.mainArray.append(self.arrayquarter1)
            self.mainArray.append(self.arrayquarter2)
            self.mainArray.append(self.arrayquarter3)
            self.mainArray.append(self.arrayquarter4)
            self.mainArray.append(self.arraythird)
            self.mainArray.append(self.arrayfinal)
         
            
        }
    }
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return mainArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "singleRow", for: indexPath) as? TableCell //make the cell
            
     //date
            cell?.lb1.text = ("\(mainArray[indexPath.row][0])")
           //time
            cell?.lb2.text = ("\(mainArray[indexPath.row][1])")
            //loc
            cell?.lb3.text = ("\(mainArray[indexPath.row][2])")
        //team a flag
              cell?.imgLeft.image  =  UIImage(named: "\(mainArray[indexPath.row][3])")
            //team b flag
            cell?.imgRight.image  =  UIImage(named: "\(mainArray[indexPath.row][4])")
    
            
            return cell!
}
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (WCSession.default.isReachable) {
            // construct the message you want to send
            // the message is in dictionary
           // let msg = mainArray[0][0]
            do{
                try WCSession.default.updateApplicationContext(["key" : semifinal1])
            }
            catch{
                print(error)
            }
        }

    }

    

}
   

