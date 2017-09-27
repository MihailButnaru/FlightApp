//
//  GatwickContro.swift
//  FlightMe
//
//  Created by MIHAIL BUTNARU on 13/09/2017.
//  Copyright © 2017 MIHAIL BUTNARU. All rights reserved.
//

import UIKit


class Details {
    
    let category: String
//    let flightCarrier: String
//    let city: String
//    let destination: String
//    let isDeparture: Int
//    let flightNumber: Int
//    let terminal: String
    
    init(category: String){
        self.category = category
    }
    
}
// , UITableViewDataSource

class GatwickContro: UIViewController, UITableViewDataSource {

    var fetchDetails = [Details]()
    
    @IBOutlet weak var tableView: UITableView!
    
    var allFlightsArray = [AnyObject]()
    var destinationArray = [String]()
    var flightArray = [AnyObject]()
    var carrierArray = [String]()
    var terminalArray = [String]()
    var timeArray = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
     // API Gatwick is mixed with DATA // Departure & Arrivals
    func parseData(){
        fetchDetails = []
        let urlString = "https://www.gatwickairport.com/api/myGatwick/GetFlights"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { ( data,response, error) in
            if(error != nil){
                print("Error")
            }else{
                do{
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSDictionary
//                    print(fetchedData)
                    let data = fetchedData["detail"] as! NSArray
                    
                    for index in 0...data.count-1 {
                        let aObject = data[index] as! [String : AnyObject]
                        let aObject1 = aObject["data"] as! [String : AnyObject]
                        let category = aObject1["category"] as! String
                        let aObject2 = aObject1["flightInfo"] as! [String : AnyObject]
                        let flightCarrier = aObject2["flightCarrier"] as! String
                        let flightIsDeparture = aObject2["flightIsDeparture"] as! BooleanLiteralType
                        let flightDateTime = aObject2["flightDateTime"] as! String
                        
//                        
//                        print(category)
//                        print(flightCarrier)
//                        print(aObject2)
//                        print(flightIsDeparture)
//                        print(flightDateTime)
                        
                        self.allFlightsArray.append(aObject2 as! AnyObject)

                        
                    }
                    
                    
                    for flight in self.allFlightsArray{

                        self.carrierArray.append(flight["flightCarrier"] as! String)
                        let fnumber = flight["flightNumber"] as! String
                        let fdestination = flight["flightCity"] as! String
                        let fdatetime = flight["flightDateTime"] as! String
                        let fterminal = flight["flightTerminal"] as! String
                        
//                        print(fnumber)
//                        print(fdestination)
//                        print(fdatetime)
//                        print(fterminal)
                    }
                    
                    print(self.carrierArray)
                    OperationQueue.main.addOperation({
                        self.tableView.reloadData()
                    })
                    

                } catch{
                    print ("Error 2")
                }
            }

    }
        task.resume()
    
    
}
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.destination.text = "text"
        return cell
    }
    
    
}
 
