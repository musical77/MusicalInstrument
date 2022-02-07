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
    /// In MIDI systems, the activation of a particular note and the release of the same note are considered as two separate events. When a key is pressed on a MIDI keyboard instrument or MIDI keyboard controller, the keyboard sends a Note On message on the MIDI OUT port. The keyboard may be set to transmit on any one of the sixteen logical MIDI channels, and the status byte for the Note On message will indicate the selected Channel number. The Note On status byte is followed by two data bytes, which specify key number (indicating which key was pressed) and velocity (how hard the key was pressed).
    /// The key number is used in the receiving synthesizer to select which note should be played, and the velocity is normally used to control the amplitude of the note. When the key is released, the keyboard instrument or controller will send a Note Off message. The Note Off message also includes data bytes for the key number and for the velocity with which the key was released. The Note Off velocity information is normally ignored.
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
    /// MIDI Control Change messages are used to control a wide variety of functions in a synthesizer. Control Change messages, like other MIDI Channel messages, should only affect the Channel number indicated in the status byte. The Control Change status byte is followed by one data byte indicating the "controller number", and a second byte which specifies the "control value". The controller number identifies which function of the synthesizer is to be controlled by the message. A complete list of assigned controllers is found in the MIDI 1.0 Detailed Specification.
    public func sendController(_ controller: UInt8, withValue value: UInt8) {
        sampler.sendController(controller, withValue: value, onChannel: 0)
    }
    
    /// Some MIDI keyboard instruments have the ability to sense the amount of pressure which is being applied to the keys while they are depressed. This pressure information, commonly called "aftertouch", may be used to control some aspects of the sound produced by the synthesizer (vibrato, for example). If the keyboard has a pressure sensor for each key, then the resulting "polyphonic aftertouch" information would be sent in the form of Polyphonic Key Pressure messages. These messages include separate data bytes for key number and pressure amount. It is currently more common for keyboard instruments to sense only a single pressure level for the entire keyboard. This "Channel aftertouch" information is sent using the Channel Pressure message, which needs only one data byte to specify the pressure value.
    public func sendPressure(pressure: UInt8) {
        sampler.sendPressure(pressure, onChannel: 0)
    }
    
    deinit {
        stopAll()
    }
    
    /// private
    
    private var sampler: AVAudioUnitSampler
    private var pitchInQueue: Set<Pitch> = Set<Pitch>()
    
    public static let VOLUME_CONTROL: UInt8 = 7
    public static let PEDAL_CONTROL: UInt8 = 64
}


