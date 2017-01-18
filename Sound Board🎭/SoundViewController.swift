//
//  SoundViewController.swift
//  Sound Board🎭
//
//  Created by Marc Streeter on 1/18/17.
//  Copyright © 2017 Developer Warriors. All rights reserved.
//

import UIKit

import AVFoundation

class SoundViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
  
    @IBOutlet weak var recordButton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupRecorder()
    }

    func setupRecorder() {
   
        do {
    //Create an audio session
    let session = AVAudioSession.sharedInstance()
       try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
      try session.overrideOutputAudioPort(.speaker)
      try session.setActive(true)
        
    // Create URL for the audio file
        
    // Create settiongs for the audio recorder
        
    // Create AudioRecorder object
   
    audioRecorder = AVAudioRecorder(url: <#T##URL#>, settings: <#T##[String : Any]#>)
        } catch let error as NSError {
             print(error)
        }
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
    }
    
    @IBAction func playTapped(_ sender: Any) {
    }

    @IBAction func addTapped(_ sender: Any) {
    }
    
}
