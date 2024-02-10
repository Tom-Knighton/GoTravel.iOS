//
//  JourneyData.swift
//  GoTravel
//
//  Created by Tom Knighton on 07/02/2024.
//

import Foundation
import GoTravel_Models

#if DEBUG
public struct PreviewDataJourney {
    
    public static func PreviewJourneyResponse() -> JourneyOptionsResult {
        let data = journeyOptionsJson.data(using: .utf8)
        let model = try! data!.decode(to: JourneyOptionsResult.self)
        
        return model
    }
    
    private static let journeyOptionsJson =
    """
    {
        "journeyOptions": [
            {
                "beginJourneyAt": "2024-02-10T14:49:00",
                "endJourneyAt": "2024-02-10T15:21:00",
                "totalDuration": 32,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-10T14:49:00",
                        "endLegAt": "2024-02-10T14:57:00",
                        "legDuration": 8,
                        "startAtName": "1 Bow Interchange",
                        "endAtName": "Bow Church",
                        "startAtStop": null,
                        "endAtStop": null,
                        "legDetails": {
                            "summary": "Walk to Bow Church",
                            "detailedSummary": "Walk to Bow Church",
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn right on to Bow Interchange, continue for 42 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 42
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 167 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.529141914549996,
                                    "longitude": -0.016122903969999998,
                                    "distanceOfStep": 167
                                },
                                {
                                    "summary": "Turn left for 15 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.52843138626,
                                    "longitude": -0.01824426719,
                                    "distanceOfStep": 15
                                },
                                {
                                    "summary": "Turn left on to Bow Road, continue for 62 metres",
                                    "direction": "East",
                                    "latitude": 51.528321363130004,
                                    "longitude": -0.018119291710000002,
                                    "distanceOfStep": 62
                                }
                            ],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.01679047585,
                                        51.5306999359
                                    ],
                                    [
                                        -0.0167900853,
                                        51.53070892192
                                    ],
                                    [
                                        -0.01606703874,
                                        51.53042691597
                                    ],
                                    [
                                        -0.01518826001,
                                        51.530079322
                                    ],
                                    [
                                        -0.01563341595,
                                        51.52945736945
                                    ],
                                    [
                                        -0.01559605695,
                                        51.52932184794
                                    ],
                                    [
                                        -0.01612290397,
                                        51.52914191455
                                    ],
                                    [
                                        -0.01755545128,
                                        51.52868952544
                                    ],
                                    [
                                        -0.01808345421,
                                        51.52848262495
                                    ],
                                    [
                                        -0.01824426719,
                                        51.52843138626
                                    ],
                                    [
                                        -0.01811929171,
                                        51.52832136313
                                    ],
                                    [
                                        -0.01785763366,
                                        51.52837089755
                                    ],
                                    [
                                        -0.01728914434,
                                        51.52851416425
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "walking",
                                "lineModeName": "Walk",
                                "lines": [],
                                "primaryAreaName": "",
                                "branding": {
                                    "lineModeLogoUrl": "",
                                    "lineModeBackgroundColour": "",
                                    "lineModePrimaryColour": "",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": null
                            },
                            "stopPoints": []
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T14:57:00",
                        "endLegAt": "2024-02-10T15:00:00",
                        "legDuration": 3,
                        "startAtName": "Bow Church",
                        "endAtName": "Bow Road Underground Station",
                        "startAtStop": null,
                        "endAtStop": {
                            "stopPointId": "940GZZLUBWR",
                            "stopPointName": "Bow Road Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.025128,
                                    51.52694
                                ]
                            }
                        },
                        "legDetails": {
                            "summary": "25 bus to Bow Road Station",
                            "detailedSummary": "25 bus towards City Thameslink",
                            "legSteps": [],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.01727230891,
                                        51.52851987091
                                    ],
                                    [
                                        -0.01785763366,
                                        51.52837089755
                                    ],
                                    [
                                        -0.01811929171,
                                        51.52832136313
                                    ],
                                    [
                                        -0.01909154603,
                                        51.52817591932
                                    ],
                                    [
                                        -0.01990220498,
                                        51.5280996807
                                    ],
                                    [
                                        -0.02049514825,
                                        51.52801531325
                                    ],
                                    [
                                        -0.02049514825,
                                        51.52801531325
                                    ],
                                    [
                                        -0.02097568354,
                                        51.52794693743
                                    ],
                                    [
                                        -0.02129496137,
                                        51.5278983681
                                    ],
                                    [
                                        -0.02142539775,
                                        51.52788258315
                                    ],
                                    [
                                        -0.02164344077,
                                        51.5278412978
                                    ],
                                    [
                                        -0.02251483027,
                                        51.52769412445
                                    ],
                                    [
                                        -0.02312534462,
                                        51.52757851873
                                    ],
                                    [
                                        -0.02405282473,
                                        51.52741907959
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "tfl-bus",
                                "lineModeName": "Bus",
                                "lines": [
                                    {
                                        "lineId": "tfl-25",
                                        "lineName": "25",
                                        "linePrimaryColour": "#E1251B"
                                    }
                                ],
                                "primaryAreaName": "London",
                                "branding": {
                                    "lineModeLogoUrl": "https://cdn.tomk.online/cdn/GoTravelBranding/bus.png",
                                    "lineModeBackgroundColour": "#E1251B",
                                    "lineModePrimaryColour": "#E1251B",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": []
                            },
                            "stopPoints": [
                                {
                                    "stopPointId": "940GZZDLBOW",
                                    "stopPointName": "Bow Church DLR Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.020936,
                                            51.527858
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLUBWR",
                                    "stopPointName": "Bow Road Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.025128,
                                            51.52694
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T15:03:00",
                        "endLegAt": "2024-02-10T15:04:00",
                        "legDuration": 1,
                        "startAtName": "Bow Road Underground Station",
                        "endAtName": "Mile End Underground Station",
                        "startAtStop": {
                            "stopPointId": "940GZZLUBWR",
                            "stopPointName": "Bow Road Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.025128,
                                    51.52694
                                ]
                            }
                        },
                        "endAtStop": {
                            "stopPointId": "940GZZLUMED",
                            "stopPointName": "Mile End Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.03364,
                                    51.525122
                                ]
                            }
                        },
                        "legDetails": {
                            "summary": "District line to Mile End",
                            "detailedSummary": "District line towards Wimbledon",
                            "legSteps": [],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.02493847399,
                                        51.52694645478
                                    ],
                                    [
                                        -0.02499734825,
                                        51.52696258512
                                    ],
                                    [
                                        -0.02532752198,
                                        51.52699512194
                                    ],
                                    [
                                        -0.02574646529,
                                        51.52697519625
                                    ],
                                    [
                                        -0.0262553425,
                                        51.52687584882
                                    ],
                                    [
                                        -0.02805761643,
                                        51.5265374646
                                    ],
                                    [
                                        -0.03208837867,
                                        51.52566992747
                                    ],
                                    [
                                        -0.03299044275,
                                        51.52547822822
                                    ],
                                    [
                                        -0.0333840076,
                                        51.52537692588
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "tfl-tube",
                                "lineModeName": "Tube",
                                "lines": [
                                    {
                                        "lineId": "tfl-district",
                                        "lineName": "District",
                                        "linePrimaryColour": "#007934"
                                    }
                                ],
                                "primaryAreaName": "London",
                                "branding": {
                                    "lineModeLogoUrl": "https://cdn.tomk.online/cdn/GoTravelBranding/tube.png",
                                    "lineModeBackgroundColour": "#000F9F",
                                    "lineModePrimaryColour": "#000F9F",
                                    "lineModeSecondaryColour": "#E1251B"
                                },
                                "flags": []
                            },
                            "stopPoints": [
                                {
                                    "stopPointId": "940GZZLUMED",
                                    "stopPointName": "Mile End Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.03364,
                                            51.525122
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T15:05:00",
                        "endLegAt": "2024-02-10T15:12:00",
                        "legDuration": 7,
                        "startAtName": "Mile End Underground Station",
                        "endAtName": "Bank Underground Station",
                        "startAtStop": {
                            "stopPointId": "940GZZLUMED",
                            "stopPointName": "Mile End Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.03364,
                                    51.525122
                                ]
                            }
                        },
                        "endAtStop": {
                            "stopPointId": "940GZZLUBNK",
                            "stopPointName": "Bank Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.089859,
                                    51.513145
                                ]
                            }
                        },
                        "legDetails": {
                            "summary": "Central line to Bank",
                            "detailedSummary": "Central line towards Ealing Broadway",
                            "legSteps": [],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.03354498023,
                                        51.52533549152
                                    ],
                                    [
                                        -0.03508962396,
                                        51.52493788505
                                    ],
                                    [
                                        -0.03592156753,
                                        51.52470002563
                                    ],
                                    [
                                        -0.03740009166,
                                        51.52417622473
                                    ],
                                    [
                                        -0.03905105814,
                                        51.52366428105
                                    ],
                                    [
                                        -0.04055253718,
                                        51.52327571366
                                    ],
                                    [
                                        -0.0412501504,
                                        51.52314348389
                                    ],
                                    [
                                        -0.0425333547,
                                        51.52313792815
                                    ],
                                    [
                                        -0.04327856463,
                                        51.52324028847
                                    ],
                                    [
                                        -0.04471923537,
                                        51.5235970398
                                    ],
                                    [
                                        -0.04569972826,
                                        51.52392812166
                                    ],
                                    [
                                        -0.04658995712,
                                        51.52434761801
                                    ],
                                    [
                                        -0.04945340388,
                                        51.52615781975
                                    ],
                                    [
                                        -0.04996088721,
                                        51.52642704299
                                    ],
                                    [
                                        -0.0506431704,
                                        51.52665420615
                                    ],
                                    [
                                        -0.05160109824,
                                        51.52684098134
                                    ],
                                    [
                                        -0.05459036046,
                                        51.52706110962
                                    ],
                                    [
                                        -0.05459036046,
                                        51.52706110962
                                    ],
                                    [
                                        -0.0568035593,
                                        51.52722403849
                                    ],
                                    [
                                        -0.05740939528,
                                        51.52721608828
                                    ],
                                    [
                                        -0.06199990885,
                                        51.52673448302
                                    ],
                                    [
                                        -0.06601293899,
                                        51.52627015616
                                    ],
                                    [
                                        -0.06795630882,
                                        51.52599643474
                                    ],
                                    [
                                        -0.06923545584,
                                        51.52574771993
                                    ],
                                    [
                                        -0.07011008083,
                                        51.52551931402
                                    ],
                                    [
                                        -0.07172625588,
                                        51.5247995106
                                    ],
                                    [
                                        -0.0739716801,
                                        51.5238562125
                                    ],
                                    [
                                        -0.07510250774,
                                        51.52336219924
                                    ],
                                    [
                                        -0.07619691264,
                                        51.52270571156
                                    ],
                                    [
                                        -0.08219387974,
                                        51.5180499999
                                    ],
                                    [
                                        -0.08219387974,
                                        51.5180499999
                                    ],
                                    [
                                        -0.08223188004,
                                        51.51802049452
                                    ],
                                    [
                                        -0.08261845498,
                                        51.51773905248
                                    ],
                                    [
                                        -0.08286023455,
                                        51.51747322767
                                    ],
                                    [
                                        -0.08323798958,
                                        51.51671503333
                                    ],
                                    [
                                        -0.0834702606,
                                        51.51633214849
                                    ],
                                    [
                                        -0.08456844565,
                                        51.5152350096
                                    ],
                                    [
                                        -0.08527862755,
                                        51.51479697708
                                    ],
                                    [
                                        -0.08615438147,
                                        51.51419078338
                                    ],
                                    [
                                        -0.08643405635,
                                        51.51405146561
                                    ],
                                    [
                                        -0.08678461243,
                                        51.51394028114
                                    ],
                                    [
                                        -0.08719315319,
                                        51.51382104874
                                    ],
                                    [
                                        -0.08847599616,
                                        51.51347326824
                                    ],
                                    [
                                        -0.08862185049,
                                        51.51345060737
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "tfl-tube",
                                "lineModeName": "Tube",
                                "lines": [
                                    {
                                        "lineId": "tfl-central",
                                        "lineName": "Central",
                                        "linePrimaryColour": "#E1251B"
                                    }
                                ],
                                "primaryAreaName": "London",
                                "branding": {
                                    "lineModeLogoUrl": "https://cdn.tomk.online/cdn/GoTravelBranding/tube.png",
                                    "lineModeBackgroundColour": "#000F9F",
                                    "lineModePrimaryColour": "#000F9F",
                                    "lineModeSecondaryColour": "#E1251B"
                                },
                                "flags": []
                            },
                            "stopPoints": [
                                {
                                    "stopPointId": "940GZZLUBLG",
                                    "stopPointName": "Bethnal Green Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.055506,
                                            51.527222
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLULVT",
                                    "stopPointName": "Liverpool Street Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.083182,
                                            51.517372
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLUBNK",
                                    "stopPointName": "Bank Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.089859,
                                            51.513145
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T15:12:00",
                        "endLegAt": "2024-02-10T15:21:00",
                        "legDuration": 9,
                        "startAtName": "Bank Underground Station",
                        "endAtName": "108 Cheapside, City",
                        "startAtStop": {
                            "stopPointId": "940GZZLUBNK",
                            "stopPointName": "Bank Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.089859,
                                    51.513145
                                ]
                            }
                        },
                        "endAtStop": null,
                        "legDetails": {
                            "summary": "Walk to 108 Cheapside, City",
                            "detailedSummary": "Walk to 108 Cheapside, City",
                            "legSteps": [
                                {
                                    "summary": "Continue along  Poultry for 66 metres",
                                    "direction": "West",
                                    "latitude": 51.513493374700005,
                                    "longitude": -0.09026226841,
                                    "distanceOfStep": 66
                                },
                                {
                                    "summary": "Continue along  on to Cheapside, continue for 172 metres",
                                    "direction": "West",
                                    "latitude": 51.513634424450004,
                                    "longitude": -0.09119316552,
                                    "distanceOfStep": 172
                                }
                            ],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.08862108748,
                                        51.5134486954
                                    ],
                                    [
                                        -0.08897094253,
                                        51.5133554379
                                    ],
                                    [
                                        -0.08904746724,
                                        51.51324877395
                                    ],
                                    [
                                        -0.09026228748,
                                        51.5134933954
                                    ],
                                    [
                                        -0.09026226841,
                                        51.5134933747
                                    ],
                                    [
                                        -0.09066328108,
                                        51.51355385899
                                    ],
                                    [
                                        -0.09077774897,
                                        51.51357370752
                                    ],
                                    [
                                        -0.09119316552,
                                        51.51363442445
                                    ],
                                    [
                                        -0.09156575137,
                                        51.51368545042
                                    ],
                                    [
                                        -0.09209488806,
                                        51.51378398474
                                    ],
                                    [
                                        -0.09232382641,
                                        51.51382367892
                                    ],
                                    [
                                        -0.09255276518,
                                        51.51386337266
                                    ],
                                    [
                                        -0.09315316845,
                                        51.51398104629
                                    ],
                                    [
                                        -0.09359702208,
                                        51.51405120955
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "walking",
                                "lineModeName": "Walk",
                                "lines": [],
                                "primaryAreaName": "",
                                "branding": {
                                    "lineModeLogoUrl": "",
                                    "lineModeBackgroundColour": "",
                                    "lineModePrimaryColour": "",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": null
                            },
                            "stopPoints": []
                        }
                    }
                ]
            },
            {
                "beginJourneyAt": "2024-02-10T14:53:00",
                "endJourneyAt": "2024-02-10T15:25:00",
                "totalDuration": 32,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-10T14:53:00",
                        "endLegAt": "2024-02-10T15:01:00",
                        "legDuration": 8,
                        "startAtName": "1 Bow Interchange",
                        "endAtName": "Bow Church",
                        "startAtStop": null,
                        "endAtStop": null,
                        "legDetails": {
                            "summary": "Walk to Bow Church",
                            "detailedSummary": "Walk to Bow Church",
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn right on to Bow Interchange, continue for 42 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 42
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 167 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.529141914549996,
                                    "longitude": -0.016122903969999998,
                                    "distanceOfStep": 167
                                },
                                {
                                    "summary": "Turn left for 15 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.52843138626,
                                    "longitude": -0.01824426719,
                                    "distanceOfStep": 15
                                },
                                {
                                    "summary": "Turn left on to Bow Road, continue for 62 metres",
                                    "direction": "East",
                                    "latitude": 51.528321363130004,
                                    "longitude": -0.018119291710000002,
                                    "distanceOfStep": 62
                                }
                            ],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.01679047585,
                                        51.5306999359
                                    ],
                                    [
                                        -0.0167900853,
                                        51.53070892192
                                    ],
                                    [
                                        -0.01606703874,
                                        51.53042691597
                                    ],
                                    [
                                        -0.01518826001,
                                        51.530079322
                                    ],
                                    [
                                        -0.01563341595,
                                        51.52945736945
                                    ],
                                    [
                                        -0.01559605695,
                                        51.52932184794
                                    ],
                                    [
                                        -0.01612290397,
                                        51.52914191455
                                    ],
                                    [
                                        -0.01755545128,
                                        51.52868952544
                                    ],
                                    [
                                        -0.01808345421,
                                        51.52848262495
                                    ],
                                    [
                                        -0.01824426719,
                                        51.52843138626
                                    ],
                                    [
                                        -0.01811929171,
                                        51.52832136313
                                    ],
                                    [
                                        -0.01785763366,
                                        51.52837089755
                                    ],
                                    [
                                        -0.01728914434,
                                        51.52851416425
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "walking",
                                "lineModeName": "Walk",
                                "lines": [],
                                "primaryAreaName": "",
                                "branding": {
                                    "lineModeLogoUrl": "",
                                    "lineModeBackgroundColour": "",
                                    "lineModePrimaryColour": "",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": null
                            },
                            "stopPoints": []
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T15:01:00",
                        "endLegAt": "2024-02-10T15:03:00",
                        "legDuration": 2,
                        "startAtName": "Bow Church",
                        "endAtName": "Bow Road Underground Station",
                        "startAtStop": null,
                        "endAtStop": {
                            "stopPointId": "940GZZLUBWR",
                            "stopPointName": "Bow Road Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.025128,
                                    51.52694
                                ]
                            }
                        },
                        "legDetails": {
                            "summary": "205 bus to Bow Road Station",
                            "detailedSummary": "205 bus towards Paddington",
                            "legSteps": [],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.01727230891,
                                        51.52851987091
                                    ],
                                    [
                                        -0.01785763366,
                                        51.52837089755
                                    ],
                                    [
                                        -0.01811929171,
                                        51.52832136313
                                    ],
                                    [
                                        -0.01909154603,
                                        51.52817591932
                                    ],
                                    [
                                        -0.01990220498,
                                        51.5280996807
                                    ],
                                    [
                                        -0.02049514825,
                                        51.52801531325
                                    ],
                                    [
                                        -0.02049514825,
                                        51.52801531325
                                    ],
                                    [
                                        -0.02097568354,
                                        51.52794693743
                                    ],
                                    [
                                        -0.02129496137,
                                        51.5278983681
                                    ],
                                    [
                                        -0.02142539775,
                                        51.52788258315
                                    ],
                                    [
                                        -0.02164344077,
                                        51.5278412978
                                    ],
                                    [
                                        -0.02251483027,
                                        51.52769412445
                                    ],
                                    [
                                        -0.02312534462,
                                        51.52757851873
                                    ],
                                    [
                                        -0.02405282473,
                                        51.52741907959
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "tfl-bus",
                                "lineModeName": "Bus",
                                "lines": [
                                    {
                                        "lineId": "tfl-205",
                                        "lineName": "205",
                                        "linePrimaryColour": "#E1251B"
                                    }
                                ],
                                "primaryAreaName": "London",
                                "branding": {
                                    "lineModeLogoUrl": "https://cdn.tomk.online/cdn/GoTravelBranding/bus.png",
                                    "lineModeBackgroundColour": "#E1251B",
                                    "lineModePrimaryColour": "#E1251B",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": []
                            },
                            "stopPoints": [
                                {
                                    "stopPointId": "940GZZDLBOW",
                                    "stopPointName": "Bow Church DLR Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.020936,
                                            51.527858
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLUBWR",
                                    "stopPointName": "Bow Road Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.025128,
                                            51.52694
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T15:06:00",
                        "endLegAt": "2024-02-10T15:07:00",
                        "legDuration": 1,
                        "startAtName": "Bow Road Underground Station",
                        "endAtName": "Mile End Underground Station",
                        "startAtStop": {
                            "stopPointId": "940GZZLUBWR",
                            "stopPointName": "Bow Road Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.025128,
                                    51.52694
                                ]
                            }
                        },
                        "endAtStop": {
                            "stopPointId": "940GZZLUMED",
                            "stopPointName": "Mile End Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.03364,
                                    51.525122
                                ]
                            }
                        },
                        "legDetails": {
                            "summary": "District line to Mile End",
                            "detailedSummary": "District line towards Richmond",
                            "legSteps": [],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.02493847399,
                                        51.52694645478
                                    ],
                                    [
                                        -0.02499734825,
                                        51.52696258512
                                    ],
                                    [
                                        -0.02532752198,
                                        51.52699512194
                                    ],
                                    [
                                        -0.02574646529,
                                        51.52697519625
                                    ],
                                    [
                                        -0.0262553425,
                                        51.52687584882
                                    ],
                                    [
                                        -0.02805761643,
                                        51.5265374646
                                    ],
                                    [
                                        -0.03208837867,
                                        51.52566992747
                                    ],
                                    [
                                        -0.03299044275,
                                        51.52547822822
                                    ],
                                    [
                                        -0.0333840076,
                                        51.52537692588
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "tfl-tube",
                                "lineModeName": "Tube",
                                "lines": [
                                    {
                                        "lineId": "tfl-district",
                                        "lineName": "District",
                                        "linePrimaryColour": "#007934"
                                    }
                                ],
                                "primaryAreaName": "London",
                                "branding": {
                                    "lineModeLogoUrl": "https://cdn.tomk.online/cdn/GoTravelBranding/tube.png",
                                    "lineModeBackgroundColour": "#000F9F",
                                    "lineModePrimaryColour": "#000F9F",
                                    "lineModeSecondaryColour": "#E1251B"
                                },
                                "flags": []
                            },
                            "stopPoints": [
                                {
                                    "stopPointId": "940GZZLUMED",
                                    "stopPointName": "Mile End Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.03364,
                                            51.525122
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T15:09:00",
                        "endLegAt": "2024-02-10T15:16:00",
                        "legDuration": 7,
                        "startAtName": "Mile End Underground Station",
                        "endAtName": "Bank Underground Station",
                        "startAtStop": {
                            "stopPointId": "940GZZLUMED",
                            "stopPointName": "Mile End Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.03364,
                                    51.525122
                                ]
                            }
                        },
                        "endAtStop": {
                            "stopPointId": "940GZZLUBNK",
                            "stopPointName": "Bank Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.089859,
                                    51.513145
                                ]
                            }
                        },
                        "legDetails": {
                            "summary": "Central line to Bank",
                            "detailedSummary": "Central line towards White City",
                            "legSteps": [],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.03354498023,
                                        51.52533549152
                                    ],
                                    [
                                        -0.03508962396,
                                        51.52493788505
                                    ],
                                    [
                                        -0.03592156753,
                                        51.52470002563
                                    ],
                                    [
                                        -0.03740009166,
                                        51.52417622473
                                    ],
                                    [
                                        -0.03905105814,
                                        51.52366428105
                                    ],
                                    [
                                        -0.04055253718,
                                        51.52327571366
                                    ],
                                    [
                                        -0.0412501504,
                                        51.52314348389
                                    ],
                                    [
                                        -0.0425333547,
                                        51.52313792815
                                    ],
                                    [
                                        -0.04327856463,
                                        51.52324028847
                                    ],
                                    [
                                        -0.04471923537,
                                        51.5235970398
                                    ],
                                    [
                                        -0.04569972826,
                                        51.52392812166
                                    ],
                                    [
                                        -0.04658995712,
                                        51.52434761801
                                    ],
                                    [
                                        -0.04945340388,
                                        51.52615781975
                                    ],
                                    [
                                        -0.04996088721,
                                        51.52642704299
                                    ],
                                    [
                                        -0.0506431704,
                                        51.52665420615
                                    ],
                                    [
                                        -0.05160109824,
                                        51.52684098134
                                    ],
                                    [
                                        -0.05459036046,
                                        51.52706110962
                                    ],
                                    [
                                        -0.05459036046,
                                        51.52706110962
                                    ],
                                    [
                                        -0.0568035593,
                                        51.52722403849
                                    ],
                                    [
                                        -0.05740939528,
                                        51.52721608828
                                    ],
                                    [
                                        -0.06199990885,
                                        51.52673448302
                                    ],
                                    [
                                        -0.06601293899,
                                        51.52627015616
                                    ],
                                    [
                                        -0.06795630882,
                                        51.52599643474
                                    ],
                                    [
                                        -0.06923545584,
                                        51.52574771993
                                    ],
                                    [
                                        -0.07011008083,
                                        51.52551931402
                                    ],
                                    [
                                        -0.07172625588,
                                        51.5247995106
                                    ],
                                    [
                                        -0.0739716801,
                                        51.5238562125
                                    ],
                                    [
                                        -0.07510250774,
                                        51.52336219924
                                    ],
                                    [
                                        -0.07619691264,
                                        51.52270571156
                                    ],
                                    [
                                        -0.08219387974,
                                        51.5180499999
                                    ],
                                    [
                                        -0.08219387974,
                                        51.5180499999
                                    ],
                                    [
                                        -0.08223188004,
                                        51.51802049452
                                    ],
                                    [
                                        -0.08261845498,
                                        51.51773905248
                                    ],
                                    [
                                        -0.08286023455,
                                        51.51747322767
                                    ],
                                    [
                                        -0.08323798958,
                                        51.51671503333
                                    ],
                                    [
                                        -0.0834702606,
                                        51.51633214849
                                    ],
                                    [
                                        -0.08456844565,
                                        51.5152350096
                                    ],
                                    [
                                        -0.08527862755,
                                        51.51479697708
                                    ],
                                    [
                                        -0.08615438147,
                                        51.51419078338
                                    ],
                                    [
                                        -0.08643405635,
                                        51.51405146561
                                    ],
                                    [
                                        -0.08678461243,
                                        51.51394028114
                                    ],
                                    [
                                        -0.08719315319,
                                        51.51382104874
                                    ],
                                    [
                                        -0.08847599616,
                                        51.51347326824
                                    ],
                                    [
                                        -0.08862185049,
                                        51.51345060737
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "tfl-tube",
                                "lineModeName": "Tube",
                                "lines": [
                                    {
                                        "lineId": "tfl-central",
                                        "lineName": "Central",
                                        "linePrimaryColour": "#E1251B"
                                    }
                                ],
                                "primaryAreaName": "London",
                                "branding": {
                                    "lineModeLogoUrl": "https://cdn.tomk.online/cdn/GoTravelBranding/tube.png",
                                    "lineModeBackgroundColour": "#000F9F",
                                    "lineModePrimaryColour": "#000F9F",
                                    "lineModeSecondaryColour": "#E1251B"
                                },
                                "flags": []
                            },
                            "stopPoints": [
                                {
                                    "stopPointId": "940GZZLUBLG",
                                    "stopPointName": "Bethnal Green Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.055506,
                                            51.527222
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLULVT",
                                    "stopPointName": "Liverpool Street Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.083182,
                                            51.517372
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLUBNK",
                                    "stopPointName": "Bank Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.089859,
                                            51.513145
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T15:16:00",
                        "endLegAt": "2024-02-10T15:25:00",
                        "legDuration": 9,
                        "startAtName": "Bank Underground Station",
                        "endAtName": "108 Cheapside, City",
                        "startAtStop": {
                            "stopPointId": "940GZZLUBNK",
                            "stopPointName": "Bank Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.089859,
                                    51.513145
                                ]
                            }
                        },
                        "endAtStop": null,
                        "legDetails": {
                            "summary": "Walk to 108 Cheapside, City",
                            "detailedSummary": "Walk to 108 Cheapside, City",
                            "legSteps": [
                                {
                                    "summary": "Continue along  Poultry for 66 metres",
                                    "direction": "West",
                                    "latitude": 51.513493374700005,
                                    "longitude": -0.09026226841,
                                    "distanceOfStep": 66
                                },
                                {
                                    "summary": "Continue along  on to Cheapside, continue for 172 metres",
                                    "direction": "West",
                                    "latitude": 51.513634424450004,
                                    "longitude": -0.09119316552,
                                    "distanceOfStep": 172
                                }
                            ],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.08862108748,
                                        51.5134486954
                                    ],
                                    [
                                        -0.08897094253,
                                        51.5133554379
                                    ],
                                    [
                                        -0.08904746724,
                                        51.51324877395
                                    ],
                                    [
                                        -0.09026228748,
                                        51.5134933954
                                    ],
                                    [
                                        -0.09026226841,
                                        51.5134933747
                                    ],
                                    [
                                        -0.09066328108,
                                        51.51355385899
                                    ],
                                    [
                                        -0.09077774897,
                                        51.51357370752
                                    ],
                                    [
                                        -0.09119316552,
                                        51.51363442445
                                    ],
                                    [
                                        -0.09156575137,
                                        51.51368545042
                                    ],
                                    [
                                        -0.09209488806,
                                        51.51378398474
                                    ],
                                    [
                                        -0.09232382641,
                                        51.51382367892
                                    ],
                                    [
                                        -0.09255276518,
                                        51.51386337266
                                    ],
                                    [
                                        -0.09315316845,
                                        51.51398104629
                                    ],
                                    [
                                        -0.09359702208,
                                        51.51405120955
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "walking",
                                "lineModeName": "Walk",
                                "lines": [],
                                "primaryAreaName": "",
                                "branding": {
                                    "lineModeLogoUrl": "",
                                    "lineModeBackgroundColour": "",
                                    "lineModePrimaryColour": "",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": null
                            },
                            "stopPoints": []
                        }
                    }
                ]
            },
            {
                "beginJourneyAt": "2024-02-10T14:56:00",
                "endJourneyAt": "2024-02-10T15:29:00",
                "totalDuration": 33,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-10T14:56:00",
                        "endLegAt": "2024-02-10T15:04:00",
                        "legDuration": 8,
                        "startAtName": "1 Bow Interchange",
                        "endAtName": "Bow Church",
                        "startAtStop": null,
                        "endAtStop": null,
                        "legDetails": {
                            "summary": "Walk to Bow Church",
                            "detailedSummary": "Walk to Bow Church",
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn right on to Bow Interchange, continue for 42 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 42
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 167 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.529141914549996,
                                    "longitude": -0.016122903969999998,
                                    "distanceOfStep": 167
                                },
                                {
                                    "summary": "Turn left for 15 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.52843138626,
                                    "longitude": -0.01824426719,
                                    "distanceOfStep": 15
                                },
                                {
                                    "summary": "Turn left on to Bow Road, continue for 62 metres",
                                    "direction": "East",
                                    "latitude": 51.528321363130004,
                                    "longitude": -0.018119291710000002,
                                    "distanceOfStep": 62
                                }
                            ],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.01679047585,
                                        51.5306999359
                                    ],
                                    [
                                        -0.0167900853,
                                        51.53070892192
                                    ],
                                    [
                                        -0.01606703874,
                                        51.53042691597
                                    ],
                                    [
                                        -0.01518826001,
                                        51.530079322
                                    ],
                                    [
                                        -0.01563341595,
                                        51.52945736945
                                    ],
                                    [
                                        -0.01559605695,
                                        51.52932184794
                                    ],
                                    [
                                        -0.01612290397,
                                        51.52914191455
                                    ],
                                    [
                                        -0.01755545128,
                                        51.52868952544
                                    ],
                                    [
                                        -0.01808345421,
                                        51.52848262495
                                    ],
                                    [
                                        -0.01824426719,
                                        51.52843138626
                                    ],
                                    [
                                        -0.01811929171,
                                        51.52832136313
                                    ],
                                    [
                                        -0.01785763366,
                                        51.52837089755
                                    ],
                                    [
                                        -0.01728914434,
                                        51.52851416425
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "walking",
                                "lineModeName": "Walk",
                                "lines": [],
                                "primaryAreaName": "",
                                "branding": {
                                    "lineModeLogoUrl": "",
                                    "lineModeBackgroundColour": "",
                                    "lineModePrimaryColour": "",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": null
                            },
                            "stopPoints": []
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T15:04:00",
                        "endLegAt": "2024-02-10T15:07:00",
                        "legDuration": 3,
                        "startAtName": "Bow Church",
                        "endAtName": "Bow Road Underground Station",
                        "startAtStop": null,
                        "endAtStop": {
                            "stopPointId": "940GZZLUBWR",
                            "stopPointName": "Bow Road Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.025128,
                                    51.52694
                                ]
                            }
                        },
                        "legDetails": {
                            "summary": "425 bus to Bow Road Station",
                            "detailedSummary": "425 bus towards Clapton, Nightingale Road",
                            "legSteps": [],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.01727230891,
                                        51.52851987091
                                    ],
                                    [
                                        -0.01785763366,
                                        51.52837089755
                                    ],
                                    [
                                        -0.01811929171,
                                        51.52832136313
                                    ],
                                    [
                                        -0.01909154603,
                                        51.52817591932
                                    ],
                                    [
                                        -0.01990220498,
                                        51.5280996807
                                    ],
                                    [
                                        -0.02049514825,
                                        51.52801531325
                                    ],
                                    [
                                        -0.02049514825,
                                        51.52801531325
                                    ],
                                    [
                                        -0.02097568354,
                                        51.52794693743
                                    ],
                                    [
                                        -0.02129496137,
                                        51.5278983681
                                    ],
                                    [
                                        -0.02142539775,
                                        51.52788258315
                                    ],
                                    [
                                        -0.02164344077,
                                        51.5278412978
                                    ],
                                    [
                                        -0.02251483027,
                                        51.52769412445
                                    ],
                                    [
                                        -0.02312534462,
                                        51.52757851873
                                    ],
                                    [
                                        -0.02405282473,
                                        51.52741907959
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "tfl-bus",
                                "lineModeName": "Bus",
                                "lines": [
                                    {
                                        "lineId": "tfl-425",
                                        "lineName": "425",
                                        "linePrimaryColour": "#E1251B"
                                    }
                                ],
                                "primaryAreaName": "London",
                                "branding": {
                                    "lineModeLogoUrl": "https://cdn.tomk.online/cdn/GoTravelBranding/bus.png",
                                    "lineModeBackgroundColour": "#E1251B",
                                    "lineModePrimaryColour": "#E1251B",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": []
                            },
                            "stopPoints": [
                                {
                                    "stopPointId": "940GZZDLBOW",
                                    "stopPointName": "Bow Church DLR Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.020936,
                                            51.527858
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLUBWR",
                                    "stopPointName": "Bow Road Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.025128,
                                            51.52694
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T15:10:00",
                        "endLegAt": "2024-02-10T15:11:00",
                        "legDuration": 1,
                        "startAtName": "Bow Road Underground Station",
                        "endAtName": "Mile End Underground Station",
                        "startAtStop": {
                            "stopPointId": "940GZZLUBWR",
                            "stopPointName": "Bow Road Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.025128,
                                    51.52694
                                ]
                            }
                        },
                        "endAtStop": {
                            "stopPointId": "940GZZLUMED",
                            "stopPointName": "Mile End Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.03364,
                                    51.525122
                                ]
                            }
                        },
                        "legDetails": {
                            "summary": "District line to Mile End",
                            "detailedSummary": "District line towards Ealing Broadway",
                            "legSteps": [],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.02493847399,
                                        51.52694645478
                                    ],
                                    [
                                        -0.02499734825,
                                        51.52696258512
                                    ],
                                    [
                                        -0.02532752198,
                                        51.52699512194
                                    ],
                                    [
                                        -0.02574646529,
                                        51.52697519625
                                    ],
                                    [
                                        -0.0262553425,
                                        51.52687584882
                                    ],
                                    [
                                        -0.02805761643,
                                        51.5265374646
                                    ],
                                    [
                                        -0.03208837867,
                                        51.52566992747
                                    ],
                                    [
                                        -0.03299044275,
                                        51.52547822822
                                    ],
                                    [
                                        -0.0333840076,
                                        51.52537692588
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "tfl-tube",
                                "lineModeName": "Tube",
                                "lines": [
                                    {
                                        "lineId": "tfl-district",
                                        "lineName": "District",
                                        "linePrimaryColour": "#007934"
                                    }
                                ],
                                "primaryAreaName": "London",
                                "branding": {
                                    "lineModeLogoUrl": "https://cdn.tomk.online/cdn/GoTravelBranding/tube.png",
                                    "lineModeBackgroundColour": "#000F9F",
                                    "lineModePrimaryColour": "#000F9F",
                                    "lineModeSecondaryColour": "#E1251B"
                                },
                                "flags": []
                            },
                            "stopPoints": [
                                {
                                    "stopPointId": "940GZZLUMED",
                                    "stopPointName": "Mile End Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.03364,
                                            51.525122
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T15:12:00",
                        "endLegAt": "2024-02-10T15:20:00",
                        "legDuration": 8,
                        "startAtName": "Mile End Underground Station",
                        "endAtName": "Bank Underground Station",
                        "startAtStop": {
                            "stopPointId": "940GZZLUMED",
                            "stopPointName": "Mile End Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.03364,
                                    51.525122
                                ]
                            }
                        },
                        "endAtStop": {
                            "stopPointId": "940GZZLUBNK",
                            "stopPointName": "Bank Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.089859,
                                    51.513145
                                ]
                            }
                        },
                        "legDetails": {
                            "summary": "Central line to Bank",
                            "detailedSummary": "Central line towards North Acton",
                            "legSteps": [],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.03354498023,
                                        51.52533549152
                                    ],
                                    [
                                        -0.03508962396,
                                        51.52493788505
                                    ],
                                    [
                                        -0.03592156753,
                                        51.52470002563
                                    ],
                                    [
                                        -0.03740009166,
                                        51.52417622473
                                    ],
                                    [
                                        -0.03905105814,
                                        51.52366428105
                                    ],
                                    [
                                        -0.04055253718,
                                        51.52327571366
                                    ],
                                    [
                                        -0.0412501504,
                                        51.52314348389
                                    ],
                                    [
                                        -0.0425333547,
                                        51.52313792815
                                    ],
                                    [
                                        -0.04327856463,
                                        51.52324028847
                                    ],
                                    [
                                        -0.04471923537,
                                        51.5235970398
                                    ],
                                    [
                                        -0.04569972826,
                                        51.52392812166
                                    ],
                                    [
                                        -0.04658995712,
                                        51.52434761801
                                    ],
                                    [
                                        -0.04945340388,
                                        51.52615781975
                                    ],
                                    [
                                        -0.04996088721,
                                        51.52642704299
                                    ],
                                    [
                                        -0.0506431704,
                                        51.52665420615
                                    ],
                                    [
                                        -0.05160109824,
                                        51.52684098134
                                    ],
                                    [
                                        -0.05459036046,
                                        51.52706110962
                                    ],
                                    [
                                        -0.05459036046,
                                        51.52706110962
                                    ],
                                    [
                                        -0.0568035593,
                                        51.52722403849
                                    ],
                                    [
                                        -0.05740939528,
                                        51.52721608828
                                    ],
                                    [
                                        -0.06199990885,
                                        51.52673448302
                                    ],
                                    [
                                        -0.06601293899,
                                        51.52627015616
                                    ],
                                    [
                                        -0.06795630882,
                                        51.52599643474
                                    ],
                                    [
                                        -0.06923545584,
                                        51.52574771993
                                    ],
                                    [
                                        -0.07011008083,
                                        51.52551931402
                                    ],
                                    [
                                        -0.07172625588,
                                        51.5247995106
                                    ],
                                    [
                                        -0.0739716801,
                                        51.5238562125
                                    ],
                                    [
                                        -0.07510250774,
                                        51.52336219924
                                    ],
                                    [
                                        -0.07619691264,
                                        51.52270571156
                                    ],
                                    [
                                        -0.08219387974,
                                        51.5180499999
                                    ],
                                    [
                                        -0.08219387974,
                                        51.5180499999
                                    ],
                                    [
                                        -0.08223188004,
                                        51.51802049452
                                    ],
                                    [
                                        -0.08261845498,
                                        51.51773905248
                                    ],
                                    [
                                        -0.08286023455,
                                        51.51747322767
                                    ],
                                    [
                                        -0.08323798958,
                                        51.51671503333
                                    ],
                                    [
                                        -0.0834702606,
                                        51.51633214849
                                    ],
                                    [
                                        -0.08456844565,
                                        51.5152350096
                                    ],
                                    [
                                        -0.08527862755,
                                        51.51479697708
                                    ],
                                    [
                                        -0.08615438147,
                                        51.51419078338
                                    ],
                                    [
                                        -0.08643405635,
                                        51.51405146561
                                    ],
                                    [
                                        -0.08678461243,
                                        51.51394028114
                                    ],
                                    [
                                        -0.08719315319,
                                        51.51382104874
                                    ],
                                    [
                                        -0.08847599616,
                                        51.51347326824
                                    ],
                                    [
                                        -0.08862185049,
                                        51.51345060737
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "tfl-tube",
                                "lineModeName": "Tube",
                                "lines": [
                                    {
                                        "lineId": "tfl-central",
                                        "lineName": "Central",
                                        "linePrimaryColour": "#E1251B"
                                    }
                                ],
                                "primaryAreaName": "London",
                                "branding": {
                                    "lineModeLogoUrl": "https://cdn.tomk.online/cdn/GoTravelBranding/tube.png",
                                    "lineModeBackgroundColour": "#000F9F",
                                    "lineModePrimaryColour": "#000F9F",
                                    "lineModeSecondaryColour": "#E1251B"
                                },
                                "flags": []
                            },
                            "stopPoints": [
                                {
                                    "stopPointId": "940GZZLUBLG",
                                    "stopPointName": "Bethnal Green Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.055506,
                                            51.527222
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLULVT",
                                    "stopPointName": "Liverpool Street Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.083182,
                                            51.517372
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLUBNK",
                                    "stopPointName": "Bank Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.089859,
                                            51.513145
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T15:20:00",
                        "endLegAt": "2024-02-10T15:29:00",
                        "legDuration": 9,
                        "startAtName": "Bank Underground Station",
                        "endAtName": "108 Cheapside, City",
                        "startAtStop": {
                            "stopPointId": "940GZZLUBNK",
                            "stopPointName": "Bank Underground Station",
                            "stopCoordinate": {
                                "type": "Point",
                                "coordinates": [
                                    -0.089859,
                                    51.513145
                                ]
                            }
                        },
                        "endAtStop": null,
                        "legDetails": {
                            "summary": "Walk to 108 Cheapside, City",
                            "detailedSummary": "Walk to 108 Cheapside, City",
                            "legSteps": [
                                {
                                    "summary": "Continue along  Poultry for 66 metres",
                                    "direction": "West",
                                    "latitude": 51.513493374700005,
                                    "longitude": -0.09026226841,
                                    "distanceOfStep": 66
                                },
                                {
                                    "summary": "Continue along  on to Cheapside, continue for 172 metres",
                                    "direction": "West",
                                    "latitude": 51.513634424450004,
                                    "longitude": -0.09119316552,
                                    "distanceOfStep": 172
                                }
                            ],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.08862108748,
                                        51.5134486954
                                    ],
                                    [
                                        -0.08897094253,
                                        51.5133554379
                                    ],
                                    [
                                        -0.08904746724,
                                        51.51324877395
                                    ],
                                    [
                                        -0.09026228748,
                                        51.5134933954
                                    ],
                                    [
                                        -0.09026226841,
                                        51.5134933747
                                    ],
                                    [
                                        -0.09066328108,
                                        51.51355385899
                                    ],
                                    [
                                        -0.09077774897,
                                        51.51357370752
                                    ],
                                    [
                                        -0.09119316552,
                                        51.51363442445
                                    ],
                                    [
                                        -0.09156575137,
                                        51.51368545042
                                    ],
                                    [
                                        -0.09209488806,
                                        51.51378398474
                                    ],
                                    [
                                        -0.09232382641,
                                        51.51382367892
                                    ],
                                    [
                                        -0.09255276518,
                                        51.51386337266
                                    ],
                                    [
                                        -0.09315316845,
                                        51.51398104629
                                    ],
                                    [
                                        -0.09359702208,
                                        51.51405120955
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "walking",
                                "lineModeName": "Walk",
                                "lines": [],
                                "primaryAreaName": "",
                                "branding": {
                                    "lineModeLogoUrl": "",
                                    "lineModeBackgroundColour": "",
                                    "lineModePrimaryColour": "",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": null
                            },
                            "stopPoints": []
                        }
                    }
                ]
            },
            {
                "beginJourneyAt": "2024-02-10T14:49:00",
                "endJourneyAt": "2024-02-10T15:35:00",
                "totalDuration": 46,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-10T14:49:00",
                        "endLegAt": "2024-02-10T14:57:00",
                        "legDuration": 8,
                        "startAtName": "1 Bow Interchange",
                        "endAtName": "Bow Church",
                        "startAtStop": null,
                        "endAtStop": null,
                        "legDetails": {
                            "summary": "Walk to Bow Church",
                            "detailedSummary": "Walk to Bow Church",
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn right on to Bow Interchange, continue for 42 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 42
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 167 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.529141914549996,
                                    "longitude": -0.016122903969999998,
                                    "distanceOfStep": 167
                                },
                                {
                                    "summary": "Turn left for 15 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.52843138626,
                                    "longitude": -0.01824426719,
                                    "distanceOfStep": 15
                                },
                                {
                                    "summary": "Turn left on to Bow Road, continue for 62 metres",
                                    "direction": "East",
                                    "latitude": 51.528321363130004,
                                    "longitude": -0.018119291710000002,
                                    "distanceOfStep": 62
                                }
                            ],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.01679047585,
                                        51.5306999359
                                    ],
                                    [
                                        -0.0167900853,
                                        51.53070892192
                                    ],
                                    [
                                        -0.01606703874,
                                        51.53042691597
                                    ],
                                    [
                                        -0.01518826001,
                                        51.530079322
                                    ],
                                    [
                                        -0.01563341595,
                                        51.52945736945
                                    ],
                                    [
                                        -0.01559605695,
                                        51.52932184794
                                    ],
                                    [
                                        -0.01612290397,
                                        51.52914191455
                                    ],
                                    [
                                        -0.01755545128,
                                        51.52868952544
                                    ],
                                    [
                                        -0.01808345421,
                                        51.52848262495
                                    ],
                                    [
                                        -0.01824426719,
                                        51.52843138626
                                    ],
                                    [
                                        -0.01811929171,
                                        51.52832136313
                                    ],
                                    [
                                        -0.01785763366,
                                        51.52837089755
                                    ],
                                    [
                                        -0.01728914434,
                                        51.52851416425
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "walking",
                                "lineModeName": "Walk",
                                "lines": [],
                                "primaryAreaName": "",
                                "branding": {
                                    "lineModeLogoUrl": "",
                                    "lineModeBackgroundColour": "",
                                    "lineModePrimaryColour": "",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": null
                            },
                            "stopPoints": []
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T14:57:00",
                        "endLegAt": "2024-02-10T15:32:00",
                        "legDuration": 35,
                        "startAtName": "Bow Church",
                        "endAtName": "Poultry / Bank Station",
                        "startAtStop": null,
                        "endAtStop": null,
                        "legDetails": {
                            "summary": "25 bus to Poultry / Bank Station",
                            "detailedSummary": "25 bus towards City Thameslink",
                            "legSteps": [],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.01727230891,
                                        51.52851987091
                                    ],
                                    [
                                        -0.01785763366,
                                        51.52837089755
                                    ],
                                    [
                                        -0.01811929171,
                                        51.52832136313
                                    ],
                                    [
                                        -0.01909154603,
                                        51.52817591932
                                    ],
                                    [
                                        -0.01990220498,
                                        51.5280996807
                                    ],
                                    [
                                        -0.02049514825,
                                        51.52801531325
                                    ],
                                    [
                                        -0.02049514825,
                                        51.52801531325
                                    ],
                                    [
                                        -0.02097568354,
                                        51.52794693743
                                    ],
                                    [
                                        -0.02129496137,
                                        51.5278983681
                                    ],
                                    [
                                        -0.02142539775,
                                        51.52788258315
                                    ],
                                    [
                                        -0.02164344077,
                                        51.5278412978
                                    ],
                                    [
                                        -0.02251483027,
                                        51.52769412445
                                    ],
                                    [
                                        -0.02312534462,
                                        51.52757851873
                                    ],
                                    [
                                        -0.02405282473,
                                        51.52741907959
                                    ],
                                    [
                                        -0.02405282473,
                                        51.52741907959
                                    ],
                                    [
                                        -0.02431638482,
                                        51.52737377055
                                    ],
                                    [
                                        -0.02527652727,
                                        51.52717411591
                                    ],
                                    [
                                        -0.02548015745,
                                        51.52713258082
                                    ],
                                    [
                                        -0.02578618512,
                                        51.5270567984
                                    ],
                                    [
                                        -0.02729957199,
                                        51.52673154836
                                    ],
                                    [
                                        -0.02795483312,
                                        51.52658069969
                                    ],
                                    [
                                        -0.02819037621,
                                        51.52646775548
                                    ],
                                    [
                                        -0.02877204864,
                                        51.52635163566
                                    ],
                                    [
                                        -0.0291504834,
                                        51.52626806872
                                    ],
                                    [
                                        -0.02961500585,
                                        51.52617566223
                                    ],
                                    [
                                        -0.02961500585,
                                        51.52617566223
                                    ],
                                    [
                                        -0.02977575651,
                                        51.52614368392
                                    ],
                                    [
                                        -0.03004985603,
                                        51.52613929508
                                    ],
                                    [
                                        -0.03058830223,
                                        51.5260224403
                                    ],
                                    [
                                        -0.03140394456,
                                        51.52582930211
                                    ],
                                    [
                                        -0.031841931,
                                        51.5257017629
                                    ],
                                    [
                                        -0.03290517049,
                                        51.52544982034
                                    ],
                                    [
                                        -0.03313611985,
                                        51.52539663954
                                    ],
                                    [
                                        -0.03313611985,
                                        51.52539663954
                                    ],
                                    [
                                        -0.03341479025,
                                        51.52533246922
                                    ],
                                    [
                                        -0.03393997433,
                                        51.52518839894
                                    ],
                                    [
                                        -0.03440637189,
                                        51.52507031906
                                    ],
                                    [
                                        -0.03472755086,
                                        51.52497678211
                                    ],
                                    [
                                        -0.03488833331,
                                        51.52492552024
                                    ],
                                    [
                                        -0.03506313406,
                                        51.5248834856
                                    ],
                                    [
                                        -0.03560271341,
                                        51.52473964907
                                    ],
                                    [
                                        -0.0357771261,
                                        51.52470659949
                                    ],
                                    [
                                        -0.036084281,
                                        51.52460383139
                                    ],
                                    [
                                        -0.03671376695,
                                        51.52436186602
                                    ],
                                    [
                                        -0.03671376695,
                                        51.52436186602
                                    ],
                                    [
                                        -0.0368465056,
                                        51.52431084242
                                    ],
                                    [
                                        -0.03699287804,
                                        51.5242593365
                                    ],
                                    [
                                        -0.03715442837,
                                        51.52419009917
                                    ],
                                    [
                                        -0.03737437221,
                                        51.52410385348
                                    ],
                                    [
                                        -0.03749193284,
                                        51.52405186484
                                    ],
                                    [
                                        -0.03852347322,
                                        51.52352956292
                                    ],
                                    [
                                        -0.03927125766,
                                        51.52325511206
                                    ],
                                    [
                                        -0.03927125766,
                                        51.52325511206
                                    ],
                                    [
                                        -0.04004668843,
                                        51.52297050588
                                    ],
                                    [
                                        -0.04103972443,
                                        51.52267235391
                                    ],
                                    [
                                        -0.04186928357,
                                        51.52248836848
                                    ],
                                    [
                                        -0.04201448822,
                                        51.52246381468
                                    ],
                                    [
                                        -0.04233427395,
                                        51.52241674609
                                    ],
                                    [
                                        -0.04233427395,
                                        51.52241674609
                                    ],
                                    [
                                        -0.04327656815,
                                        51.52227804612
                                    ],
                                    [
                                        -0.04434714179,
                                        51.5221879898
                                    ],
                                    [
                                        -0.04565395832,
                                        51.52196697121
                                    ],
                                    [
                                        -0.0462211263,
                                        51.52185052367
                                    ],
                                    [
                                        -0.0466590495,
                                        51.52176189929
                                    ],
                                    [
                                        -0.0466590495,
                                        51.52176189929
                                    ],
                                    [
                                        -0.0469190866,
                                        51.52170927354
                                    ],
                                    [
                                        -0.04763144726,
                                        51.52156825898
                                    ],
                                    [
                                        -0.0490125581,
                                        51.52129448416
                                    ],
                                    [
                                        -0.04928714897,
                                        51.52123307027
                                    ],
                                    [
                                        -0.04928714897,
                                        51.52123307027
                                    ],
                                    [
                                        -0.04953649611,
                                        51.52117730158
                                    ],
                                    [
                                        -0.04979846414,
                                        51.5211187094
                                    ],
                                    [
                                        -0.05004564319,
                                        51.52106886338
                                    ],
                                    [
                                        -0.05090356352,
                                        51.52089427847
                                    ],
                                    [
                                        -0.05168907215,
                                        51.52072747711
                                    ],
                                    [
                                        -0.05219782589,
                                        51.52062801568
                                    ],
                                    [
                                        -0.05314247737,
                                        51.52044587506
                                    ],
                                    [
                                        -0.05314247737,
                                        51.52044587506
                                    ],
                                    [
                                        -0.05314253901,
                                        51.52044586317
                                    ],
                                    [
                                        -0.0534765197,
                                        51.52038845811
                                    ],
                                    [
                                        -0.05408686172,
                                        51.52027268921
                                    ],
                                    [
                                        -0.05504634736,
                                        51.52008177393
                                    ],
                                    [
                                        -0.05540879535,
                                        51.5200144453
                                    ],
                                    [
                                        -0.05540879535,
                                        51.5200144453
                                    ],
                                    [
                                        -0.05580187113,
                                        51.51994142573
                                    ],
                                    [
                                        -0.05638377594,
                                        51.51981618097
                                    ],
                                    [
                                        -0.05655739037,
                                        51.51980107261
                                    ],
                                    [
                                        -0.0568769582,
                                        51.51974341909
                                    ],
                                    [
                                        -0.05763285337,
                                        51.51959407271
                                    ],
                                    [
                                        -0.0579239927,
                                        51.51952695297
                                    ],
                                    [
                                        -0.05806917978,
                                        51.51950237909
                                    ],
                                    [
                                        -0.05921855923,
                                        51.51925162553
                                    ],
                                    [
                                        -0.0595532879,
                                        51.51917623043
                                    ],
                                    [
                                        -0.06045441391,
                                        51.51898307239
                                    ],
                                    [
                                        -0.06045441391,
                                        51.51898307239
                                    ],
                                    [
                                        -0.0607606485,
                                        51.51891742848
                                    ],
                                    [
                                        -0.06113896544,
                                        51.51883375696
                                    ],
                                    [
                                        -0.06148809182,
                                        51.51875859436
                                    ],
                                    [
                                        -0.06166284536,
                                        51.51871651953
                                    ],
                                    [
                                        -0.06275533382,
                                        51.51844680612
                                    ],
                                    [
                                        -0.06294410747,
                                        51.51841395355
                                    ],
                                    [
                                        -0.06400663087,
                                        51.51817071144
                                    ],
                                    [
                                        -0.0650857852,
                                        51.51787379221
                                    ],
                                    [
                                        -0.0650857852,
                                        51.51787379221
                                    ],
                                    [
                                        -0.0650858319,
                                        51.51787377936
                                    ],
                                    [
                                        -0.06568399319,
                                        51.51770379394
                                    ],
                                    [
                                        -0.06672186496,
                                        51.51736120237
                                    ],
                                    [
                                        -0.06701449908,
                                        51.51725811448
                                    ],
                                    [
                                        -0.06723397381,
                                        51.51718079807
                                    ],
                                    [
                                        -0.06779272756,
                                        51.51694826177
                                    ],
                                    [
                                        -0.06779272756,
                                        51.51694826177
                                    ],
                                    [
                                        -0.06798223587,
                                        51.51686939302
                                    ],
                                    [
                                        -0.06834992189,
                                        51.5166955974
                                    ],
                                    [
                                        -0.06945258325,
                                        51.51618318976
                                    ],
                                    [
                                        -0.0695117154,
                                        51.51614819271
                                    ],
                                    [
                                        -0.0695556845,
                                        51.51613093124
                                    ],
                                    [
                                        -0.06965878551,
                                        51.51607867263
                                    ],
                                    [
                                        -0.07020423244,
                                        51.51579089314
                                    ],
                                    [
                                        -0.07045439954,
                                        51.51566911284
                                    ],
                                    [
                                        -0.07067234199,
                                        51.51562773519
                                    ],
                                    [
                                        -0.07096457656,
                                        51.51553362355
                                    ],
                                    [
                                        -0.07150621322,
                                        51.51533570124
                                    ],
                                    [
                                        -0.07178366194,
                                        51.51525033704
                                    ],
                                    [
                                        -0.0725458851,
                                        51.51494812524
                                    ],
                                    [
                                        -0.07271909694,
                                        51.51494197905
                                    ],
                                    [
                                        -0.07327891882,
                                        51.51471987739
                                    ],
                                    [
                                        -0.07327891882,
                                        51.51471987739
                                    ],
                                    [
                                        -0.07343734267,
                                        51.51465702402
                                    ],
                                    [
                                        -0.07364201249,
                                        51.51458844512
                                    ],
                                    [
                                        -0.07380309485,
                                        51.51452814261
                                    ],
                                    [
                                        -0.07390618743,
                                        51.51447588017
                                    ],
                                    [
                                        -0.07409607415,
                                        51.51441605029
                                    ],
                                    [
                                        -0.07460698456,
                                        51.51426257215
                                    ],
                                    [
                                        -0.07482681116,
                                        51.51417625485
                                    ],
                                    [
                                        -0.07497256428,
                                        51.51412412591
                                    ],
                                    [
                                        -0.07497256428,
                                        51.51412412591
                                    ],
                                    [
                                        -0.07516337192,
                                        51.51405588266
                                    ],
                                    [
                                        -0.07560226278,
                                        51.51390121824
                                    ],
                                    [
                                        -0.0758217071,
                                        51.5138238854
                                    ],
                                    [
                                        -0.07595322187,
                                        51.51378108005
                                    ],
                                    [
                                        -0.07608511504,
                                        51.51372928817
                                    ],
                                    [
                                        -0.07653764491,
                                        51.51359282917
                                    ],
                                    [
                                        -0.07677148849,
                                        51.51351573071
                                    ],
                                    [
                                        -0.07751697793,
                                        51.51326716796
                                    ],
                                    [
                                        -0.07770458513,
                                        51.5132612504
                                    ],
                                    [
                                        -0.07931612309,
                                        51.51332362264
                                    ],
                                    [
                                        -0.07937323826,
                                        51.51332730673
                                    ],
                                    [
                                        -0.07937323826,
                                        51.51332730673
                                    ],
                                    [
                                        -0.07950297445,
                                        51.51333567498
                                    ],
                                    [
                                        -0.07980428824,
                                        51.51336758621
                                    ],
                                    [
                                        -0.08039213705,
                                        51.51344015703
                                    ],
                                    [
                                        -0.08145488714,
                                        51.51352948682
                                    ],
                                    [
                                        -0.08168683469,
                                        51.51349731046
                                    ],
                                    [
                                        -0.08269621989,
                                        51.51347348309
                                    ],
                                    [
                                        -0.08269621989,
                                        51.51347348309
                                    ],
                                    [
                                        -0.08281210348,
                                        51.513470747
                                    ],
                                    [
                                        -0.08336203258,
                                        51.51341678702
                                    ],
                                    [
                                        -0.08411246157,
                                        51.51339307757
                                    ],
                                    [
                                        -0.0845009472,
                                        51.5134084155
                                    ],
                                    [
                                        -0.08480377297,
                                        51.51340436826
                                    ],
                                    [
                                        -0.08513578022,
                                        51.51339180411
                                    ],
                                    [
                                        -0.08562621288,
                                        51.51338182499
                                    ],
                                    [
                                        -0.0859006105,
                                        51.51336831834
                                    ],
                                    [
                                        -0.08604463375,
                                        51.5133706687
                                    ],
                                    [
                                        -0.08616022901,
                                        51.51336356245
                                    ],
                                    [
                                        -0.08641984747,
                                        51.51335880598
                                    ],
                                    [
                                        -0.08647745678,
                                        51.5133597459
                                    ],
                                    [
                                        -0.08695423961,
                                        51.51333155339
                                    ],
                                    [
                                        -0.08745869735,
                                        51.51333078795
                                    ],
                                    [
                                        -0.08774709341,
                                        51.51333062706
                                    ],
                                    [
                                        -0.08774709341,
                                        51.51333062706
                                    ],
                                    [
                                        -0.08799195979,
                                        51.51333048991
                                    ],
                                    [
                                        -0.08897019033,
                                        51.51337341077
                                    ],
                                    [
                                        -0.08907138287,
                                        51.51336606697
                                    ],
                                    [
                                        -0.08947389673,
                                        51.51339060954
                                    ],
                                    [
                                        -0.08973614683,
                                        51.51332294064
                                    ],
                                    [
                                        -0.09059527975,
                                        51.5131121163
                                    ],
                                    [
                                        -0.09081356839,
                                        51.51306171443
                                    ],
                                    [
                                        -0.09087155319,
                                        51.51305366574
                                    ],
                                    [
                                        -0.09146730469,
                                        51.51293746573
                                    ],
                                    [
                                        -0.09145791461,
                                        51.51316212703
                                    ],
                                    [
                                        -0.09136324501,
                                        51.5133584062
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "tfl-bus",
                                "lineModeName": "Bus",
                                "lines": [
                                    {
                                        "lineId": "tfl-25",
                                        "lineName": "25",
                                        "linePrimaryColour": "#E1251B"
                                    }
                                ],
                                "primaryAreaName": "London",
                                "branding": {
                                    "lineModeLogoUrl": "https://cdn.tomk.online/cdn/GoTravelBranding/bus.png",
                                    "lineModeBackgroundColour": "#E1251B",
                                    "lineModePrimaryColour": "#E1251B",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": []
                            },
                            "stopPoints": [
                                {
                                    "stopPointId": "940GZZDLBOW",
                                    "stopPointName": "Bow Church DLR Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.020936,
                                            51.527858
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLUBWR",
                                    "stopPointName": "Bow Road Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.025128,
                                            51.52694
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLUMED",
                                    "stopPointName": "Mile End Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.03364,
                                            51.525122
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLUSGN",
                                    "stopPointName": "Stepney Green Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.046596,
                                            51.521858
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLUADE",
                                    "stopPointName": "Aldgate East Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.072384,
                                            51.515037
                                        ]
                                    }
                                },
                                {
                                    "stopPointId": "940GZZLUALD",
                                    "stopPointName": "Aldgate Underground Station",
                                    "stopCoordinate": {
                                        "type": "Point",
                                        "coordinates": [
                                            -0.075689,
                                            51.514246
                                        ]
                                    }
                                }
                            ]
                        }
                    },
                    {
                        "beginLegAt": "2024-02-10T15:32:00",
                        "endLegAt": "2024-02-10T15:35:00",
                        "legDuration": 3,
                        "startAtName": "Poultry / Bank Station",
                        "endAtName": "108 Cheapside, City",
                        "startAtStop": null,
                        "endAtStop": null,
                        "legDetails": {
                            "summary": "Walk to 108 Cheapside, City",
                            "detailedSummary": "Walk to 108 Cheapside, City",
                            "legSteps": [
                                {
                                    "summary": "Continue along  Poultry for 5 metres",
                                    "direction": "West",
                                    "latitude": 51.513624265989996,
                                    "longitude": -0.09112152894,
                                    "distanceOfStep": 5
                                },
                                {
                                    "summary": "Continue along  on to Cheapside, continue for 173 metres",
                                    "direction": "West",
                                    "latitude": 51.513634424450004,
                                    "longitude": -0.09119316552,
                                    "distanceOfStep": 173
                                }
                            ],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.09112152894,
                                        51.51362426599
                                    ],
                                    [
                                        -0.09117876306,
                                        51.51363419005
                                    ],
                                    [
                                        -0.09119316552,
                                        51.51363442445
                                    ],
                                    [
                                        -0.09156575137,
                                        51.51368545042
                                    ],
                                    [
                                        -0.09209488806,
                                        51.51378398474
                                    ],
                                    [
                                        -0.09232382641,
                                        51.51382367892
                                    ],
                                    [
                                        -0.09255276518,
                                        51.51386337266
                                    ],
                                    [
                                        -0.09315316845,
                                        51.51398104629
                                    ],
                                    [
                                        -0.09359702208,
                                        51.51405120955
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "walking",
                                "lineModeName": "Walk",
                                "lines": [],
                                "primaryAreaName": "",
                                "branding": {
                                    "lineModeLogoUrl": "",
                                    "lineModeBackgroundColour": "",
                                    "lineModePrimaryColour": "",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": null
                            },
                            "stopPoints": []
                        }
                    }
                ]
            },
            {
                "beginJourneyAt": "2024-02-10T14:47:00",
                "endJourneyAt": "2024-02-10T15:12:00",
                "totalDuration": 25,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-10T14:47:00",
                        "endLegAt": "2024-02-10T15:12:00",
                        "legDuration": 25,
                        "startAtName": "1 Bow Interchange",
                        "endAtName": "108 Cheapside",
                        "startAtStop": null,
                        "endAtStop": null,
                        "legDetails": {
                            "summary": "Cycle to 108 Cheapside",
                            "detailedSummary": "Cycle to 108 Cheapside",
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn left on to Bow Interchange, continue for 290 metres",
                                    "direction": "NorthEast",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 290
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 843 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52876791257,
                                    "longitude": -0.01634100333,
                                    "distanceOfStep": 843
                                },
                                {
                                    "summary": "Continue along  on to Mile End Road, continue for 2133 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52658069969,
                                    "longitude": -0.027954833119999998,
                                    "distanceOfStep": 2133
                                },
                                {
                                    "summary": "Continue along  on to Whitechapel Road, continue for 1020 metres",
                                    "direction": "West",
                                    "latitude": 51.51981618097,
                                    "longitude": -0.05638377594,
                                    "distanceOfStep": 1020
                                },
                                {
                                    "summary": "Continue along  on to Whitechapel High Street, continue for 348 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.516078672629995,
                                    "longitude": -0.06965878551,
                                    "distanceOfStep": 348
                                },
                                {
                                    "summary": "Continue along  on to Aldgate High Street, continue for 297 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.514475880170004,
                                    "longitude": -0.07390618743,
                                    "distanceOfStep": 297
                                },
                                {
                                    "summary": "Continue along  on to Leadenhall Street, continue for 447 metres",
                                    "direction": "West",
                                    "latitude": 51.5132612504,
                                    "longitude": -0.07770458513,
                                    "distanceOfStep": 447
                                },
                                {
                                    "summary": "Continue along  on to Cornhill, continue for 337 metres",
                                    "direction": "West",
                                    "latitude": 51.51339307757,
                                    "longitude": -0.08411246157,
                                    "distanceOfStep": 337
                                },
                                {
                                    "summary": "Continue along  on to Mansion House Street, continue for 35 metres",
                                    "direction": "West",
                                    "latitude": 51.51337341077,
                                    "longitude": -0.08897019033,
                                    "distanceOfStep": 35
                                },
                                {
                                    "summary": "Continue along  on to Poultry, continue for 122 metres",
                                    "direction": "West",
                                    "latitude": 51.513390609540004,
                                    "longitude": -0.08947389672999999,
                                    "distanceOfStep": 122
                                },
                                {
                                    "summary": "Continue along  on to Cheapside, continue for 172 metres",
                                    "direction": "West",
                                    "latitude": 51.513634424450004,
                                    "longitude": -0.09119316552,
                                    "distanceOfStep": 172
                                }
                            ],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.01679047585,
                                        51.5306999359
                                    ],
                                    [
                                        -0.01679319024,
                                        51.53070453487
                                    ],
                                    [
                                        -0.01606821247,
                                        51.53042736471
                                    ],
                                    [
                                        -0.01606703874,
                                        51.53042691597
                                    ],
                                    [
                                        -0.01518826001,
                                        51.530079322
                                    ],
                                    [
                                        -0.01563341595,
                                        51.52945736945
                                    ],
                                    [
                                        -0.01559605695,
                                        51.52932184794
                                    ],
                                    [
                                        -0.01443993862,
                                        51.52971594447
                                    ],
                                    [
                                        -0.01438543916,
                                        51.52964308084
                                    ],
                                    [
                                        -0.01418882685,
                                        51.52952284817
                                    ],
                                    [
                                        -0.01515648285,
                                        51.52915254311
                                    ],
                                    [
                                        -0.01634100333,
                                        51.52876791257
                                    ],
                                    [
                                        -0.01676426169,
                                        51.52864917288
                                    ],
                                    [
                                        -0.01785763366,
                                        51.52837089755
                                    ],
                                    [
                                        -0.01811929171,
                                        51.52832136313
                                    ],
                                    [
                                        -0.01909154603,
                                        51.52817591932
                                    ],
                                    [
                                        -0.01990220498,
                                        51.5280996807
                                    ],
                                    [
                                        -0.02097568354,
                                        51.52794693743
                                    ],
                                    [
                                        -0.02129496137,
                                        51.5278983681
                                    ],
                                    [
                                        -0.02142539775,
                                        51.52788258315
                                    ],
                                    [
                                        -0.02164344077,
                                        51.5278412978
                                    ],
                                    [
                                        -0.02251483027,
                                        51.52769412445
                                    ],
                                    [
                                        -0.02312534462,
                                        51.52757851873
                                    ],
                                    [
                                        -0.02431638482,
                                        51.52737377055
                                    ],
                                    [
                                        -0.02527652727,
                                        51.52717411591
                                    ],
                                    [
                                        -0.02548015745,
                                        51.52713258082
                                    ],
                                    [
                                        -0.02578618512,
                                        51.5270567984
                                    ],
                                    [
                                        -0.02729957199,
                                        51.52673154836
                                    ],
                                    [
                                        -0.02795483312,
                                        51.52658069969
                                    ],
                                    [
                                        -0.02819037621,
                                        51.52646775548
                                    ],
                                    [
                                        -0.02877204864,
                                        51.52635163566
                                    ],
                                    [
                                        -0.0291504834,
                                        51.52626806872
                                    ],
                                    [
                                        -0.02977575651,
                                        51.52614368392
                                    ],
                                    [
                                        -0.03004985603,
                                        51.52613929508
                                    ],
                                    [
                                        -0.03058830223,
                                        51.5260224403
                                    ],
                                    [
                                        -0.03140394456,
                                        51.52582930211
                                    ],
                                    [
                                        -0.031841931,
                                        51.5257017629
                                    ],
                                    [
                                        -0.03290517049,
                                        51.52544982034
                                    ],
                                    [
                                        -0.03341479025,
                                        51.52533246922
                                    ],
                                    [
                                        -0.03393997433,
                                        51.52518839894
                                    ],
                                    [
                                        -0.03440637189,
                                        51.52507031906
                                    ],
                                    [
                                        -0.03472755086,
                                        51.52497678211
                                    ],
                                    [
                                        -0.03488833331,
                                        51.52492552024
                                    ],
                                    [
                                        -0.03506313406,
                                        51.5248834856
                                    ],
                                    [
                                        -0.03560271341,
                                        51.52473964907
                                    ],
                                    [
                                        -0.0357771261,
                                        51.52470659949
                                    ],
                                    [
                                        -0.036084281,
                                        51.52460383139
                                    ],
                                    [
                                        -0.0368465056,
                                        51.52431084242
                                    ],
                                    [
                                        -0.03699287804,
                                        51.5242593365
                                    ],
                                    [
                                        -0.03715442837,
                                        51.52419009917
                                    ],
                                    [
                                        -0.03737437221,
                                        51.52410385348
                                    ],
                                    [
                                        -0.03749193284,
                                        51.52405186484
                                    ],
                                    [
                                        -0.03852347322,
                                        51.52352956292
                                    ],
                                    [
                                        -0.04004668843,
                                        51.52297050588
                                    ],
                                    [
                                        -0.04103972443,
                                        51.52267235391
                                    ],
                                    [
                                        -0.04186928357,
                                        51.52248836848
                                    ],
                                    [
                                        -0.04201448822,
                                        51.52246381468
                                    ],
                                    [
                                        -0.04327656815,
                                        51.52227804612
                                    ],
                                    [
                                        -0.04434714179,
                                        51.5221879898
                                    ],
                                    [
                                        -0.04565395832,
                                        51.52196697121
                                    ],
                                    [
                                        -0.0462211263,
                                        51.52185052367
                                    ],
                                    [
                                        -0.0469190866,
                                        51.52170927354
                                    ],
                                    [
                                        -0.04763144726,
                                        51.52156825898
                                    ],
                                    [
                                        -0.0490125581,
                                        51.52129448416
                                    ],
                                    [
                                        -0.04953649611,
                                        51.52117730158
                                    ],
                                    [
                                        -0.04979846414,
                                        51.5211187094
                                    ],
                                    [
                                        -0.05004564319,
                                        51.52106886338
                                    ],
                                    [
                                        -0.05090356352,
                                        51.52089427847
                                    ],
                                    [
                                        -0.05168907215,
                                        51.52072747711
                                    ],
                                    [
                                        -0.05219782589,
                                        51.52062801568
                                    ],
                                    [
                                        -0.05314253901,
                                        51.52044586317
                                    ],
                                    [
                                        -0.0534765197,
                                        51.52038845811
                                    ],
                                    [
                                        -0.05408686172,
                                        51.52027268921
                                    ],
                                    [
                                        -0.05504634736,
                                        51.52008177393
                                    ],
                                    [
                                        -0.05580187113,
                                        51.51994142573
                                    ],
                                    [
                                        -0.05638377594,
                                        51.51981618097
                                    ],
                                    [
                                        -0.05655739037,
                                        51.51980107261
                                    ],
                                    [
                                        -0.0568769582,
                                        51.51974341909
                                    ],
                                    [
                                        -0.05763285337,
                                        51.51959407271
                                    ],
                                    [
                                        -0.0579239927,
                                        51.51952695297
                                    ],
                                    [
                                        -0.05806917978,
                                        51.51950237909
                                    ],
                                    [
                                        -0.05921855923,
                                        51.51925162553
                                    ],
                                    [
                                        -0.0595532879,
                                        51.51917623043
                                    ],
                                    [
                                        -0.0607606485,
                                        51.51891742848
                                    ],
                                    [
                                        -0.06113896544,
                                        51.51883375696
                                    ],
                                    [
                                        -0.06148809182,
                                        51.51875859436
                                    ],
                                    [
                                        -0.06166284536,
                                        51.51871651953
                                    ],
                                    [
                                        -0.06275533382,
                                        51.51844680612
                                    ],
                                    [
                                        -0.06294410747,
                                        51.51841395355
                                    ],
                                    [
                                        -0.06400663087,
                                        51.51817071144
                                    ],
                                    [
                                        -0.0650858319,
                                        51.51787377936
                                    ],
                                    [
                                        -0.06568399319,
                                        51.51770379394
                                    ],
                                    [
                                        -0.06672186496,
                                        51.51736120237
                                    ],
                                    [
                                        -0.06701449908,
                                        51.51725811448
                                    ],
                                    [
                                        -0.06723397381,
                                        51.51718079807
                                    ],
                                    [
                                        -0.06798223587,
                                        51.51686939302
                                    ],
                                    [
                                        -0.06834992189,
                                        51.5166955974
                                    ],
                                    [
                                        -0.06945258325,
                                        51.51618318976
                                    ],
                                    [
                                        -0.0695117154,
                                        51.51614819271
                                    ],
                                    [
                                        -0.0695556845,
                                        51.51613093124
                                    ],
                                    [
                                        -0.06965878551,
                                        51.51607867263
                                    ],
                                    [
                                        -0.07020423244,
                                        51.51579089314
                                    ],
                                    [
                                        -0.07045439954,
                                        51.51566911284
                                    ],
                                    [
                                        -0.07067234199,
                                        51.51562773519
                                    ],
                                    [
                                        -0.07096457656,
                                        51.51553362355
                                    ],
                                    [
                                        -0.07150621322,
                                        51.51533570124
                                    ],
                                    [
                                        -0.07178366194,
                                        51.51525033704
                                    ],
                                    [
                                        -0.0725458851,
                                        51.51494812524
                                    ],
                                    [
                                        -0.07271909694,
                                        51.51494197905
                                    ],
                                    [
                                        -0.07343734267,
                                        51.51465702402
                                    ],
                                    [
                                        -0.07364201249,
                                        51.51458844512
                                    ],
                                    [
                                        -0.07380309485,
                                        51.51452814261
                                    ],
                                    [
                                        -0.07390618743,
                                        51.51447588017
                                    ],
                                    [
                                        -0.07409607415,
                                        51.51441605029
                                    ],
                                    [
                                        -0.07460698456,
                                        51.51426257215
                                    ],
                                    [
                                        -0.07482681116,
                                        51.51417625485
                                    ],
                                    [
                                        -0.07516337192,
                                        51.51405588266
                                    ],
                                    [
                                        -0.07560226278,
                                        51.51390121824
                                    ],
                                    [
                                        -0.0758217071,
                                        51.5138238854
                                    ],
                                    [
                                        -0.07595322187,
                                        51.51378108005
                                    ],
                                    [
                                        -0.07608511504,
                                        51.51372928817
                                    ],
                                    [
                                        -0.07653764491,
                                        51.51359282917
                                    ],
                                    [
                                        -0.07677148849,
                                        51.51351573071
                                    ],
                                    [
                                        -0.07751697793,
                                        51.51326716796
                                    ],
                                    [
                                        -0.07770458513,
                                        51.5132612504
                                    ],
                                    [
                                        -0.07931612309,
                                        51.51332362264
                                    ],
                                    [
                                        -0.07950297445,
                                        51.51333567498
                                    ],
                                    [
                                        -0.07980428824,
                                        51.51336758621
                                    ],
                                    [
                                        -0.08039213705,
                                        51.51344015703
                                    ],
                                    [
                                        -0.08145488714,
                                        51.51352948682
                                    ],
                                    [
                                        -0.08168683469,
                                        51.51349731046
                                    ],
                                    [
                                        -0.08281210348,
                                        51.513470747
                                    ],
                                    [
                                        -0.08336203258,
                                        51.51341678702
                                    ],
                                    [
                                        -0.08411246157,
                                        51.51339307757
                                    ],
                                    [
                                        -0.0845009472,
                                        51.5134084155
                                    ],
                                    [
                                        -0.08480377297,
                                        51.51340436826
                                    ],
                                    [
                                        -0.08513578022,
                                        51.51339180411
                                    ],
                                    [
                                        -0.08562621288,
                                        51.51338182499
                                    ],
                                    [
                                        -0.0859006105,
                                        51.51336831834
                                    ],
                                    [
                                        -0.08604463375,
                                        51.5133706687
                                    ],
                                    [
                                        -0.08616022901,
                                        51.51336356245
                                    ],
                                    [
                                        -0.08641984747,
                                        51.51335880598
                                    ],
                                    [
                                        -0.08647745678,
                                        51.5133597459
                                    ],
                                    [
                                        -0.08695423961,
                                        51.51333155339
                                    ],
                                    [
                                        -0.08745869735,
                                        51.51333078795
                                    ],
                                    [
                                        -0.08799195979,
                                        51.51333048991
                                    ],
                                    [
                                        -0.08897019033,
                                        51.51337341077
                                    ],
                                    [
                                        -0.08907138287,
                                        51.51336606697
                                    ],
                                    [
                                        -0.08947389673,
                                        51.51339060954
                                    ],
                                    [
                                        -0.0897896209,
                                        51.51342272979
                                    ],
                                    [
                                        -0.09066328108,
                                        51.51355385899
                                    ],
                                    [
                                        -0.09077774897,
                                        51.51357370752
                                    ],
                                    [
                                        -0.09119316552,
                                        51.51363442445
                                    ],
                                    [
                                        -0.09156575137,
                                        51.51368545042
                                    ],
                                    [
                                        -0.09209488806,
                                        51.51378398474
                                    ],
                                    [
                                        -0.09232382641,
                                        51.51382367892
                                    ],
                                    [
                                        -0.09255276518,
                                        51.51386337266
                                    ],
                                    [
                                        -0.09315316845,
                                        51.51398104629
                                    ],
                                    [
                                        -0.09360152817,
                                        51.51404804668
                                    ],
                                    [
                                        -0.09359702208,
                                        51.51405120955
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "cycle",
                                "lineModeName": "Cycle",
                                "lines": [],
                                "primaryAreaName": "",
                                "branding": {
                                    "lineModeLogoUrl": "",
                                    "lineModeBackgroundColour": "",
                                    "lineModePrimaryColour": "",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": null
                            },
                            "stopPoints": []
                        }
                    }
                ]
            },
            {
                "beginJourneyAt": "2024-02-10T14:47:00",
                "endJourneyAt": "2024-02-10T16:17:00",
                "totalDuration": 90,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-10T14:47:00",
                        "endLegAt": "2024-02-10T16:17:00",
                        "legDuration": 90,
                        "startAtName": "1 Bow Interchange",
                        "endAtName": "108 Cheapside",
                        "startAtStop": null,
                        "endAtStop": null,
                        "legDetails": {
                            "summary": "Cycle to 108 Cheapside",
                            "detailedSummary": "Cycle to 108 Cheapside",
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn right on to Bow Interchange, continue for 42 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 42
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 871 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.529141914549996,
                                    "longitude": -0.016122903969999998,
                                    "distanceOfStep": 871
                                },
                                {
                                    "summary": "Continue along  on to Mile End Road, continue for 2130 metres",
                                    "direction": "West",
                                    "latitude": 51.52658069969,
                                    "longitude": -0.027954833119999998,
                                    "distanceOfStep": 2130
                                },
                                {
                                    "summary": "Continue along  on to Whitechapel Road, continue for 1020 metres",
                                    "direction": "West",
                                    "latitude": 51.51981618097,
                                    "longitude": -0.05638377594,
                                    "distanceOfStep": 1020
                                },
                                {
                                    "summary": "Continue along  on to Whitechapel High Street, continue for 348 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.516078672629995,
                                    "longitude": -0.06965878551,
                                    "distanceOfStep": 348
                                },
                                {
                                    "summary": "Continue along  on to Aldgate High Street, continue for 297 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.514475880170004,
                                    "longitude": -0.07390618743,
                                    "distanceOfStep": 297
                                },
                                {
                                    "summary": "Continue along  on to Leadenhall Street, continue for 447 metres",
                                    "direction": "West",
                                    "latitude": 51.5132612504,
                                    "longitude": -0.07770458513,
                                    "distanceOfStep": 447
                                },
                                {
                                    "summary": "Continue along  on to Cornhill, continue for 337 metres",
                                    "direction": "West",
                                    "latitude": 51.51339307757,
                                    "longitude": -0.08411246157,
                                    "distanceOfStep": 337
                                },
                                {
                                    "summary": "Continue along  on to Mansion House Street, continue for 35 metres",
                                    "direction": "West",
                                    "latitude": 51.51337341077,
                                    "longitude": -0.08897019033,
                                    "distanceOfStep": 35
                                },
                                {
                                    "summary": "Continue along  on to Poultry, continue for 122 metres",
                                    "direction": "West",
                                    "latitude": 51.513390609540004,
                                    "longitude": -0.08947389672999999,
                                    "distanceOfStep": 122
                                },
                                {
                                    "summary": "Continue along  on to Cheapside, continue for 172 metres",
                                    "direction": "West",
                                    "latitude": 51.513634424450004,
                                    "longitude": -0.09119316552,
                                    "distanceOfStep": 172
                                }
                            ],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.01679047585,
                                        51.5306999359
                                    ],
                                    [
                                        -0.01679319024,
                                        51.53070453487
                                    ],
                                    [
                                        -0.01606821247,
                                        51.53042736471
                                    ],
                                    [
                                        -0.01606703874,
                                        51.53042691597
                                    ],
                                    [
                                        -0.01518826001,
                                        51.530079322
                                    ],
                                    [
                                        -0.01563341595,
                                        51.52945736945
                                    ],
                                    [
                                        -0.01559605695,
                                        51.52932184794
                                    ],
                                    [
                                        -0.01612290397,
                                        51.52914191455
                                    ],
                                    [
                                        -0.01755545128,
                                        51.52868952544
                                    ],
                                    [
                                        -0.01808345421,
                                        51.52848262495
                                    ],
                                    [
                                        -0.01824426719,
                                        51.52843138626
                                    ],
                                    [
                                        -0.01894280081,
                                        51.52828131876
                                    ],
                                    [
                                        -0.01917486427,
                                        51.52824926741
                                    ],
                                    [
                                        -0.01990220498,
                                        51.5280996807
                                    ],
                                    [
                                        -0.02097568354,
                                        51.52794693743
                                    ],
                                    [
                                        -0.02129496137,
                                        51.5278983681
                                    ],
                                    [
                                        -0.02142539775,
                                        51.52788258315
                                    ],
                                    [
                                        -0.02164344077,
                                        51.5278412978
                                    ],
                                    [
                                        -0.02251483027,
                                        51.52769412445
                                    ],
                                    [
                                        -0.02312534462,
                                        51.52757851873
                                    ],
                                    [
                                        -0.02431638482,
                                        51.52737377055
                                    ],
                                    [
                                        -0.02527652727,
                                        51.52717411591
                                    ],
                                    [
                                        -0.02548015745,
                                        51.52713258082
                                    ],
                                    [
                                        -0.02578618512,
                                        51.5270567984
                                    ],
                                    [
                                        -0.02729957199,
                                        51.52673154836
                                    ],
                                    [
                                        -0.02795483312,
                                        51.52658069969
                                    ],
                                    [
                                        -0.0288117734,
                                        51.52643323684
                                    ],
                                    [
                                        -0.02916139691,
                                        51.52634918567
                                    ],
                                    [
                                        -0.02983066463,
                                        51.52620755454
                                    ],
                                    [
                                        -0.03004985603,
                                        51.52613929508
                                    ],
                                    [
                                        -0.03058830223,
                                        51.5260224403
                                    ],
                                    [
                                        -0.03140394456,
                                        51.52582930211
                                    ],
                                    [
                                        -0.03202726844,
                                        51.52574983574
                                    ],
                                    [
                                        -0.03307532786,
                                        51.52551562217
                                    ],
                                    [
                                        -0.03352693808,
                                        51.52540629039
                                    ],
                                    [
                                        -0.03416814184,
                                        51.52524617891
                                    ],
                                    [
                                        -0.03454694494,
                                        51.52515360821
                                    ],
                                    [
                                        -0.03479532251,
                                        51.52507683638
                                    ],
                                    [
                                        -0.03492652033,
                                        51.525043064
                                    ],
                                    [
                                        -0.03564438287,
                                        51.52477631739
                                    ],
                                    [
                                        -0.0357771261,
                                        51.52470659949
                                    ],
                                    [
                                        -0.036084281,
                                        51.52460383139
                                    ],
                                    [
                                        -0.0368465056,
                                        51.52431084242
                                    ],
                                    [
                                        -0.03699287804,
                                        51.5242593365
                                    ],
                                    [
                                        -0.03715442837,
                                        51.52419009917
                                    ],
                                    [
                                        -0.03737437221,
                                        51.52410385348
                                    ],
                                    [
                                        -0.03749193284,
                                        51.52405186484
                                    ],
                                    [
                                        -0.03852347322,
                                        51.52352956292
                                    ],
                                    [
                                        -0.04004668843,
                                        51.52297050588
                                    ],
                                    [
                                        -0.04103972443,
                                        51.52267235391
                                    ],
                                    [
                                        -0.04186928357,
                                        51.52248836848
                                    ],
                                    [
                                        -0.04201448822,
                                        51.52246381468
                                    ],
                                    [
                                        -0.04327656815,
                                        51.52227804612
                                    ],
                                    [
                                        -0.04434714179,
                                        51.5221879898
                                    ],
                                    [
                                        -0.04565395832,
                                        51.52196697121
                                    ],
                                    [
                                        -0.0462211263,
                                        51.52185052367
                                    ],
                                    [
                                        -0.0469190866,
                                        51.52170927354
                                    ],
                                    [
                                        -0.04763144726,
                                        51.52156825898
                                    ],
                                    [
                                        -0.0490125581,
                                        51.52129448416
                                    ],
                                    [
                                        -0.04953649611,
                                        51.52117730158
                                    ],
                                    [
                                        -0.04979846414,
                                        51.5211187094
                                    ],
                                    [
                                        -0.05004564319,
                                        51.52106886338
                                    ],
                                    [
                                        -0.05090356352,
                                        51.52089427847
                                    ],
                                    [
                                        -0.05168907215,
                                        51.52072747711
                                    ],
                                    [
                                        -0.05219782589,
                                        51.52062801568
                                    ],
                                    [
                                        -0.05314253901,
                                        51.52044586317
                                    ],
                                    [
                                        -0.0534765197,
                                        51.52038845811
                                    ],
                                    [
                                        -0.05408686172,
                                        51.52027268921
                                    ],
                                    [
                                        -0.05504634736,
                                        51.52008177393
                                    ],
                                    [
                                        -0.05580187113,
                                        51.51994142573
                                    ],
                                    [
                                        -0.05638377594,
                                        51.51981618097
                                    ],
                                    [
                                        -0.05655739037,
                                        51.51980107261
                                    ],
                                    [
                                        -0.0568769582,
                                        51.51974341909
                                    ],
                                    [
                                        -0.05763285337,
                                        51.51959407271
                                    ],
                                    [
                                        -0.0579239927,
                                        51.51952695297
                                    ],
                                    [
                                        -0.05806917978,
                                        51.51950237909
                                    ],
                                    [
                                        -0.05921855923,
                                        51.51925162553
                                    ],
                                    [
                                        -0.0595532879,
                                        51.51917623043
                                    ],
                                    [
                                        -0.0607606485,
                                        51.51891742848
                                    ],
                                    [
                                        -0.06113896544,
                                        51.51883375696
                                    ],
                                    [
                                        -0.06148809182,
                                        51.51875859436
                                    ],
                                    [
                                        -0.06166284536,
                                        51.51871651953
                                    ],
                                    [
                                        -0.06275533382,
                                        51.51844680612
                                    ],
                                    [
                                        -0.06294410747,
                                        51.51841395355
                                    ],
                                    [
                                        -0.06400663087,
                                        51.51817071144
                                    ],
                                    [
                                        -0.0650858319,
                                        51.51787377936
                                    ],
                                    [
                                        -0.06568399319,
                                        51.51770379394
                                    ],
                                    [
                                        -0.06672186496,
                                        51.51736120237
                                    ],
                                    [
                                        -0.06701449908,
                                        51.51725811448
                                    ],
                                    [
                                        -0.06723397381,
                                        51.51718079807
                                    ],
                                    [
                                        -0.06798223587,
                                        51.51686939302
                                    ],
                                    [
                                        -0.06834992189,
                                        51.5166955974
                                    ],
                                    [
                                        -0.06945258325,
                                        51.51618318976
                                    ],
                                    [
                                        -0.0695117154,
                                        51.51614819271
                                    ],
                                    [
                                        -0.0695556845,
                                        51.51613093124
                                    ],
                                    [
                                        -0.06965878551,
                                        51.51607867263
                                    ],
                                    [
                                        -0.07020423244,
                                        51.51579089314
                                    ],
                                    [
                                        -0.07045439954,
                                        51.51566911284
                                    ],
                                    [
                                        -0.07067234199,
                                        51.51562773519
                                    ],
                                    [
                                        -0.07096457656,
                                        51.51553362355
                                    ],
                                    [
                                        -0.07150621322,
                                        51.51533570124
                                    ],
                                    [
                                        -0.07178366194,
                                        51.51525033704
                                    ],
                                    [
                                        -0.07207399463,
                                        51.5152011543
                                    ],
                                    [
                                        -0.07261486395,
                                        51.51502119947
                                    ],
                                    [
                                        -0.07271909694,
                                        51.51494197905
                                    ],
                                    [
                                        -0.07343734267,
                                        51.51465702402
                                    ],
                                    [
                                        -0.07364201249,
                                        51.51458844512
                                    ],
                                    [
                                        -0.07380309485,
                                        51.51452814261
                                    ],
                                    [
                                        -0.07390618743,
                                        51.51447588017
                                    ],
                                    [
                                        -0.07409607415,
                                        51.51441605029
                                    ],
                                    [
                                        -0.07460698456,
                                        51.51426257215
                                    ],
                                    [
                                        -0.07482681116,
                                        51.51417625485
                                    ],
                                    [
                                        -0.07516337192,
                                        51.51405588266
                                    ],
                                    [
                                        -0.07560226278,
                                        51.51390121824
                                    ],
                                    [
                                        -0.0758217071,
                                        51.5138238854
                                    ],
                                    [
                                        -0.07595322187,
                                        51.51378108005
                                    ],
                                    [
                                        -0.07608511504,
                                        51.51372928817
                                    ],
                                    [
                                        -0.07653764491,
                                        51.51359282917
                                    ],
                                    [
                                        -0.07677148849,
                                        51.51351573071
                                    ],
                                    [
                                        -0.07751697793,
                                        51.51326716796
                                    ],
                                    [
                                        -0.07770458513,
                                        51.5132612504
                                    ],
                                    [
                                        -0.07931612309,
                                        51.51332362264
                                    ],
                                    [
                                        -0.07950297445,
                                        51.51333567498
                                    ],
                                    [
                                        -0.07980428824,
                                        51.51336758621
                                    ],
                                    [
                                        -0.08039213705,
                                        51.51344015703
                                    ],
                                    [
                                        -0.08145488714,
                                        51.51352948682
                                    ],
                                    [
                                        -0.08168683469,
                                        51.51349731046
                                    ],
                                    [
                                        -0.08281210348,
                                        51.513470747
                                    ],
                                    [
                                        -0.08336203258,
                                        51.51341678702
                                    ],
                                    [
                                        -0.08411246157,
                                        51.51339307757
                                    ],
                                    [
                                        -0.0845009472,
                                        51.5134084155
                                    ],
                                    [
                                        -0.08480377297,
                                        51.51340436826
                                    ],
                                    [
                                        -0.08513578022,
                                        51.51339180411
                                    ],
                                    [
                                        -0.08562621288,
                                        51.51338182499
                                    ],
                                    [
                                        -0.0859006105,
                                        51.51336831834
                                    ],
                                    [
                                        -0.08604463375,
                                        51.5133706687
                                    ],
                                    [
                                        -0.08616022901,
                                        51.51336356245
                                    ],
                                    [
                                        -0.08641984747,
                                        51.51335880598
                                    ],
                                    [
                                        -0.08647745678,
                                        51.5133597459
                                    ],
                                    [
                                        -0.08695423961,
                                        51.51333155339
                                    ],
                                    [
                                        -0.08745869735,
                                        51.51333078795
                                    ],
                                    [
                                        -0.08799195979,
                                        51.51333048991
                                    ],
                                    [
                                        -0.08897019033,
                                        51.51337341077
                                    ],
                                    [
                                        -0.08907138287,
                                        51.51336606697
                                    ],
                                    [
                                        -0.08947389673,
                                        51.51339060954
                                    ],
                                    [
                                        -0.0897896209,
                                        51.51342272979
                                    ],
                                    [
                                        -0.09066328108,
                                        51.51355385899
                                    ],
                                    [
                                        -0.09077774897,
                                        51.51357370752
                                    ],
                                    [
                                        -0.09119316552,
                                        51.51363442445
                                    ],
                                    [
                                        -0.09156575137,
                                        51.51368545042
                                    ],
                                    [
                                        -0.09209488806,
                                        51.51378398474
                                    ],
                                    [
                                        -0.09232382641,
                                        51.51382367892
                                    ],
                                    [
                                        -0.09255276518,
                                        51.51386337266
                                    ],
                                    [
                                        -0.09315316845,
                                        51.51398104629
                                    ],
                                    [
                                        -0.09360152817,
                                        51.51404804668
                                    ],
                                    [
                                        -0.09359702208,
                                        51.51405120955
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "cycle",
                                "lineModeName": "Cycle",
                                "lines": [],
                                "primaryAreaName": "",
                                "branding": {
                                    "lineModeLogoUrl": "",
                                    "lineModeBackgroundColour": "",
                                    "lineModePrimaryColour": "",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": null
                            },
                            "stopPoints": []
                        }
                    }
                ]
            },
            {
                "beginJourneyAt": "2024-02-10T14:47:00",
                "endJourneyAt": "2024-02-10T16:17:00",
                "totalDuration": 90,
                "journeyLegs": [
                    {
                        "beginLegAt": "2024-02-10T14:47:00",
                        "endLegAt": "2024-02-10T16:17:00",
                        "legDuration": 90,
                        "startAtName": "1 Bow Interchange",
                        "endAtName": "108 Cheapside",
                        "startAtStop": null,
                        "endAtStop": null,
                        "legDetails": {
                            "summary": "Walk to 108 Cheapside",
                            "detailedSummary": "Walk to 108 Cheapside",
                            "legSteps": [
                                {
                                    "summary": "Continue along  Bow Interchange for 131 metres",
                                    "direction": "SouthEast",
                                    "latitude": 51.53070892192,
                                    "longitude": -0.0167900853,
                                    "distanceOfStep": 131
                                },
                                {
                                    "summary": "Turn right on to Payne Road, continue for 91 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.530079322,
                                    "longitude": -0.01518826001,
                                    "distanceOfStep": 91
                                },
                                {
                                    "summary": "Turn right on to Bow Interchange, continue for 42 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.52932184794,
                                    "longitude": -0.01559605695,
                                    "distanceOfStep": 42
                                },
                                {
                                    "summary": "Continue along  on to Bow Road, continue for 871 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.529141914549996,
                                    "longitude": -0.016122903969999998,
                                    "distanceOfStep": 871
                                },
                                {
                                    "summary": "Continue along  on to Mile End Road, continue for 2130 metres",
                                    "direction": "West",
                                    "latitude": 51.52658069969,
                                    "longitude": -0.027954833119999998,
                                    "distanceOfStep": 2130
                                },
                                {
                                    "summary": "Continue along  on to Whitechapel Road, continue for 1020 metres",
                                    "direction": "West",
                                    "latitude": 51.51981618097,
                                    "longitude": -0.05638377594,
                                    "distanceOfStep": 1020
                                },
                                {
                                    "summary": "Continue along  on to Whitechapel High Street, continue for 348 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.516078672629995,
                                    "longitude": -0.06965878551,
                                    "distanceOfStep": 348
                                },
                                {
                                    "summary": "Continue along  on to Aldgate High Street, continue for 297 metres",
                                    "direction": "SouthWest",
                                    "latitude": 51.514475880170004,
                                    "longitude": -0.07390618743,
                                    "distanceOfStep": 297
                                },
                                {
                                    "summary": "Continue along  on to Leadenhall Street, continue for 447 metres",
                                    "direction": "West",
                                    "latitude": 51.5132612504,
                                    "longitude": -0.07770458513,
                                    "distanceOfStep": 447
                                },
                                {
                                    "summary": "Continue along  on to Cornhill, continue for 337 metres",
                                    "direction": "West",
                                    "latitude": 51.51339307757,
                                    "longitude": -0.08411246157,
                                    "distanceOfStep": 337
                                },
                                {
                                    "summary": "Continue along  on to Mansion House Street, continue for 35 metres",
                                    "direction": "West",
                                    "latitude": 51.51337341077,
                                    "longitude": -0.08897019033,
                                    "distanceOfStep": 35
                                },
                                {
                                    "summary": "Continue along  on to Poultry, continue for 122 metres",
                                    "direction": "West",
                                    "latitude": 51.513390609540004,
                                    "longitude": -0.08947389672999999,
                                    "distanceOfStep": 122
                                },
                                {
                                    "summary": "Continue along  on to Cheapside, continue for 172 metres",
                                    "direction": "West",
                                    "latitude": 51.513634424450004,
                                    "longitude": -0.09119316552,
                                    "distanceOfStep": 172
                                }
                            ],
                            "lineString": {
                                "type": "LineString",
                                "coordinates": [
                                    [
                                        -0.01679047585,
                                        51.5306999359
                                    ],
                                    [
                                        -0.01679319024,
                                        51.53070453487
                                    ],
                                    [
                                        -0.01606821247,
                                        51.53042736471
                                    ],
                                    [
                                        -0.01606703874,
                                        51.53042691597
                                    ],
                                    [
                                        -0.01518826001,
                                        51.530079322
                                    ],
                                    [
                                        -0.01563341595,
                                        51.52945736945
                                    ],
                                    [
                                        -0.01559605695,
                                        51.52932184794
                                    ],
                                    [
                                        -0.01612290397,
                                        51.52914191455
                                    ],
                                    [
                                        -0.01755545128,
                                        51.52868952544
                                    ],
                                    [
                                        -0.01808345421,
                                        51.52848262495
                                    ],
                                    [
                                        -0.01824426719,
                                        51.52843138626
                                    ],
                                    [
                                        -0.01894280081,
                                        51.52828131876
                                    ],
                                    [
                                        -0.01917486427,
                                        51.52824926741
                                    ],
                                    [
                                        -0.01990220498,
                                        51.5280996807
                                    ],
                                    [
                                        -0.02097568354,
                                        51.52794693743
                                    ],
                                    [
                                        -0.02129496137,
                                        51.5278983681
                                    ],
                                    [
                                        -0.02142539775,
                                        51.52788258315
                                    ],
                                    [
                                        -0.02164344077,
                                        51.5278412978
                                    ],
                                    [
                                        -0.02251483027,
                                        51.52769412445
                                    ],
                                    [
                                        -0.02312534462,
                                        51.52757851873
                                    ],
                                    [
                                        -0.02431638482,
                                        51.52737377055
                                    ],
                                    [
                                        -0.02527652727,
                                        51.52717411591
                                    ],
                                    [
                                        -0.02548015745,
                                        51.52713258082
                                    ],
                                    [
                                        -0.02578618512,
                                        51.5270567984
                                    ],
                                    [
                                        -0.02729957199,
                                        51.52673154836
                                    ],
                                    [
                                        -0.02795483312,
                                        51.52658069969
                                    ],
                                    [
                                        -0.0288117734,
                                        51.52643323684
                                    ],
                                    [
                                        -0.02916139691,
                                        51.52634918567
                                    ],
                                    [
                                        -0.02983066463,
                                        51.52620755454
                                    ],
                                    [
                                        -0.03004985603,
                                        51.52613929508
                                    ],
                                    [
                                        -0.03058830223,
                                        51.5260224403
                                    ],
                                    [
                                        -0.03140394456,
                                        51.52582930211
                                    ],
                                    [
                                        -0.03202726844,
                                        51.52574983574
                                    ],
                                    [
                                        -0.03307532786,
                                        51.52551562217
                                    ],
                                    [
                                        -0.03352693808,
                                        51.52540629039
                                    ],
                                    [
                                        -0.03416814184,
                                        51.52524617891
                                    ],
                                    [
                                        -0.03454694494,
                                        51.52515360821
                                    ],
                                    [
                                        -0.03479532251,
                                        51.52507683638
                                    ],
                                    [
                                        -0.03492652033,
                                        51.525043064
                                    ],
                                    [
                                        -0.03564438287,
                                        51.52477631739
                                    ],
                                    [
                                        -0.0357771261,
                                        51.52470659949
                                    ],
                                    [
                                        -0.036084281,
                                        51.52460383139
                                    ],
                                    [
                                        -0.0368465056,
                                        51.52431084242
                                    ],
                                    [
                                        -0.03699287804,
                                        51.5242593365
                                    ],
                                    [
                                        -0.03715442837,
                                        51.52419009917
                                    ],
                                    [
                                        -0.03737437221,
                                        51.52410385348
                                    ],
                                    [
                                        -0.03749193284,
                                        51.52405186484
                                    ],
                                    [
                                        -0.03852347322,
                                        51.52352956292
                                    ],
                                    [
                                        -0.04004668843,
                                        51.52297050588
                                    ],
                                    [
                                        -0.04103972443,
                                        51.52267235391
                                    ],
                                    [
                                        -0.04186928357,
                                        51.52248836848
                                    ],
                                    [
                                        -0.04201448822,
                                        51.52246381468
                                    ],
                                    [
                                        -0.04327656815,
                                        51.52227804612
                                    ],
                                    [
                                        -0.04434714179,
                                        51.5221879898
                                    ],
                                    [
                                        -0.04565395832,
                                        51.52196697121
                                    ],
                                    [
                                        -0.0462211263,
                                        51.52185052367
                                    ],
                                    [
                                        -0.0469190866,
                                        51.52170927354
                                    ],
                                    [
                                        -0.04763144726,
                                        51.52156825898
                                    ],
                                    [
                                        -0.0490125581,
                                        51.52129448416
                                    ],
                                    [
                                        -0.04953649611,
                                        51.52117730158
                                    ],
                                    [
                                        -0.04979846414,
                                        51.5211187094
                                    ],
                                    [
                                        -0.05004564319,
                                        51.52106886338
                                    ],
                                    [
                                        -0.05090356352,
                                        51.52089427847
                                    ],
                                    [
                                        -0.05168907215,
                                        51.52072747711
                                    ],
                                    [
                                        -0.05219782589,
                                        51.52062801568
                                    ],
                                    [
                                        -0.05314253901,
                                        51.52044586317
                                    ],
                                    [
                                        -0.0534765197,
                                        51.52038845811
                                    ],
                                    [
                                        -0.05408686172,
                                        51.52027268921
                                    ],
                                    [
                                        -0.05504634736,
                                        51.52008177393
                                    ],
                                    [
                                        -0.05580187113,
                                        51.51994142573
                                    ],
                                    [
                                        -0.05638377594,
                                        51.51981618097
                                    ],
                                    [
                                        -0.05655739037,
                                        51.51980107261
                                    ],
                                    [
                                        -0.0568769582,
                                        51.51974341909
                                    ],
                                    [
                                        -0.05763285337,
                                        51.51959407271
                                    ],
                                    [
                                        -0.0579239927,
                                        51.51952695297
                                    ],
                                    [
                                        -0.05806917978,
                                        51.51950237909
                                    ],
                                    [
                                        -0.05921855923,
                                        51.51925162553
                                    ],
                                    [
                                        -0.0595532879,
                                        51.51917623043
                                    ],
                                    [
                                        -0.0607606485,
                                        51.51891742848
                                    ],
                                    [
                                        -0.06113896544,
                                        51.51883375696
                                    ],
                                    [
                                        -0.06148809182,
                                        51.51875859436
                                    ],
                                    [
                                        -0.06166284536,
                                        51.51871651953
                                    ],
                                    [
                                        -0.06275533382,
                                        51.51844680612
                                    ],
                                    [
                                        -0.06294410747,
                                        51.51841395355
                                    ],
                                    [
                                        -0.06400663087,
                                        51.51817071144
                                    ],
                                    [
                                        -0.0650858319,
                                        51.51787377936
                                    ],
                                    [
                                        -0.06568399319,
                                        51.51770379394
                                    ],
                                    [
                                        -0.06672186496,
                                        51.51736120237
                                    ],
                                    [
                                        -0.06701449908,
                                        51.51725811448
                                    ],
                                    [
                                        -0.06723397381,
                                        51.51718079807
                                    ],
                                    [
                                        -0.06798223587,
                                        51.51686939302
                                    ],
                                    [
                                        -0.06834992189,
                                        51.5166955974
                                    ],
                                    [
                                        -0.06945258325,
                                        51.51618318976
                                    ],
                                    [
                                        -0.0695117154,
                                        51.51614819271
                                    ],
                                    [
                                        -0.0695556845,
                                        51.51613093124
                                    ],
                                    [
                                        -0.06965878551,
                                        51.51607867263
                                    ],
                                    [
                                        -0.07020423244,
                                        51.51579089314
                                    ],
                                    [
                                        -0.07045439954,
                                        51.51566911284
                                    ],
                                    [
                                        -0.07067234199,
                                        51.51562773519
                                    ],
                                    [
                                        -0.07096457656,
                                        51.51553362355
                                    ],
                                    [
                                        -0.07150621322,
                                        51.51533570124
                                    ],
                                    [
                                        -0.07178366194,
                                        51.51525033704
                                    ],
                                    [
                                        -0.07207399463,
                                        51.5152011543
                                    ],
                                    [
                                        -0.07261486395,
                                        51.51502119947
                                    ],
                                    [
                                        -0.07271909694,
                                        51.51494197905
                                    ],
                                    [
                                        -0.07343734267,
                                        51.51465702402
                                    ],
                                    [
                                        -0.07364201249,
                                        51.51458844512
                                    ],
                                    [
                                        -0.07380309485,
                                        51.51452814261
                                    ],
                                    [
                                        -0.07390618743,
                                        51.51447588017
                                    ],
                                    [
                                        -0.07409607415,
                                        51.51441605029
                                    ],
                                    [
                                        -0.07460698456,
                                        51.51426257215
                                    ],
                                    [
                                        -0.07482681116,
                                        51.51417625485
                                    ],
                                    [
                                        -0.07516337192,
                                        51.51405588266
                                    ],
                                    [
                                        -0.07560226278,
                                        51.51390121824
                                    ],
                                    [
                                        -0.0758217071,
                                        51.5138238854
                                    ],
                                    [
                                        -0.07595322187,
                                        51.51378108005
                                    ],
                                    [
                                        -0.07608511504,
                                        51.51372928817
                                    ],
                                    [
                                        -0.07653764491,
                                        51.51359282917
                                    ],
                                    [
                                        -0.07677148849,
                                        51.51351573071
                                    ],
                                    [
                                        -0.07751697793,
                                        51.51326716796
                                    ],
                                    [
                                        -0.07770458513,
                                        51.5132612504
                                    ],
                                    [
                                        -0.07931612309,
                                        51.51332362264
                                    ],
                                    [
                                        -0.07950297445,
                                        51.51333567498
                                    ],
                                    [
                                        -0.07980428824,
                                        51.51336758621
                                    ],
                                    [
                                        -0.08039213705,
                                        51.51344015703
                                    ],
                                    [
                                        -0.08145488714,
                                        51.51352948682
                                    ],
                                    [
                                        -0.08168683469,
                                        51.51349731046
                                    ],
                                    [
                                        -0.08281210348,
                                        51.513470747
                                    ],
                                    [
                                        -0.08336203258,
                                        51.51341678702
                                    ],
                                    [
                                        -0.08411246157,
                                        51.51339307757
                                    ],
                                    [
                                        -0.0845009472,
                                        51.5134084155
                                    ],
                                    [
                                        -0.08480377297,
                                        51.51340436826
                                    ],
                                    [
                                        -0.08513578022,
                                        51.51339180411
                                    ],
                                    [
                                        -0.08562621288,
                                        51.51338182499
                                    ],
                                    [
                                        -0.0859006105,
                                        51.51336831834
                                    ],
                                    [
                                        -0.08604463375,
                                        51.5133706687
                                    ],
                                    [
                                        -0.08616022901,
                                        51.51336356245
                                    ],
                                    [
                                        -0.08641984747,
                                        51.51335880598
                                    ],
                                    [
                                        -0.08647745678,
                                        51.5133597459
                                    ],
                                    [
                                        -0.08695423961,
                                        51.51333155339
                                    ],
                                    [
                                        -0.08745869735,
                                        51.51333078795
                                    ],
                                    [
                                        -0.08799195979,
                                        51.51333048991
                                    ],
                                    [
                                        -0.08897019033,
                                        51.51337341077
                                    ],
                                    [
                                        -0.08907138287,
                                        51.51336606697
                                    ],
                                    [
                                        -0.08947389673,
                                        51.51339060954
                                    ],
                                    [
                                        -0.0897896209,
                                        51.51342272979
                                    ],
                                    [
                                        -0.09066328108,
                                        51.51355385899
                                    ],
                                    [
                                        -0.09077774897,
                                        51.51357370752
                                    ],
                                    [
                                        -0.09119316552,
                                        51.51363442445
                                    ],
                                    [
                                        -0.09156575137,
                                        51.51368545042
                                    ],
                                    [
                                        -0.09209488806,
                                        51.51378398474
                                    ],
                                    [
                                        -0.09232382641,
                                        51.51382367892
                                    ],
                                    [
                                        -0.09255276518,
                                        51.51386337266
                                    ],
                                    [
                                        -0.09315316845,
                                        51.51398104629
                                    ],
                                    [
                                        -0.09360152817,
                                        51.51404804668
                                    ],
                                    [
                                        -0.09359702208,
                                        51.51405120955
                                    ]
                                ]
                            },
                            "lineMode": {
                                "lineModeId": "walking",
                                "lineModeName": "Walk",
                                "lines": [],
                                "primaryAreaName": "",
                                "branding": {
                                    "lineModeLogoUrl": "",
                                    "lineModeBackgroundColour": "",
                                    "lineModePrimaryColour": "",
                                    "lineModeSecondaryColour": null
                                },
                                "flags": null
                            },
                            "stopPoints": []
                        }
                    }
                ]
            }
        ]
    }
    """
    
}
#endif
