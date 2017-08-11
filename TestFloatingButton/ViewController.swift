//
//  ViewController.swift
//  TestFloatingButton
//
//  Created by Daniel Hjärtström on 2017-08-10.
//  Copyright © 2017 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FloatingButtonProtocol {

    @IBOutlet weak var tableView: UITableView!
    
    var floatButton: FloatingButton!
    
    var mockData = ["Monkey","Cat","Dog","Rat","Elephant","Giraffe","Alligator","Monkey","Cat","Dog","Rat","Elephant","Giraffe","Alligator", "Monkey","Cat","Dog","Rat","Elephant","Giraffe","Alligator"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        floatButton = FloatingButton(width: 70, height: 70, fillColor: UIColor.red, buttonShape: .FiveDot, hasShadow: true, animation: .Rotate)
        floatButton.delegate = self
        self.view.addSubview(floatButton)

    }
    
    func buttonPressed(isButtonSelected: Bool) {
        print("Button pressed")
        
        tableView.setEditing(isButtonSelected, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = mockData[indexPath.row]
        cell.backgroundColor = UIColor.colorForIndex(index: indexPath.row, ArrCount: mockData.count)
        return cell
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIColor {

    static func colorForIndex(index: Int, ArrCount: Int) -> UIColor {
        return UIColor(colorLiteralRed: Float(CGFloat(index) / CGFloat(ArrCount) * 0.9), green: 1.0, blue: 0.0, alpha: 1.0)
    }
}

