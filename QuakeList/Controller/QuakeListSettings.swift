//
//  QuakeListSettings.swift
//  QuakeList
//
//  Created by Frosty on 11/25/17.
//  Copyright © 2017 repgarden. All rights reserved.
//

import UIKit
import MessageUI

class Settings: UITableViewController,  MFMailComposeViewControllerDelegate {

    @IBAction func btnFeedback(_ sender: Any) {
        
        if MFMailComposeViewController.canSendMail() {
            sendEmail()
        }
        else {
            doAlert(title: "No Email Services Available", message: "Please configure at least one email account to send feedback.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //showFeedSetting
        if segue.identifier == "showFeedSetting" {
            //print("showFeedSetting")
        }
    }
    
    func sendEmail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as MFMailComposeViewControllerDelegate
            mail.setToRecipients([feedbackEmail])
            mail.setSubject("Feedback From What's Shakin iOS App")
            //mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            present(mail, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        //controller.dismiss(animated: true)
        controller.dismiss(animated: true, completion: {
            if result == .sent {
                self.doAlert(title: "Thank You", message: "Your feedback is appreciated")
            }
        })
    }
    
    func doAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
        }))
        
        present(alert, animated: true, completion: nil)
    }
}
