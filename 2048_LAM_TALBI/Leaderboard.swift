//
//  Leaderboard.swift
//  2048_LAM_TALBI
//
//  Created by admin on 13/04/2021.
//

import FirebaseDatabase
import UIKit

class Leaderboard: UIViewController {

    //let database = Database.database(url : "https://ios2048-default-rtdb.europe-west1.firebasedatabase.app").reference() ;
    @IBOutlet weak var retour: UIButton!;
    @IBOutlet weak var tableView: UITableView!;
    @IBAction func retourprec(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Leaderboard: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("you tapped me")
    }
}

extension Leaderboard: UITableViewDataSource{
           // Do any additional setup after loading the view.
    
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
   
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var valueArr: [Any];

        // test database fetch
        /*
        database.child("score").observeSingleEvent(of: .value, with : {snapshot in 
            guard let value = snapshot.value as? [String: Any] else {
                return
            }

            print("Value : \(value)")
            var i = 0
            for (index, val) in value{
                print(index)
                print(val)
                valueArr[i] = val
                i+=1
            }
            
        })*/

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "test"
        return cell
    }
    

}
