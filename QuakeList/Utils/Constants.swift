//
//  Constants.swift
//  QuakeList
//
//  Created by Frosty on 11/5/17.
//  Copyright © 2017 repgarden. All rights reserved.
//

import Foundation

var selfDestruct = 0
var QuakeStringTitle = ""
var arrFeltIt = ["000"]
let feedbackEmail = "WhatsShakinApp@gmail.com"

let QuakeStringMonthSig = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_month.geojson"
let QuakeStringWeek45Plus = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_week.geojson"
let QuakeStringDayM25Plus = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_day.geojson"
let QuakeStringHourAll = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson"


//Mercalli Intensity Scale
let QuakeMagNotes3 = "Felt indoors by many, outdoors by few during the day. At night, some awakened. Dishes, windows, doors disturbed; walls make cracking sound. Sensation like heavy truck striking building"
let QuakeMagNotes4 = "Felt by nearly everyone; many awakened. Some dishes, windows broken. Unstable objects overturned. Pendulum clocks may stop."
let QuakeMagNotes5 = "Felt by all, many frightened. Some heavy furniture moved; a few instances of fallen plaster. Damage slight."
let QuakeMagNotes6 = "Damage negligible in buildings of good design and construction; slight to moderate in well-built ordinary structures; considerable damage in poorly built or badly designed structures; some chimneys broken."
let QuakeMagNotes7Plus = "Damage slight in specially designed structures; considerable damage in ordinary substantial buildings with partial collapse. Damage great in poorly built structures. Fall of chimneys, factory stacks, columns, monuments, walls. Heavy furniture overturned."
