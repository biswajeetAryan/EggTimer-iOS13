//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var countdownTimer = Timer()
    let eggTimes = [ "Soft" : 5, "Medium" : 7, "Hard" : 12 ]
    var totalTime = 0
    var timePassed = 0
    var player: AVAudioPlayer?
    
    @IBOutlet weak var lableData: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    func startTimer() {
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        let val = sender.currentTitle!
        
        progressView.progress = 0
        lableData.text = val
        timePassed = 0
        
        countdownTimer.invalidate()
        totalTime = eggTimes[val]!
        startTimer()
    }
    
    @objc func updateTime() {
        if timePassed < totalTime {
            timePassed += 1
            progressView.progress = Float(timePassed)/Float(totalTime)
        }else{
            countdownTimer.invalidate()
            lableData.text = "Done!"
            playSound()
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
}
