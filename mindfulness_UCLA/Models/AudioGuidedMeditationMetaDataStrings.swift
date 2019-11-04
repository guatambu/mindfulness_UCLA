//
//  AudioGuidedMeditationMetaDataStrings.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/25/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

enum AudioGuidedMeditationMetaDataStrings: String {
    
    // 1
    case bodyScanMeditationTitle = "bodyscan meditation (32 min)"
    case bodyScanMeditationPath = "bodyscan"
    case bodyScanMeditationDuration = "32:56"
    
    // 2
    case sittingMeditationTitle = "sitting meditation (32 min)"
    case sittingMeditationPath = "sittingmeditation"
    case sittingMeditationDuration = "32:00"
    
    // 3
    case difficultEmotionsMeditationTitle = "turning toward meditation for difficult emotions (22 min)"
    case difficultEmotionsMeditationPath = "turning-toward-emotional (1)"
    case difficultEmotionsMeditationDuration = "23:08"
    
    // 4
    case physicalPainMeditaitonTitle = "turning toward meditation for physical pain (25 min)"
    case physicalPainMeditaitonPath = "turning-toward-physical"
    case physicalPainMeditaitonDuration = "24:31"
    
    // 5
    case mountainMeditationTitle = "mountain meditation (20 min)"
    case mountainMeditationPath = "mountain"
    case mountainMeditationDuration = "19:59"
    
    // 6
    case lakeMeditationTitle = "lake meditation (20 min)"
    case lakeMeditationPath = "lake"
    case lakeMeditationDuration = "20:05"
    
    // 7
    case lovingkindnessMeditaitonTitle = "lovingkindness meditation (13 min)"
    case lovingkindnessMeditaitonPath = "lovingkindness"
    case lovingkindnessMeditaitonDuration = "13:17"
    
    // 8
    case softenSootheAllowMeditationTitle = "\"soften, soothe, allow\" meditation (15 min)"
    case softenSootheAllowMeditationPath = "soften-soothe-allow"
    case softenSootheAllowMeditationDuration = "16:01"
    
    // 9
    case RAINMeditationTitle = "RAIN meditation (11 min)"
    case RAINMeditationPath = "RAIN"
    case RAINMeditationDuration = "10:41"
    
    // 10
    case silent30minGuidedMeditationTitle = "silent meditation (30 min)"
    case silent30minGuidedMeditationPath = "silent30min_guided_meditation_audio_file"
    case silent30minGuidedMeditationDuration = "30:19"
    
    // local notification content strings
    
    // using for notification.id property
    case meditationDone = "meditation done" // we may need more than one, maybe not
    // message / subTitle
    case hopeYouEnjoyedIt = "hope you enjoyed it"
    // for the notification sound path
    case tibetanBells = "tibetan-bells-end-meditation-timer"
    case part1 = "-part 1"
    case part2 = "-part 2"
    case part3 = "-part 3"
    case part4 = "-part 4"
    case soundFileType = ".mp3"
    
    
}

