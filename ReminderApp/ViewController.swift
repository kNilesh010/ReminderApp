//
//  ViewController.swift
//  ReminderApp
//
//  Created by Nilesh Kumar on 03/01/22.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    var model = [myReminders]()

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Bell", style: .plain, target: self, action: #selector(sendNotificationss))
    }

    @IBAction func AddReminders(){
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Add") as? EntryViewController else {return}
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { titlet, subtitlet, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = myReminders(title: titlet, identifier: "id_\(titlet)", date: date)
                self.model.append(new)
                self.table.reloadData()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func sendNotificationss(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.scheduleTest()
            }else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func scheduleTest(){
        let content = UNMutableNotificationContent()
        content.title = "My Notification"
        content.body = "My new Notification. My new Notification. My new Notification. My new Notification."
        content.sound = .default
        
        let newDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: newDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "TestID", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if error != nil {
                    print (error?.localizedDescription)
            }
        }
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model[indexPath.row].title
        
        let formattedDate = model[indexPath.row].date

        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-dd-yyyy"
        cell.detailTextLabel?.text = formatter.string(from: formattedDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
}

struct myReminders{
    
    var title: String
    var identifier: String
    var date: Date
    
}
