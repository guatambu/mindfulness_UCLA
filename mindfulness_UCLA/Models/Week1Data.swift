//
//  Week1Data.swift
//  mindfulness_UCLA
//
//  Created by Michael Guatambu Davis on 10/5/19.
//  Copyright © 2019 DunDak, LLC. All rights reserved.
//

import Foundation

struct Week1Data {
    
    static let courseContent = WeekCourseContent(
        lessonTitle: "Week 1 - Simple Awareness",
        lessonSubTitle: "Introduction to the Body Scan",
        introTextParagraph1: ("", "Now that you've experienced the Introduction and completed the *Getting Started Worksheet* (see *Getting Started*), you are ready to begin. $Welcome!$"),
        introTextParagraph2: ("", "#NOTE: The links to all the materials described below are given in the colored section at the bottom of the page. Although there are five videos to watch this week, once you start one, the others will automatically follow. Some of the videos have ads at the beginning. Revenue from these ads go to the original creators of the videos, not to Palouse Mindfulness.#"),
        introTextParagraph3: nil,
        videosTextParagraph1: ("videos", "The videos for this week begin with *The Power of Mindfulness*, in which Shauna Shapiro emphasizes the importance, not of just paying attention to our inner experience, #but paying attention with kindness.# In *Don't Try to be Mindful*, Daron Larson addresses a common misunderstanding about mindfulness practice, that if our meditation is not peaceful and free of thoughts, then we must be doing something wrong. In *Befriending Our Bodies*, Jon Kabat-Zinn talks about the importance of our relationship with our body in this course. The last video guides you through a *Raisin Meditation* using two ordinary raisins. $To get the most benefit out of this video, have two raisins and a glass of water with you so you can experience on your own what is described in the video.$"),
        videosTextParagraph2: nil,
        videosTextParagraph3: nil,
        readingsTextParagraph1: ("readings", "Each week, there are readings which are an important part of the program. This week, the main reading is about the *Body Scan Meditation* you will be doing for your 30 minutes of daily practice this week. *7 Myths of Meditation*, and *Why We Find It So Hard to Meditate* address common misunderstandings, including the idea that one must have a quiet mind to meditate successfully. *Mouthfuls of Mindfulness* describes a way of eating that is \"not directed by charts, tables, pyramids, or scales\"."),
        readingsTextParagraph2: nil,
        readingsTextParagraph3:  nil,
        dailyPracticesTextParagraph1: ("daily practices", "This week begins your 30-minute daily *Formal Practice*, which is the *Body Scan Meditation*. The audio guidance is available through the menu just to the left of this text under \"Guided Practices\". Below, you can see the link to the *Formal Practice sheet*, where you will be making brief notes about your practice. #[NOTE: If you will be completing this by hand, print the *PDF file*, but if you'd like to complete it on your computer, download the *WORD file*.]#"),
        dailyPracticesTextParagraph2: ("", "For the *Informal Practice* this week, it is suggested that you bring mindful awareness to some otherwise routine activity such as washing the dishes and/or eating a meal. At the end of each day, using the *Informal Practice sheet* you will be printing or downloading for this week (see below), take just five minutes or so to see if you can recall a daily activity which you brought awareness to that day."),
        dailyPracticesTextParagraph3: nil,
        miscellaneousTextParagraph1: ("supplementary reading", "In addition, each week will indicate some supplementary reading or viewing materials. Listed there are suggestions for background reading or viewing if you'd like to know more about a given week's topic. If weight-loss and healthy eating are of interest, see *Introduction to Mindful Eating* by Michelle DuVal, and *The Mindfulness-Based Eating Solution* by Lynn Rossy. *Managing Anxiety with Mindfulness* by Rachel Green specifically addresses test anxiety."),
        miscellaneousTextParagraph2: ("", "$OK, let's get started!$ #Below are your materials for this week#:"),
        miscellaneousTextParagraph3: nil,
        weekVideoURLList: [
            ("*The Power of Mindfulness* ~- Shauna Shapiro [13 min]~", "https://www.youtube.com/watch?v=IeblJdB2-Vo&list=PLbiVpU59JkVbNfFyAG4SrC8NGnC0-D4jg&index=1"),
            ("*Don't Try to be Mindful* ~- Daron Larson [12 min]~", "https://www.youtube.com/watch?v=Y_27l2hMYvE&index=2&list=PLbiVpU59JkVbNfFyAG4SrC8NGnC0-D4jg"),
            ("*Befriending Our Bodies* ~- Jon Kabat-Zinn [4 min]~", "https://www.youtube.com/watch?v=iS53roI_pWE&index=3&list=PLbiVpU59JkVbNfFyAG4SrC8NGnC0-D4jg"),
            ("*Raisin Meditation* ~- Dave Potter [12 min]~", "https://www.youtube.com/watch?v=_CZEEYMXr8Q&index=4&list=PLbiVpU59JkVbNfFyAG4SrC8NGnC0-D4jg")
        ],
        weekReadingURLList: [
            ("*The Body Scan Meditation* ~- Jon Kabat-Zinn~", "https://palousemindfulness.com/docs/bodyscan.pdf"),
            ("*7 Myths of Meditation* ~- Deepak Choprah~", "https://palousemindfulness.com/docs/seven-myths.pdf"),
            ("*Why We Find It So Hard to Meditate* ~- Mindful Staff~", "https://palousemindfulness.com/docs/why-we-find-it-hard.pdf"),
            ("*Mouthfuls of Mindfulness* ~- Jan Chozen Bays~", "https://palousemindfulness.com/docs/mouthfuls-mindfulness.pdf")
        ],
        supplementalMaterialsURLList: [
            ("*Introduction to Mindful Eating* ~video by Michelle DuVal [10 min]~", "http://www.youtube.com/watch?v=6tw93IgfL0U"),
            ("*The Mindfulness-Based Eating Solutiong* ~book by Lynn Rossy~", "https://palousemindfulness.com/art/LynnRossy-eating-solution.pdf"),
            ("*What Would It Take for You to Be Still?* ~article by Catherine Price~", "https://palousemindfulness.com/docs/what-would-it-take.pdf"),
            ("*An Apple as Past, Present and Future* ~video by Susan Kaiser Greenland [2 min]~", "https://www.youtube.com/watch?v=j2uooeprDkE"),
            ("*Managing Anxiety with Mindfulness* ~video by Rachel Green [15 min] ~", "https://www.youtube.com/watch?v=aSy9DZAJWIE&index=4&list=PLbiVpU59JkVbFtkacXoByNjHJgGc4AryM")
                                            
        ],
        practiceSheetsURLList: [
            ("\(WeekHeadings.formalPracticeSheet.rawValue) - Body Scan", "week1-formal"),
            ("\(WeekHeadings.informalPracticeSheet.rawValue) - Simple Awareness and/or Mindful Eating", "week1-informal")
        ]
    )
}













































