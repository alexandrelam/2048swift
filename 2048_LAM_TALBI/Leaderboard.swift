//
//  Leaderboard.swift
//  2048_LAM_TALBI
//
//  Created by admin on 13/04/2021.
//

import UIKit

class Leaderboard: UIViewController {

    @IBOutlet weak var retour: UIButton!;
    
    @IBAction func retourprec(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
