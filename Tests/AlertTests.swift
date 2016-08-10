//
//  AlertTests.swift
//  ForecastIO
//
//  Created by Satyam Ghodasara on 1/23/16.
//
//

import XCTest
import Nimble
@testable import ForecastIO

class AlertTests: XCTestCase {
    
    var alertsJSON: NSArray!
    var alertsNoOptionalsJSON: NSArray!
    
    override func setUp() {
        super.setUp()
        
        let forecastJSONPath = Bundle(for: self.dynamicType).path(forResource: "forecast", ofType: "json")!
        let forecastJSONData = try! Data(contentsOf: URL(fileURLWithPath: forecastJSONPath))
        let forecastJSON = try! JSONSerialization.jsonObject(with: forecastJSONData, options: .mutableContainers) as! NSDictionary
        self.alertsJSON = forecastJSON["alerts"] as! NSArray
        
        let forecastNoOptionalsJSONPath = Bundle(for: self.dynamicType).path(forResource: "forecast_no_optionals", ofType: "json")!
        let forecastNoOptionalsJSONData = try! Data(contentsOf: URL(fileURLWithPath: forecastNoOptionalsJSONPath))
        let forecastNoOptionalsJSON = try! JSONSerialization.jsonObject(with: forecastNoOptionalsJSONData, options: .mutableContainers) as! NSDictionary
        self.alertsNoOptionalsJSON = forecastNoOptionalsJSON["alerts"] as! NSArray
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitFromJSON() {
        //  Given
        let alertJSON = self.alertsJSON[0] as! NSDictionary
        
        //  When
        let alert = Alert(fromJSON: alertJSON)
        
        //  Then
        expect(alert).toNot(beNil())
        expect(alert.title).to(equal("High Wind Warning for Baltimore, MD"))
        expect(alert.expires).to(equal(Date(timeIntervalSince1970: 1453593600)))
        expect(alert.uri.absoluteString).to(equal("http://alerts.weather.gov/cap/wwacapget.php?x=MD1255E4FAA7AC.HighWindWarning.1255E5079700MD.LWXNPWLWX.b0aa96f59630770f05e80c219b873fd2"))
        expect(alert.description).to(equal("...HIGH WIND WARNING REMAINS IN EFFECT UNTIL 7 PM EST THIS\nEVENING...\n* TIMING...THROUGH TODAY.\n* WINDS...NORTH 25 TO 35 MPH WITH GUSTS UP TO 55 MPH.\n* IMPACTS...DOWNED TREES...POWERLINES...AND MINOR STRUCTURAL\nDAMAGE. DRIVING HIGH PROFILE VEHICLES IN THESE CONDITIONS IS\nDANGEROUS.\n"))
    }
    
    func testInitNoOptionalsFromJSON() {
        //  Given
        let alertJSON = self.alertsNoOptionalsJSON[0] as! NSDictionary
        
        //  When
        let alert = Alert(fromJSON: alertJSON)
        
        //  Then
        expect(alert).toNot(beNil())
        expect(alert.title).to(equal("High Wind Warning for Baltimore, MD"))
        expect(alert.expires).to(equal(Date(timeIntervalSince1970: 1453593600)))
        expect(alert.uri.absoluteString).to(equal("http://alerts.weather.gov/cap/wwacapget.php?x=MD1255E4FAA7AC.HighWindWarning.1255E5079700MD.LWXNPWLWX.b0aa96f59630770f05e80c219b873fd2"))
        expect(alert.description).to(beNil())
    }
}
