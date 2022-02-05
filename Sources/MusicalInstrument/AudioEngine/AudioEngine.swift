//  AudioEngine.swift
//
//  Copyright © 2022 live77.


import Foundation
import AVFoundation

import os


public class AudioEngine {
    
    /// return default audio engine based on muse score sound font
    public static var `default` : AudioEngine = {
        let url = Bundle.module.url(forResource: "GeneralUser_GS_v1_471", withExtension: "sf2")!
        return AudioEngine(soundBankUrl: url)!
    }()
    
    /// 初始化声音引擎
    public init?(soundBankUrl: URL) {
        engine = AVAudioEngine()
        
        guard createSamplers(soundBankUrl: soundBankUrl) else {
            logger.error("failed to create samplers")
            return nil
        }
        
        // connect sampler to mainMixer
        for sampler in samplerMap.values {
            engine!.attach(sampler)
            engine!.connect(sampler, to: engine!.mainMixerNode, format: nil)
        }
        
        // start engine
        if !start() {
            logger.error("failed to start sound engine")
            return nil
        }
    }
    
    ///
    deinit {
        stop()
    }
    
    /// main mixer node
    public var mainMixerNode: AVAudioMixerNode? {
        return engine?.mainMixerNode ?? nil
    }
    
    /// return sampler for given instrument
    public func sampler(_ instrument: InstrumentType) -> AVAudioUnitSampler? {
        return samplerMap[instrument]
    }
    
    // MARK: private
    
    /// start the audio engine
    private func start() -> Bool {
        guard engine != nil else {
            logger.error("engine is nil")
            return false
        }
        
        do {
            try engine!.start()
            logger.info("engine started.")
            return true
        } catch {
            logger.error("instrument sound engine, av audio engine start failed")
            return false
        }
    }
    
    /// stop the audio engine
    private func stop() {
        logger.info("audio engine stopped.")
        engine?.stop()
    }
    
    /// create samplers from given sound bank
    private func createSamplers(soundBankUrl: URL) -> Bool {
        let pianoSampler = AVAudioUnitSampler()
        let violinSampler = AVAudioUnitSampler()
        
        do {
            try pianoSampler.loadSoundBankInstrument(at: soundBankUrl,
                                                     program: gmPiano,
                                                     bankMSB: melodicBank,
                                                     bankLSB: 0)
            
            try violinSampler.loadSoundBankInstrument(at: soundBankUrl,
                                                      program: gmViolin,
                                                      bankMSB: melodicBank,
                                                      bankLSB: 0)
            
            samplerMap[.piano] = pianoSampler
            samplerMap[.violin] = violinSampler
            
            return true
        } catch {
            logger.error("failed to load sound bank")
            return false
        }
    }
    
    /// instrument type -> samplers
    private var samplerMap: [InstrumentType: AVAudioUnitSampler] = [:]
    
    /// inline audio engine
    private var engine: AVAudioEngine? = nil
    
    private let melodicBank: UInt8 = UInt8(kAUSampler_DefaultMelodicBankMSB)
    private let gmPiano: UInt8 = 2
    private let gmViolin: UInt8 = 41
    
    /// 录制的声音文件
    private var file: AVAudioFile?
    
    /// 日志
    private var logger = Logger(subsystem: "MusicalInstrument", category: "AudioEngine")
    
}

