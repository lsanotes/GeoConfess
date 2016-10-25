//
//  Utility.swift
//  GeoConfess
//
//  Created by Yulian Dobrev on 4/6/16.
//  Copyright © 2016 KTO. All rights reserved.
//

import Foundation
import UIKit

protocol ShowAlertViewDelegate {
    func alertViewDidTapped(didTappedYes:Bool)
}

protocol ShowAlertViewPopVCDelegate {
    func alertViewPopVCDidTapped()
}

final class Utility: NSObject {
    
    static var alertViewDelegate:ShowAlertViewDelegate?
    static var alertViewPopVCDelegate:ShowAlertViewPopVCDelegate?
    
    // MARK: - Show Alert Method
	
    class  func showAlertWithPopVC(title:String, message:String,vc:UIViewController) {
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(15),
            
            ])
        let alertController = UIAlertController(title: ""  , message: message
            , preferredStyle: UIAlertControllerStyle.Alert)
        alertController.setValue(attributedString, forKey: "attributedTitle")
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){  (action) -> Void in
            self.alertViewPopVCDelegate?.alertViewPopVCDidTapped()
        }
        alertController.addAction(okAction)
        vc.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    class  func showAlertWithDismissVC(title:String, message:String,vc:UIViewController){
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(15),
            
            ])
        let alertController = UIAlertController(title: ""  , message: message
            , preferredStyle: UIAlertControllerStyle.Alert)
        alertController.setValue(attributedString, forKey: "attributedTitle")
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){  (action) -> Void in
            vc.navigationController?.popViewControllerAnimated(true)
        }
        alertController.addAction(okAction)
        vc.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class  func showYesNoAlert(title:String, message:String,vc:UIViewController){
        
        let attributedString = NSAttributedString(string: title, attributes: [
            NSFontAttributeName : UIFont.systemFontOfSize(15),
            
            ])
        let alertController = UIAlertController(title: ""  , message: message
            , preferredStyle: UIAlertControllerStyle.Alert)
        alertController.setValue(attributedString, forKey: "attributedTitle")
        let okAction = UIAlertAction(title: "YES", style: UIAlertActionStyle.Default){  (action) -> Void in
            self.alertViewDelegate?.alertViewDidTapped(true)
        }
        let noAction = UIAlertAction(title: "NO", style: UIAlertActionStyle.Default){  (action) -> Void in
            self.alertViewDelegate?.alertViewDidTapped(false)
        }
        
        alertController.addAction(noAction)
        alertController.addAction(okAction)
        
        vc.presentViewController(alertController, animated: true, completion: nil)
    }
}
