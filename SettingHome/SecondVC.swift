//
//  SecondVC.swift
//  SettingsUI
//
//  Created by MAC on 14/10/20.
//

import UIKit

class SecondVC: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var clickedImage: UIImageView!
    var textData = String()
    var image = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = textData
        clickedImage.image = image
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = textData
        navigationController?.navigationItem.backButtonTitle = "Back"
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
