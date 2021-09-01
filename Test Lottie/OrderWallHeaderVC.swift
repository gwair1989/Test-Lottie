//
//  OrderWallHeaderVC.swift
//  Test Lottie
//
//  Created by Aleksandr Khalupa on 30.08.2021.
//

import UIKit
import FirebaseRemoteConfig

class OrderWallHeaderVC: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var secondView: UIView!
    
    let remoteConfig = FirebaseRemoteConfig.RemoteConfig.remoteConfig()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        fetchConfig()

    }

    
    func fetchConfig(){
        remoteConfig.fetchAndActivate { (status, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if status != .error{
                    if let isShowHeaderView = self.remoteConfig["isShowHeaderView"].stringValue{
                        print("STATUS:-\(isShowHeaderView)-")
                        if isShowHeaderView == "false"{
                            self.stackView.removeArrangedSubview(self.secondView)
                        }
                    }
                }
            }
        }
        
    }
    
}
