//
//  CanvasViewController.swift
//  CanvasDemo
//
//  Created by Langtian Qin on 4/6/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {


    var trayOriginalCenter: CGPoint!
    var newFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    var ogsize:CGRect!

    @IBOutlet weak var trayView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func facePan(_ sender: UIPanGestureRecognizer) {

        let translation = sender.translation(in: view)
        if sender.state == .began{
            var imageView = sender.view as! UIImageView
            newFace = UIImageView(image: imageView.image)
            view.addSubview(newFace)
            let panGesture=UIPanGestureRecognizer(target:self,action: #selector(fakePan(sender:)))
            let rotationGesture=UIRotationGestureRecognizer(target:self,action:#selector(fakeRotate(sender:)))
            let tapGesture=UITapGestureRecognizer(target:self,action:#selector((fakeDbltap(sender:))))
            tapGesture.numberOfTapsRequired=2
            newFace.addGestureRecognizer(tapGesture)
            newFace.addGestureRecognizer(panGesture)
            newFace.addGestureRecognizer(rotationGesture)
            newFace.isUserInteractionEnabled=true

            newFace.center = imageView.center
            newlyCreatedFaceOriginalCenter = newFace.center
            newFace.center.y += trayView.frame.origin.y
            ogsize=newFace.frame
            UIView.animate(withDuration: 0.4, animations: {
                var ogx=self.newFace.frame.origin
                let screenSize: CGRect = UIScreen.main.bounds
                self.newFace.frame = CGRect(x: 0, y: 0, width: screenSize.height * 0.2, height: screenSize.height * 0.2)
                self.newFace.center=ogx
            })
        }
        else if sender.state == .changed{
            newFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended{
            UIView.animate(withDuration: 0.4, animations: {
                var ogx=self.newFace.frame.origin
                self.newFace.frame = self.ogsize
                self.newFace.center=ogx
            })
        }
    }
    
    @objc func fakeDbltap(sender:UITapGestureRecognizer){
        sender.view?.removeFromSuperview()
    }
    @objc func fakeRotate(sender:UIRotationGestureRecognizer){
        let rotation = sender.rotation
        let imageView = sender.view as! UIImageView
        imageView.transform.rotated(by: rotation)
        sender.rotation = 0
    }
    @objc func fakePan(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        if sender.state == .began{
            print("?")
            newFace = sender.view as! UIImageView // to get the face that we panned on.
            newlyCreatedFaceOriginalCenter = newFace.center
            UIView.animate(withDuration: 0.4, animations: {
                var ogx=self.newFace.frame.origin
                let screenSize: CGRect = UIScreen.main.bounds
                self.newFace.frame = CGRect(x: 0, y: 0, width: screenSize.height * 0.2, height: screenSize.height * 0.2)
                self.newFace.center=ogx
            })
        }
        else if sender.state == .changed{
            newFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended{
            UIView.animate(withDuration: 0.4, animations: {
                var ogx=self.newFace.frame.origin
                self.newFace.frame = self.ogsize
                self.newFace.center=ogx
            })
        }
    }
    
    @IBAction func didPanTry(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        var velocity = sender.velocity(in: view)
        let trayDownOffset: CGFloat!
        var trayUp: CGPoint!
        var trayDown: CGPoint!
        if sender.state == .began{
            trayOriginalCenter = trayView.center
        }
        else if sender.state == .changed{
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended{
            trayDownOffset = 160
            trayUp = trayView.center // The initial position of the tray
            trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
            if velocity.y>=0{
                UIView.animate(withDuration: 0.4, animations: {
                    self.trayView.center=trayDown
                    })
            }
            else{
                UIView.animate(withDuration: 0.4, animations: {
                    self.trayView.center=trayUp
                })
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
