//  AudioRecorder.swift
//
//  Copyright © 2022 live77.


import Foundation
import AVFoundation

import os


public class AudioRecorder {
    
    /// init
    public init(audioEngine: AudioEngine) {
        self.engine = audioEngine
    }
   
    /// start recording audio generated from the engine
    public func startRecording(saveTo url: URL) -> Bool {
        guard let mainMixerNode = engine.mainMixerNode else {
            logger.error("engine is not ready to record audio.")
            return false
        }
        
        logger.info("start recording, save to url: \(url)")
        let format = mainMixerNode.outputFormat(forBus: 0)
        let settings = format.settings
        let bufferSize = AVAudioFrameCount(format.sampleRate)
        
        logger.info("buffer size: \(bufferSize)")
        logger.info("record settings: \(settings)")
        
        var newSettings = settings
        newSettings[AVFormatIDKey] = kAudioFormatMPEG4AAC
        logger.info("new settings: \(newSettings)")
        
        // open audio file, with correct format
        do {
            file = try AVAudioFile(forWriting: url,
                                   settings: newSettings)
        } catch {
            logger.error("failed to create audio file: \(url)")
            return false
        }
        
        // write data
        mainMixerNode.installTap(onBus: 0, bufferSize: AVAudioFrameCount(bufferSize), format: format)
        { (buffer, time) in
            do {
                try self.file?.write(from: buffer);
            } catch { self.logger.error("Error: \(error.localizedDescription)") }
        }
        
        return true
    }
    
    /// stop recording, return recorded audio file
    public func stopRecording() -> URL? {
        guard let mainMixerNode = engine.mainMixerNode else {
            logger.error("engine is not ready to record audio.")
            return nil
        }
        
        mainMixerNode.removeTap(onBus: 0)
        let result = file?.url
        
        if result != nil {
            logger.info("stop recording, save to: \(result!)")
        }
        
        file = nil
        return result
    }
    
    // MARK: private
    
    /// inline audio engine
    private var engine: AudioEngine
    
    /// inline audio file
    private var file: AVAudioFile?
    
    private var logger = Logger(subsystem: "MusicalInstrument", category: "AudioRecorder")
}


