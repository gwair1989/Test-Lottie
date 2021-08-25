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


class ViewController: UIViewController {
    
    @objc let prog = Progress()
    var timerObserv = Timer()
    var timerMessege = Timer()
    let imageForLabel = UIImageView()
    let messegeLabel = UILabel()
    let lottie = AnimationView()
    let progressBar = UIProgressView()
    let animation = Animation.named("appstart_loading_tray")
    let messegeArray = ["Loading deals and more.", "Working on it.", "Apologies for the wait.", "Thanks for holding out.", "Will be with you shortly.", "Just a few more moments."]
    var progObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        lottie.animation = animation
        lottie.play()
        observation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timerObserv.invalidate()
        timerMessege.invalidate()
    }
    
    func observation(){
        var count = 0
        progObservation = observe(\ViewController.prog.prog, options: .new) { vc, change in
            if let updateProg = change.newValue {
                count = 0
                self.timerObserv.invalidate()
                self.timerObserv = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { timerInBlock in
                    count += 1
                    if count == 3{
                        DispatchQueue.main.async {
                        self.showMessege()
                        }
                    }
                })
            }
        }
    }
    
    func showMessege(){
            self.imageForLabel.isHidden = false
            self.messegeLabel.isHidden = false
            self.changeMessege()
    }
    func changeMessege(){
        var count = 1
        timerMessege = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (timerInBlock) in
            
            if count == self.messegeArray.count{
                count = 0
            }
            self.messegeLabel.text = self.messegeArray[count]
            count += 1
            
                self.updateProgress(progress: Float(count))
            
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
    
    

enum Inset {
    case top(CGFloat = 0, Bool = false)
    case bottom(CGFloat = 0, Bool = false)
    case left(CGFloat = 0, Bool = false)
    case right(CGFloat = 0, Bool = false)
    case leading(CGFloat = 0, Bool = false)
    case trailing(CGFloat = 0, Bool = false)
    case width(CGFloat = 0)
    case height(CGFloat = 0)
    case constraint(NSLayoutConstraint)
    case centerX(CGFloat = 0)
    case centerY(CGFloat = 0)
    case heightGreater(CGFloat)
    case widthGreater(CGFloat)
    case heightless(CGFloat)
    case widthLess(CGFloat)

    static var fill: [Inset] = [.top(0), .bottom(0), .left(0), .right(0)]
}



extension UIView {
    
    func handleInsets(_ insets: [Inset], superView: UIView, priority: UILayoutPriority) {
        let mapped = insets.compactMap { (inset) -> NSLayoutConstraint in
            switch inset {
            case .top(let inset, let safeArea):
                if safeArea {
                    return topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: inset)
                } else {
                    return topAnchor.constraint(equalTo: superView.topAnchor, constant: inset)
                }
            case .bottom(let inset, let safeArea):
                if safeArea {
                    return bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: inset)
                } else {
                    return bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: inset)
                }
            case .left(let inset, let safeArea):
                if safeArea {
                    return leftAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leftAnchor, constant: inset)
                } else {
                    return leftAnchor.constraint(equalTo: superView.leftAnchor, constant: inset)
                }
            case .right(let inset, let safeArea):
                if safeArea {
                    return rightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.rightAnchor, constant: inset)
                } else {
                    return rightAnchor.constraint(equalTo: superView.rightAnchor, constant: inset)
                }
            case .leading(let inset, let safeArea):
                if safeArea {
                    return leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor, constant: inset)
                } else {
                    return leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: inset)
                }
            case .trailing(let inset, let safeArea):
                if safeArea {
                    return trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor, constant: inset)
                } else {
                    return trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: inset)
                }
            case .width(let width):
                return widthAnchor.constraint(equalToConstant: width)
            case .height(let height):
                return heightAnchor.constraint(equalToConstant: height)
            case .constraint(let constaint):
                return constaint
            case .centerX(let offset):
                return centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: offset)
            case .centerY(let offset):
                return centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: offset)
            case .heightGreater(let value):
                return heightAnchor.constraint(greaterThanOrEqualToConstant: value)
            case .widthGreater(let value):
                return widthAnchor.constraint(greaterThanOrEqualToConstant: value)
            case .heightless(let value):
                return heightAnchor.constraint(lessThanOrEqualToConstant: value)
            case .widthLess(let value):
                return widthAnchor.constraint(lessThanOrEqualToConstant: value)
            }
        }
        mapped.forEach { $0.priority = priority }
        NSLayoutConstraint.activate(mapped)
    }
}
