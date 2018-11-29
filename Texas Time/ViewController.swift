//
//  ViewController.swift
//  Texas Time
//
//  Created by Jonathan Kizer on 11/26/18.
//  Copyright © 2018 Jonathan Kizer. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {
    @IBOutlet weak var bannerView: GADBannerView!
    let synth = AVSpeechSynthesizer()
    
    let voiceCatalog = ["ar-sa", "en-gb", "cs-cz", "da-dk", "el-gr", "en-au", "pt-BR", "pt-pt", "zh-cn", "fr-fr", "he-il", "ko-kr", "de-de"]
    
    let timeZones = ["GMT+3", "GMT", "GMT+1", "GMT+1", "GMT+2", "GMT+10", "GMT-3", "GMT", "GMT+8", "GMT+1", "GMT+2", "GMT+9", "GMT+1"]
    
    @IBAction func acrossThePond(_ sender: Any) {
        let randomNum = Int.random(in: 0 ... voiceCatalog.count-1)
        print(randomNum)
        
        var date = Date()
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: timeZones[randomNum])
        formatter.dateFormat = "hh:mm"
        
        let stringDate = formatter.string(from: date)
        print(stringDate)
        
        
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        var minutes = calendar.component(.minute, from: date)

        
        let ouSucksString = "It's \(stringDate) and OU still sucks!"
        
        var ouSucksUtterance = AVSpeechUtterance(string: ouSucksString)
        ouSucksUtterance.rate = 0.54
        ouSucksUtterance.voice = AVSpeechSynthesisVoice(language: voiceCatalog[randomNum])
        synth.speak(ouSucksUtterance)

        
    }
    
    @IBAction func whatTime(_ sender: Any) {
        
        var date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        var minutes = calendar.component(.minute, from: date)
        if (hour > 12) {
            hour = hour - 12
        }
        
        let ouSucksString = "It's \(hour) \(minutes) and OU still sucks!"
        
        var ouSucksUtterance = AVSpeechUtterance(string: ouSucksString)
        ouSucksUtterance.rate = 0.54
        synth.speak(ouSucksUtterance)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bannerView.adUnitID = "ca-app-pub-8216941847396342/2680063141"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    

    

}


// ********************************//
/*
 DESIGNABLE CODE -- FOR DESIGNING UIBUTTONS
 */
// ********************************//
@IBDesignable
class DesignableView: UIButton {
    // Corner Radius.
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    //Background Color.
    @IBInspectable var backColor: UIColor? {
        didSet {
            backgroundColor = backColor
        }
    }
    //Border Width.
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    //Border Color.
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
