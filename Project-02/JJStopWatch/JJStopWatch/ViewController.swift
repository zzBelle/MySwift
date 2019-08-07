//
//  ViewController.swift
//  JJStopWatch
//
//  Created by admin on 2019/8/6.
//  Copyright © 2019 JJ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    fileprivate let mainStopWatch: JJStopWatch = JJStopWatch()
    fileprivate let lapStopWatch: JJStopWatch = JJStopWatch()
    fileprivate var isPlay: Bool = false
    fileprivate var laps: [String] = []
    
    //ui
    @IBOutlet weak var lapTableView: UITableView!
    @IBOutlet weak var lapRestBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let initCircleBtn: (UIButton) -> Void = { button in button.layer.cornerRadius = 0.5 * button.bounds.size.width
            button.backgroundColor = UIColor.white
        }
        
        initCircleBtn(pauseBtn)
        initCircleBtn(lapRestBtn)
        
        lapRestBtn.isEnabled = false
        lapTableView.delegate = self
        lapTableView.dataSource = self
    
    }

    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    
    @IBAction func playPauseTimer(_ sender: AnyObject) {
        lapRestBtn.isEnabled = true
        changeButton(lapRestBtn, title: "Lap", titleColor: UIColor.black)
        if !isPlay {
            unowned let weakSelf = self
            
            mainStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(mainStopWatch.timer, forMode: RunLoop.Mode.common)
            RunLoop.current.add(lapStopWatch.timer, forMode: RunLoop.Mode.common)
            isPlay = true
            changeButton(pauseBtn, title: "Stop", titleColor: UIColor.red)
        }else {
            mainStopWatch.timer.invalidate()
            lapStopWatch.timer.invalidate()
            isPlay = false
            changeButton(pauseBtn, title: "Start", titleColor: UIColor.green)
            changeButton(lapRestBtn, title: "Reset", titleColor: UIColor.black)
        }
    }
    
    @IBAction func lapResetTimer(_ sender: AnyObject) {
        if !isPlay {
            resetMainTimer()
            resetLapTimer()
            changeButton(lapRestBtn, title: "Lap", titleColor: UIColor.lightGray)
            lapRestBtn.isEnabled = false
        } else {
            if let timerLabeltext = timeLabel.text {
                laps.append(timerLabeltext)
            }
            lapTableView.reloadData()
            resetLapTimer()
            unowned let weakSelf = self
            lapStopWatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            
            RunLoop.current.add(lapStopWatch.timer, forMode: RunLoop.Mode.common)
        }
    }
    
    fileprivate func changeButton(_ button: UIButton, title: String, titleColor: UIColor) {
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(titleColor, for: UIControl.State())
    }
    
    fileprivate func resetMainTimer() {
        resetTimer(mainStopWatch, label: timeLabel)
        laps.removeAll()
        lapTableView.reloadData()
    }
    
    fileprivate func resetLapTimer() {
        resetTimer(lapStopWatch, label: lapTimerLabel)
    }
    
    fileprivate func resetTimer(_ stopWatch: JJStopWatch, label: UILabel) {
        stopWatch.timer.invalidate()
        stopWatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    @objc func updateMainTimer() {
        updateTimer(mainStopWatch, label: timeLabel)
    }
    
    @objc func updateLapTimer() {
        updateTimer(lapStopWatch, label: lapTimerLabel)
    }
    
    @objc func updateTimer(_ stopWatch: JJStopWatch, label: UILabel) {
        stopWatch.counter = stopWatch.counter + 0.035
        var minutes: String = "\((Int)(stopWatch.counter / 60))"
        if (Int)(stopWatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopWatch.counter / 60))"
        }
        
        var seconds: String = String(format: "%.2f", (stopWatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopWatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        
        label.text = minutes + ":" + seconds
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identfier: String = "lapCell"
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identfier, for: indexPath)
        if let  labelNum = cell.viewWithTag(11) as? UILabel {
            labelNum.text = "Lap \(laps.count - (indexPath as NSIndexPath).row)"
        }
    
        if let labelTimer = cell.viewWithTag(12) as? UILabel {
            labelTimer.text = laps[laps.count - (indexPath as NSIndexPath).row - 1]
        }
        
        return cell
    }
}

fileprivate extension Selector {
    static let updateMainTimer = #selector(ViewController.updateMainTimer)
    static let updateLapTimer = #selector(ViewController.updateLapTimer)
}
