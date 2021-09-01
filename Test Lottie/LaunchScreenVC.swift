//
//  ViewController.swift
//  Test Lottie
//
//  Created by Aleksandr Khalupa on 23.08.2021.
//

import UIKit
import Lottie


class Progress: NSObject {
    @objc dynamic var prog = Float()
}


class LaunchScreenVC: UIViewController {
    
    @objc let prog = Progress()
    var timerObserv = Timer()
    var timerMessege = Timer()
    let imageForLabel = UIImageView()
    let messegeLabel = UILabel()
    let lottie = AnimationView()
    let progressBar = UIProgressView()
    let animation = Animation.named("appstart_loading_tray")
    let messegeArray = ["Loading deals and more.", "Working on it.", "Apologies for the wait.", "Thanks for holding out.", "Will be with you shortly.", "Just a few more moments."]
    //    var progObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        lottie.animation = animation
        lottie.play()
        showMessege()
        //        observation()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        timerObserv.invalidate()
//        timerMessege.invalidate()
//    }
    
    //    func observation(){
    //        var count = 0
    //        progObservation = observe(\ViewController.prog.prog, options: .new) { vc, change in
    //            if let updateProg = change.newValue {
    //                count = 0
    //                self.timerObserv.invalidate()
    //                self.timerObserv = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { timerInBlock in
    //                    count += 1
    //                    if count == 3{
    //                        DispatchQueue.main.async {
    //                        self.showMessege()
    //                        }
    //                    }
    //                })
    //            }
    //        }
    //    }
    
    func showMessege(){
        self.imageForLabel.isHidden = false
        self.messegeLabel.isHidden = false
        self.changeMessege()
    }
    func changeMessege(){
        var countMessege = 0
        timerMessege = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timerInBlock) in
            
            if countMessege != self.messegeArray.count - 1{
                countMessege += 1
                self.messegeLabel.text = self.messegeArray[countMessege]
                self.updateProgress(progress: Float(countMessege))
                print(countMessege)
            }else{
                self.timerMessege.invalidate()
                self.performSegue(withIdentifier: "toOrderWallHeaderVC", sender: self)
            }
        })
        
    }
    
    
    func updateProgress(progress: Float) {
        progressBar.setProgress(progress / Float(messegeArray.count) , animated: true)
        prog.prog = progress
        if progress == Float(messegeArray.count){
            lottie.stop()
        }
    }
    
    
    func setUI(){
        
        view.addSubview(progressBar)
        view.addSubview(lottie)
        view.addSubview(imageForLabel)
        view.addSubview(messegeLabel)
        
        lottie.translatesAutoresizingMaskIntoConstraints = false
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        messegeLabel.translatesAutoresizingMaskIntoConstraints = false
        imageForLabel.translatesAutoresizingMaskIntoConstraints = false
        
        lottie.handleInsets([.centerX(0), .height(300), .width(300)], superView: view, priority: .required)
        
        progressBar.handleInsets([.centerX(0), .centerY(34), .width(236), .height(6)], superView: view, priority: .required)
        
        lottie.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: 50).isActive = true
        
        imageForLabel.handleInsets([.centerX(0), .centerY(80), .width(236), .height(41)], superView: view, priority: .required)
        imageForLabel.image = UIImage(named: "massage")
        imageForLabel.isHidden = true
        
        messegeLabel.handleInsets([.centerX(0), .centerY(4), .width(188), .height(17) ], superView: imageForLabel, priority: .required)
        messegeLabel.text = messegeArray.first
        messegeLabel.font = UIFont.systemFont(ofSize: 14.0)
        messegeLabel.textAlignment = .center
        messegeLabel.isHidden = true
        messegeLabel.numberOfLines = 0
        
        
        progressBar.progressTintColor = .yellow
        lottie.loopMode = .loop
        lottie.play()
        
        view.backgroundColor = .white
        
    }
}



