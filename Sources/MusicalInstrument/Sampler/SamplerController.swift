//
//  SamplerController.swift
//

import Foundation
import AVFoundation
import MusicSymbol

/// general controller of a sampler
public class SamplerController {
    
    /// init controller with given sampler
    public init(sampler: AVAudioUnitSampler) {
        self.sampler = sampler
    }
       
    /// play at pitch with velocity
    public func play(at pitch: Pitch, with velocity: UInt8) {
        sampler.startNote(UInt8(pitch.rawValue),
                          withVelocity: velocity,
                          onChannel: 0)
        pitchInQueue.insert(pitch)
    }
    
    /// stop note
    public func stop(at pitch: Pitch) {
        sampler.stopNote(UInt8(pitch.rawValue), onChannel: 0)
        pitchInQueue.remove(pitch)
    }
    
    /// stop all notes
    public func stopAll() {
        for pitch in pitchInQueue {
            sampler.stopNote(UInt8(pitch.rawValue), onChannel: 0)
        }
        pitchInQueue.removeAll()
    }
    
    /// send controller signal
    public func sendController(_ controller: UInt8, withValue value: UInt8) {
        sampler.sendController(controller, withValue: value, onChannel: 0)
    }
    
    deinit {
        stopAll()
    }
    
    /// private
    
    private var sampler: AVAudioUnitSampler
    private var pitchInQueue: Set<Pitch> = Set<Pitch>()
}


