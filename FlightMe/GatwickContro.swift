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

class GatwickContro: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var fetchDetails = [Details]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gatwickSegmentedControl: UISegmentedControl!
    
    // Array with all the data API
    var allFlightsArray = [AnyObject]()
    
    //Departure
    var destinationArray = [String]()
    var flightArray = [AnyObject]()
    var flightNumber = [String]()
    var carrierArray = [String]()
    var terminalArray = [String]()
    var timeArray = [String]()
    var flightTerminal = [String]()
    var yesOrNo = [Bool]()
    
    
    // Arrivals
    var destinationA = [String]()
    var flightNumberA = [String]()
    var carrierA = [String]()
    var timeA = [String]()
    var flightTerminalA = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func removeDuplicates(array: [AnyObject]) -> [AnyObject]{
        var encountered = Set<String>()
        var result: [AnyObject] = []
        for value in self.allFlightsArray {
            if encountered.contains(value["flightNumber"] as! String){
                
            }else{
                encountered.insert(value["flightNumber"] as! String)
                result.append(value["flightNumber"] as! AnyObject)
            }
        }
        return result
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
                    let data = fetchedData["detail"] as! NSArray
                    
                    for index in 0...data.count-1 {
                        let aObject = data[index] as! [String : AnyObject]
                        let aObject1 = aObject["data"] as! [String : AnyObject]
                        let category = aObject1["category"] as! String
                        let aObject2 = aObject1["flightInfo"] as! [String : AnyObject]
                        
//                        let flightCarrier = aObject2["flightCarrier"] as! String
//                        let flightIsDeparture = aObject2["flightIsDeparture"] as! BooleanLiteralType
//                        let flightDateTime = aObject2["flightDateTime"] as! String
//                        print(category)
//                        print(flightCarrier)
//                        print(aObject2)
//                        print(flightIsDeparture)
//                        print(flightDateTime)
                        
                        self.allFlightsArray.append(aObject2 as! AnyObject)

                        
                    }
                    let rDuplicates = self.removeDuplicates(array: self.allFlightsArray)
                    print(rDuplicates)
                    
                        
                        for flight in self.allFlightsArray{
                            let arrOrDep = flight["flightIsDeparture"] as! BooleanLiteralType
                            
                            if arrOrDep == false {
                                
                                self.carrierArray.append(flight["flightCarrier"] as! String)
                                self.destinationArray.append(flight["flightCity"] as! String)
                                self.timeArray.append(flight["flightDateTime"] as! String)
                                self.flightNumber.append(flight["flightNumber"] as! String)
                                self.flightTerminal.append(flight["flightTerminal"] as! String)
                                self.yesOrNo.append(flight["flightIsDeparture"] as! BooleanLiteralType)
                            
                            }else{
                                
                                self.carrierA.append(flight["flightCarrier"] as! String)
                                self.destinationA.append(flight["flightCity"] as! String)
                                self.timeA.append(flight["flightDateTime"] as! String)
                                self.flightNumberA.append(flight["flightNumber"] as! String)
                                self.flightTerminalA.append(flight["flightTerminal"] as! String)
                                
                            }
                    }
//                    print(self.destinationArray)
//                    print(self.carrierArray)
//                    print(self.timeArray)
//                    print(self.flightNumber)
//                    print(self.flightTerminal)
//                      print(self.yesOrNo)
                    
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
        
        var returnValue = 0
        switch(gatwickSegmentedControl.selectedSegmentIndex){
        case 0:
            returnValue = self.carrierArray.count
            break
        case 1:
            returnValue = self.carrierA.count
            break
        default:
            break
        }
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        switch(gatwickSegmentedControl.selectedSegmentIndex){
        case 0:
            cell.destination.text = destinationArray[indexPath.row]
            cell.terminal.text = flightTerminal[indexPath.row]
            cell.time.text = timeArray[indexPath.row]
            cell.location.text = flightNumber[indexPath.row]
            cell.company.text = carrierArray[indexPath.row]
            break
        case 1:
            cell.destination.text = destinationA[indexPath.row]
            cell.terminal.text = flightTerminalA[indexPath.row]
            cell.time.text = timeA[indexPath.row]
            cell.location.text = flightNumberA[indexPath.row]
            cell.company.text = carrierA[indexPath.row]
            break
        default:
            break
        }
        
        
        return cell
    }
   
    // Function Action SegmentedController
    
    @IBAction func segmentAciton(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tableView.reloadData()
        }else{
            tableView.reloadData()
        }
    }
    
    
    
}
 
