//
//  ViewController.swift
//  UNNotifications
//
//  Created by Emin Kotan on 12.12.2018.
//  Copyright © 2018 Emin Kotan. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController {

     let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func triggerButton(_ sender: Any) {
        createNotfications()
    }
    
    func createNotfications() {
        // CONTENT
        let content = UNMutableNotificationContent() // Notifications'ı tanımla
        content.title = "Bildirimin başlığı" // bildirimin başlığı
        content.subtitle = "Bildirimin altbaşlığı" // bildirimin altbaşlığı
        content.body = "Bildirimin içeriği" // bildirimin içeriği
        content.sound = UNNotificationSound.default // bildirimin sesi
        
        // TRIGGER
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
       
        // CUSTOM ACTIONS
        
        // Define Action
        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "DeleteAction", title: "Delete", options: [.destructive])
        
        // Create Category
        let category = UNNotificationCategory(identifier: "MyNotificationsCategory", actions: [snoozeAction, deleteAction], intentIdentifiers: [], options: [])
        
        // Register Category
        center.setNotificationCategories([category])
        content.categoryIdentifier = "MyNotificationsCategory"
        
        // REQUEST
         let identifier = "FirstUserNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request) { (error) in
            if error != nil {
                print("Something wrong")
            }
        }
    }
        center.delegate = self
}

extension ViewController: UNUserNotificationCenterDelegate {
    
    // Uygulama açıkken bir bildirimin geldiğini belirtir.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    /// Uygulama açıkken gelen bildirimlerin ekranda gözükmesini sağlayan fonksiyon
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
