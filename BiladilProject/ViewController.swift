//
//  ViewController.swift
//  HyperPayTest
//
//  Created by مصعب on 03/01/2019.
//  Copyright © 2019 مصعب. All rights reserved.
//

import UIKit
import SafariServices



class ViewController: UIViewController ,OPPCheckoutProviderDelegate {
    
    var transaction: OPPTransaction?
    var resurscepath:String = ""
    
    
    var safariVC: SFSafariViewController?
    
    let provider = OPPPaymentProvider(mode: OPPProviderMode.test)
    
    var checkoutProvider: OPPCheckoutProvider?
    
    var checkoutID:String = ""
    var packageID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        let merchantServerRequest = NSURLRequest(url: URL(string: "http://reemapp.com/reqcheckoutidios.php")!)
        //        URLSession.shared.dataTask(with: merchantServerRequest as URLRequest) { (data, response, error) in
        //            // TODO: Handle errors
        //            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
        // self.checkoutID = (json["id"] as? String)!
        //self.checkoutID =
        //  UserDefaults.standard.value(forKey: "CHECKOUT_ID")
        checkoutID = UserDefaults.standard.value(forKey: "CHECKOUT_ID") as! String
        packageID = UserDefaults.standard.value(forKey: "PACKAGE_ID") as! String
        
        
        print(checkoutID)
        //  print("hhhh" + self.checkoutID)
        
        let checkoutSettings = OPPCheckoutSettings()
        
        // Set available payment brands for your shop
        checkoutSettings.paymentBrands = ["VISA", "MASTER"]
        checkoutSettings.shopperResultURL = "com.iPrism.Biladl.payments://result"
        
        self.checkoutProvider = OPPCheckoutProvider(paymentProvider: self.provider, checkoutID: self.checkoutID, settings: checkoutSettings)
        
        self.checkoutProvider?.delegate = self
        
        
        self.checkoutProvider?.presentCheckout(forSubmittingTransactionCompletionHandler: { (transaction, error) in
            guard let transaction = transaction else {
                // Handle invalid transaction, check error
                return
            }
            
            self.transaction = transaction
            
            
            if self.transaction!.type == .synchronous {
                
                DispatchQueue.main.async {
                    
                    guard let checkoutID = self.transaction?.paymentParams.checkoutID else {
                        
                        
                        return
                    }
                    self.transaction = nil
                    
                    self.provider.requestCheckoutInfo(withCheckoutID: checkoutID) { (checkoutInfo, error) in
                        DispatchQueue.main.async {
                            guard let resourcePath = checkoutInfo?.resourcePath else {
                                
                                
                                
                                return
                            }
                            
                            
                            self.resurscepath = resourcePath
                            let defaults = UserDefaults.standard
                            defaults .set("YES", forKey: "PAYMENT_DONE")
                            self.navigationController?.popViewController(animated: false)
                            
                            
                        }
                    }
                    
                }
                
                
            } else if self.transaction!.type == .asynchronous {
                
                
                NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveAsynchronousPaymentCallback), name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
                
                
                
            } else {
                // Executed in case of failure of the transaction for any reason
            }
        }, cancelHandler: {
            // Executed if the shopper closes the payment page prematurely
            self.navigationController?.popViewController(animated: false)
        })
        
        //            }
        //            }.resume()
        
        
        
        
        
        
    }
    
    
    func getpaymentstatus() {
        
        
        print("Payment Success")
        
        
    }
    
    
    
    @objc func didReceiveAsynchronousPaymentCallback() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "AsyncPaymentCompletedNotificationKey"), object: nil)
        
        // THE app return to here
        
        
        self.checkoutProvider?.dismissCheckout(animated: true) {
            DispatchQueue.main.async {
                
                guard let checkoutID = self.transaction?.paymentParams.checkoutID else {
                    
                    
                    
                    print("Checkout ID is invalidh")
                    
                    return
                }
                self.transaction = nil
                
                self.provider.requestCheckoutInfo(withCheckoutID: checkoutID) { (checkoutInfo, error) in
                    DispatchQueue.main.async {
                        guard let resourcePath = checkoutInfo?.resourcePath else {
                            
                            
                            print("Checkout info is empty or doesn't contain resource path")
                            
                            return
                        }
                        
                        
                        self.resurscepath = resourcePath
                        
                        
                        let defaults = UserDefaults.standard
                        defaults .set("YES", forKey: "PAYMENT_DONE")
                        self.navigationController?.popViewController(animated: false)
                        
                        //   self.getpaymentstatus()
                        
                    }
                }
                
            }
            
        }
    }
    
    
    
}

