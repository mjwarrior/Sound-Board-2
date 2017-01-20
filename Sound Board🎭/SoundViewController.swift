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

    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
  
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var addButton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    var audioPLayer : AVAudioPlayer?
    var audioURL : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupRecorder()
   
        playButton.isEnabled = false
        addButton.isEnabled = false
        
    
    }

    func setupRecorder() {
   
        do {
    //Create an audio session
    let session = AVAudioSession.sharedInstance()
       try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
      try session.overrideOutputAudioPort(.speaker)
      try session.setActive(true)
        
    // Create URL for the audio file
    
       
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponenets = [basePath,"audio.m4a"]
             audioURL = NSURL.fileURL(withPathComponents: pathComponenets)!
           
            

    // Create settiongs for the audio recorder
            
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            
            
    // Create AudioRecorder object
   
    audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
       audioRecorder!.prepareToRecord()
        } catch let error as NSError {
             print(error)
        }
    }
    
    
    @IBAction func recordTapped(_ sender: Any) {
    
        if audioRecorder!.isRecording {
            
            //Stop the recording
            audioRecorder?.stop()
            //Change button title to record
            recordButton.setTitle("Record", for: .normal)
            playButton.isEnabled = true
             addButton.isEnabled = true
        } else {
            //Start the recording 
            audioPLayer?.stop()
            audioRecorder?.record()
            //Change button title to stop
            recordButton.setTitle("Stop", for: .normal)
        
            if audioRecorder!.isRecording {
                
                playButton.isEnabled = false
               
                
            }else{
             playButton.isEnabled = true
            }

       
        
        }
    
    
    
    
    
    
    }
    
    @IBAction func playTapped(_ sender: Any) {
        do {
        try audioPLayer = AVAudioPlayer(contentsOf: audioURL!)
        audioPLayer!.play()
        }catch {
            
        }
    }

    @IBAction func addTapped(_ sender: Any) {
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    let sound = Sound(context: context)
        
    sound.name = nameTextField.text
    sound.audio = NSData(contentsOf: audioURL!)
    
(UIApplication.shared.delegate as! AppDelegate).saveContext()
        
 navigationController!.popViewController(animated: true)
        
        
    }

    



}
