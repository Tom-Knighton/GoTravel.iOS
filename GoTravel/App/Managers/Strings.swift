//
//  Strings.swift
//  GoTravel
//
//  Created by Tom Knighton on 07/10/2023.
//

import SwiftUI
import GoTravel_Models

public struct Strings {
    
    public struct Navigation {
        public static let MapTab: LocalizedStringKey = "Navigation:MapTab"
        public static let JourneyTab: LocalizedStringKey = "Navigation:JourneyTab"
        public static let CommunityTab: LocalizedStringKey = "Navigation:CommunityTab"
    }
    
    public struct Map {
        public static let LocationDisabled: LocalizedStringKey = "Map:LocationDisabled"
        public static let EnableLocationStopPoints: LocalizedStringKey = "Map:StopPointsEnableLocation"
        public static let HintSearchHere: LocalizedStringKey = "Map:Hint:SearchHere"
        public static let HintSearchHereText: LocalizedStringKey = "Map:Hint:SearchHereText"
        
        public static let LineModeFilterTitle: LocalizedStringKey = "Map:LineModeFilters:Title"
        public static let LineModeFilterSubtitle: LocalizedStringKey = "Map:LineModeFilters:Subtitle"
        public static let LineModeFilterNearby: LocalizedStringKey = "Map:LineModeFilters:Nearby"
        public static let LineModeFilterOthers: LocalizedStringKey = "Map:LineModeFilters:Others"
        
        public static let SearchSheetSearch: LocalizedStringKey = "Map:SearchSheet:Search"
        public static let SearchSheetNearby: LocalizedStringKey = "Map:SearchSheet:Nearby"
        
        public static func BusStopIndication(_ indication: String) -> LocalizedStringKey {
            LocalizedStringKey("Map:SearchSheet:BusStopIndication:\(indication)")
        }
        
        public static func Distance(_ distance: String, measurement: String = "miles") -> LocalizedStringKey {
            LocalizedStringKey("Map:Distance:\(distance):\(measurement)")
        }
    }
    
    public struct StopPage {
        public static let GetDirectionsButton: LocalizedStringKey = "StopPage:GetDirectionsButton"
        public static let Platform: LocalizedStringKey = "StopPage:Platform"
        public static let Due: LocalizedStringKey = "StopPage:Arrivals:Due"
        public static let Mins: LocalizedStringKey = "StopPage:Arrivals:Mins"
        
        public static let LiveTimes: LocalizedStringKey = "StopPage:Arrivals:LiveTimes"
        public static let CheckBoards: LocalizedStringKey = "StopPage:Arrivals:CheckBoards"
        public static let Towards: LocalizedStringKey = "StopPage:Arrivals:Towards"
        
        public static let Information: LocalizedStringResource = "StopPage:Information"
        public static let WiFi: LocalizedStringKey = "StopPage:Information:WiFi"
        public static let Accessible: LocalizedStringKey = "StopPage:Information:Accessible"
        public static let Address: LocalizedStringKey = "StopPage:Information:Address"
        public static let Toilets: LocalizedStringKey = "StopPage:Information:Toilets"
        public static let Free: LocalizedStringKey = "StopPage:Information:Free"
        public static let StopToiletInfoAlertTitle: LocalizedStringKey = "StopPage:Toilet:AlertTitle"
        
        public struct Accessibility {
            public static let InfoLabel: LocalizedStringKey = "StopPage:Accessibility:InfoLabel"
            
            public static let HasWifiLabel: LocalizedStringKey = "StopPage:Accessibility:HasWifiLabel"
            public static let NoWifiLabel: LocalizedStringKey = "StopPage:Accessibility:NoWifiLabel"
            public static let ViaLiftLabel: LocalizedStringKey = "StopPage:Accessibility:ViaLiftLabel"
            public static let NoViaLiftLabel: LocalizedStringKey = "StopPage:Accessibility:NoViaLiftLabel"
            
        }

    }
    
    public struct JourneyPage {
        
        public static let Title: LocalizedStringKey = "JourneyPage:Title"
        public static let PlanATrip: LocalizedStringKey = "JourneyPage:PlanATrip"
        
        public static let FromPrompt: LocalizedStringKey = "JourneyPage:FromPrompt"
        public static let ToPrompt: LocalizedStringKey = "JourneyPage:ToPrompt"
        public static let ViaPrompt: LocalizedStringKey = "JourneyPage:ViaPrompt"
        
        public static let PlanJourneyButton: LocalizedStringKey = "JourneyPage:PlanButton"
        
        public static let ChooseStart: LocalizedStringKey = "JourneyPage:Search:ChooseStart"
        public static let ChooseEnd: LocalizedStringKey = "JourneyPage:Search:ChooseEnd"
        public static let ChooseVia: LocalizedStringKey = "JourneyPage:Search:ChooseVia"
        
        public static let Searching: LocalizedStringKey = "JourneyPage:Searching"
        public static let SearchNoResultsTitle: LocalizedStringKey = "JourneyPage:Search:NoResultsTitle"
        public static let SearchNoResultsDescription: LocalizedStringKey = "JourneyPage:Search:NoResultsDescription"
        
        public static let SearchBeginTitle: LocalizedStringKey = "JourneyPage:Search:BeginJourneyTitle"
        public static let SearchBeginDescription: LocalizedStringKey = "JourneyPage:Search:BeginJourneyDescription"
        public static let SearchEndTitle: LocalizedStringKey = "JourneyPage:Search:EndJourneyTitle"
        public static let SearchEndDescription: LocalizedStringKey = "JourneyPage:Search:EndJourneyDescription"
        public static let SearchViaTitle: LocalizedStringKey = "JourneyPage:Search:ViaJourneyTitle"
        public static let SearchViaDescription: LocalizedStringKey = "JourneyPage:Search:ViaJourneyDescription"
        
        public static let ReplacementBus: LocalizedStringKey = "JourneyPage:ReplacementBus"
        
        public static let FastestJourney: LocalizedStringKey = "JourneyPage:FastestJourney"
        public static let Journey: LocalizedStringKey = "JourneyPage:Journey"
        public static let Cycle: LocalizedStringKey = "JourneyPage:Cycle"
        public static let WalkIfCan: LocalizedStringKey = "JourneyPage:WalkIfCan"
        public static let Walk: LocalizedStringKey = "JourneyPage:Walk"
        
        public static let Now: LocalizedStringKey = "JourneyPage:Now"
        public static let Tomorrow: LocalizedStringKey = "JourneyPage:Tomorrow"
        
        public static let Destination: LocalizedStringKey = "JourneyPage:Destination"
        
        public static func Stops(_ num: Int) -> LocalizedStringKey  {
            LocalizedStringKey("JourneyPage:Stops:\(num)")
        }
        
        public static let ArriveBy: LocalizedStringKey = "JourneyPage:ArriveBy"
        public static func ArriveBy(_ value: String) -> LocalizedStringKey {
            LocalizedStringKey("JourneyPage:ArriveBy:\(value)")
        }
        
        public static let LeaveAt: LocalizedStringKey = "JourneyPage:LeaveAt"
        public static func LeaveAt(_ value: String) -> LocalizedStringKey {
            LocalizedStringKey("JourneyPage:LeaveAt:\(value)")
        }
        
        public static let MyLocation: LocalizedStringKey = "JourneyPage:MyLocation"
        
        public static func Mins(_ mins: Int) -> LocalizedStringKey {
            LocalizedStringKey("JourneyPage:Mins:\(mins)")
        }
        
        public static let LeaveNow: LocalizedStringKey = "JourneyPage:LeaveNow"
        public static func LeaveWithin(_ mins: Int) ->  LocalizedStringKey {
            LocalizedStringKey("JourneyPage:LeaveWithin:\(mins)")
        }
        
        public static let JourneyOptions: LocalizedStringKey = "JourneyPage:Options"
        public static let JourneyPreferencesHead: LocalizedStringKey = "JourneyPage:PreferencesHead"
        public static let JourneyAccessHead: LocalizedStringKey = "JourneyPage:AccessHead"
        public static let StepFreePlatform: LocalizedStringKey = "JourneyPage:StepFreePlatform"
        public static let StepFreeVehicle: LocalizedStringKey = "JourneyPage:StepFreeVehicle"
        public static let FastJourneys: LocalizedStringKey = "JourneyPage:FastJourney"
        public static let FewChanges: LocalizedStringKey = "JourneyPage:FewChanges"
        public static let LeastWalk: LocalizedStringKey = "JourneyPage:LeastWalk"
        
        public static let OptionsNoAccessibilityDescription: LocalizedStringKey = "JourneyPage:Options:NoAccessibilityDesc"
        public static let OptionsPlatformAccessibilityDescription: LocalizedStringKey = "JourneyPage:Options:PlatformAccessibilityDesc"
        public static let OptionsVehicleAccessibilityDescription: LocalizedStringKey = "JourneyPage:Options:VehicleAccessibilityDesc"
        public static let OptionsFastestDescription: LocalizedStringKey = "JourneyPage:Options:FastestDesc"
        public static let OptionsFewChangesDescription: LocalizedStringKey = "JourneyPage:Options:FewChangesDesc"
        public static let OptionsFewWalkingDescription: LocalizedStringKey = "JourneyPage:Options:FewWalkDesc"
        
        public static let ViewRoute: LocalizedStringKey = "JourneyPage:ViewRoute"
        
        public struct Accessibility {
            
            public static let EmptyFromLabel: LocalizedStringKey = "Journey:Accessibility:EmptyFromLabel"
            public static let FromHint: LocalizedStringKey = "Journey:Accessibility:FromHint"
            public static let EmptyToLabel: LocalizedStringKey = "Journey:Accessibility:EmptyToLabel"
            public static let ToHint: LocalizedStringKey = "Journey:Accessibility:ToHint"
            public static let EmptyViaLabel: LocalizedStringKey = "Journey:Accessibility:EmptyViaLabel"
            public static let ViaHint: LocalizedStringKey = "Journey:Accessibility:ViaHint"
            
            public static func ToLabel(_ value: String) -> LocalizedStringKey {
                .init("Journey:Accessibility:ToLabel:\(value)")
            }
            public static func FromLabel(_ value: String) -> LocalizedStringKey {
                .init("Journey:Accessibility:FromLabel:\(value)")
            }
            public static func ViaLabel(_ value: String) -> LocalizedStringKey {
                .init("Journey:Accessibility:ViaLabel:\(value)")
            }
            
            public static let PlanTripHint: LocalizedStringKey = "Journey:Accessibility:PlanTripHint"
            
            public static let SwapLabel: LocalizedStringKey = "Journey:Accessibility:SwapLabel"
            public static let SwapHint: LocalizedStringKey = "Journey:Accessibility:SwapHint"
            public static let ShowViaLabel: LocalizedStringKey = "Journey:Accessibility:ShowViaLabel"
            public static let ShowViaHint: LocalizedStringKey = "Journey:Accessibility:ShowViaHint"
            public static let HideViaLabel: LocalizedStringKey = "Journey:Accessibility:HideViaLabel"
            public static let HideViaHint: LocalizedStringKey = "Journey:Accessibility:HideViaHint"
            
            public static let TimeHint: LocalizedStringKey = "Journey:Accessibility:TimeHint"
            public static let PlanHint: LocalizedStringKey = "Journey:Accessibility:PlanHint"
            
            public static let ViewRouteLabel: LocalizedStringKey = "Journey:Accessibility:ViewRouteLabel"
            
            public static let LocationsUpdatedMsg: LocalizedStringKey = "Journey:Accessibility:LocationsUpdatesMsg"
            
            public static func JourneyOptionLabel(_ option: Int) -> LocalizedStringKey {
                LocalizedStringKey("Journey:Accessibility:JourneyOptionLabel:\(option)")
            }
            
            public static func JourneyModesLabel(_ modes: String) -> LocalizedStringKey {
                LocalizedStringKey("Journey:Accessibility:JourneyModesLabel:\(modes)")
            }
            
            public static func LegWalkInstruction(_ time: String, destination: String, duration: Int) -> LocalizedStringKey {
                LocalizedStringKey("Journey:Accessibility:WalkInstructionLabel:\(time):\(destination):\(duration)")
            }
            
            public static func LegModeInstruction(_ time: String, mode: String, line: String, destination: String, duration: Int) -> LocalizedStringKey {
                LocalizedStringKey("Journey:Accessibility:ModeInstructionLabel:\(time):\(mode):\(line):\(destination):\(duration)")
            }
        }
    }
    
    public struct Auth {
        public static let Login: LocalizedStringKey = "Auth:Login"
        public static let SignUp: LocalizedStringKey = "Auth:SignUp"
        
        public static let UsernameOrEmail: LocalizedStringKey = "Auth:UsernameOrEmail"
        public static let Password: LocalizedStringKey = "Auth:Password"
        
        public static let SignUpCTA: LocalizedStringKey = "Auth:SignUp:CTA"
        public static let LoginCTA: LocalizedStringKey = "Auth:Login:CTA"
        
        public static let FewDetails: LocalizedStringKey = "Auth:SignUp:JustAFewDetails"
        public static let ChooseUsername: LocalizedStringKey = "Auth:SignUp:ChooseUsername"
        public static let ChooseEmail: LocalizedStringKey = "Auth:SignUp:ChooseEmail"
        public static let ChoosePassword: LocalizedStringKey = "Auth:SignUp:ChoosePassword"
        public static let ChooseConfPassword: LocalizedStringKey = "Auth:SignUp:ChooseConfPassword"
        
        public static let PostSignupThanks: LocalizedStringKey = "Auth:PostSignupThanks"
        
        public static let ChangeProfileImage: LocalizedStringKey = "Auth:ChangeProfileImage"
        
        public static let YourUsername: LocalizedStringKey = "Auth:YourUsername"
        public static let Username: LocalizedStringKey = "Auth:Username"
        
        public struct Accessibility {
            public static let MessageLoginPresented = "Auth:A11Y:MessageLoginPresented"
            public static let MessageSignupPresented = "Auth:A11Y:MessageSignupPresented"
            
            public static func errors(_ errors: String) -> LocalizedStringKey {
                LocalizedStringKey("Auth:A11Y:ErrorsOnForm:\(errors)")
            }
        }
    }
    
    
    public struct Community {
        public struct Join {
            public static let JoinTag: LocalizedStringKey = "Community:JoinTag"
            public static let JoinDescription: LocalizedStringKey = "Community:JoinDescription"
            
            public static let Compete: LocalizedStringKey = "Community:Compete"
            public static let CompeteDesc: LocalizedStringKey = "Community:CompeteDesc"
            public static let Track: LocalizedStringKey = "Community:Track"
            public static let TrackDesc: LocalizedStringKey = "Community:TrackDesc"
            public static let Special: LocalizedStringKey = "Community:Special"
            public static let SpecialDesc: LocalizedStringKey = "Community:SpecialDesc"
            public static let Crowdsource: LocalizedStringKey = "Community:Crowdsource"
            public static let CrowdsourceDesc: LocalizedStringKey = "Community:CrowdsourceDesc"
            
            public static let StartNow: LocalizedStringKey = "Community:StartNow"
            public static let You: LocalizedStringKey = "Community:You!"
        }
        
        public struct Updates {
            public static let Title: LocalizedStringKey = "Community:Updates:Title"
            public static func FollowingCount(_ count: Int) ->  LocalizedStringKey {
                LocalizedStringKey("Community:Updates:FollowingCount:\(count)")
            }
        }
        
        public struct Relationships {
            public static let Following: LocalizedStringKey = "Community:Rel:Following"
            public static let Followers: LocalizedStringKey = "Community:Rel:Followers"
            public static let Blocked: LocalizedStringKey = "Community:Rel:Blocked"
            public static let Friendships: LocalizedStringKey = "Community:Rel:Friendships"
            public static let AddFriend: LocalizedStringKey = "Community:Rel:AddFriend"
            public static let NoFollowers: LocalizedStringKey = "Community:Rel:NoFollowers"
            public static let NoFollowing: LocalizedStringKey = "Community:Rel:NoFollowing"
            public static let NoBlocked: LocalizedStringKey = "Community:Rel:NoBlocked"
            public static let NoFollowersDesc: LocalizedStringKey = "Community:Rel:NoFollowersDesc"
            public static let NoFollowingDesc: LocalizedStringKey = "Community:Rel:NoFollowingDesc"
            public static let NoBlockedDesc: LocalizedStringKey = "Community:Rel:NoBlockedDesc"
            public static let SearchUsers: LocalizedStringKey = "Community:Rel:SearchUsers"
            public static let SearchUsersDesc: LocalizedStringKey = "Community:Rel:SearchUsersDesc"
            public static let SearchUsersPrompt: LocalizedStringKey = "Community:Rel:SearchUsersPrompt"
            
            public static let Unfollow: LocalizedStringKey = "Community:Rel:Unfollow"
            public static let Unblock: LocalizedStringKey = "Community:Rel:Unblock"
            public static let Requested: LocalizedStringKey = "Community:Rel:Requested"
            public static let Remove: LocalizedStringKey = "Community:Rel:Remove"
            public static let Approve: LocalizedStringKey = "Community:Rel:Approve"
            public static let Reject: LocalizedStringKey = "Community:Rel:Reject"
            
        }
        
        public struct Info {
            public static let UsersReported: LocalizedStringKey = "Community:Info:UsersReportedTitle"
            public static let Blurb: LocalizedStringKey = "Community:Info:Blurb"
            public static let Closed: LocalizedStringKey = "Community:Info:Closed"
            public static let Delayed: LocalizedStringKey = "Community:Info:DelayedJourneys"
            
            public static let SignUpAndPost: LocalizedStringKey = "Community:Info:SignUpAndPost"
            public static let PostATip: LocalizedStringKey = "Community:Info:PostATip"
            
            public static let SubmitHeader: LocalizedStringKey = "Community:Info:SubmitHeader"
            public static let SubmitSubheader: LocalizedStringKey = "Community:Info:SubmitSubheader"
            public static let Status: LocalizedStringKey = "Community:Info:Status"
            public static let StatusDesc: LocalizedStringKey = "Community:Info:StatusDesc"
            public static let NoChange: LocalizedStringKey = "Community:Info:NoChange"
            public static let SomeMoreInfo: LocalizedStringKey = "Community:Info:SomeMore"
            
            public static let WhatsGoingOn: LocalizedStringKey = "Community:Info:WhatsGoingOn"
            public static let WhatsGoingOnDesc: LocalizedStringKey = "Community:Info:WhatsGoingOnDesc"
            
            public static let HowLong: LocalizedStringKey = "Community:Info:HowLong"
            public static let HowLongDesc: LocalizedStringKey = "Community:Info:HowLongDesc"
            
            public static let StartsAt: LocalizedStringKey = "Community:Info:StartsAt"
            public static let EndsAt: LocalizedStringKey = "Community:Info:EndsAt"
            
            public static let HoldUp: LocalizedStringKey = "Community:Info:HoldUp"
            public static let ConfirmBeforeSubmit: LocalizedStringKey = "Community:Info:ConfirmBeforeSubmit"
            
            public static let SuccessMsg: LocalizedStringKey = "Community:Info:Success"
            
            public static let ReportReason: LocalizedStringKey = "Community:Info:Reason"
            public static let ReportReceived: LocalizedStringKey = "Community:Info:ReportReceived"
            public static let ReportReceivedDesc: LocalizedStringKey = "Community:Info:ReportReceivedDesc"
            public static let ReportMisleading: LocalizedStringKey = "Community:Info:Report:Misleading"
            public static let ReportInnapropriate: LocalizedStringKey = "Community:Info:Report:Innapropriate"
            public static let ReportSpam: LocalizedStringKey = "Community:Info:Report:Spam"
            public static let ReportMean: LocalizedStringKey = "Community:Info:Report:Mean"
            public static let ReportIllegal: LocalizedStringKey = "Community:Info:Report:Illegal"
        }
        
        public struct Journey {
            public static let LineInfoMessage: LocalizedStringKey = "Community:Trip:SubmitLinesMessage"
            public static let TrimTrip: LocalizedStringKey = "Community:Trip:TrimTrip"
            public static let Started: LocalizedStringKey = "Community:Trip:Started:"
            public static let Ended: LocalizedStringKey = "Community:Trip:Ended:"
            public static let Distance: LocalizedStringKey = "Community:Trip:Distance"
            public static let Lines: LocalizedStringKey = "Community:Trip:Lines"
            public static let LinesEmpty: LocalizedStringKey = "Community:Trip:LinesEmpty"
            public static let AddLine: LocalizedStringKey = "Community:Trip:AddLine"
            public static let SearchLines: LocalizedStringKey = "Community:Trip:SearchLines"
            public static let Points: LocalizedStringKey = "Community:Trip:Points"
            public static let UnderReview: LocalizedStringKey = "Community:Trip:UnderReview"
            public static let UnderReviewPending: LocalizedStringKey = "Community:Trip:UnderReviewPending"
            public static let UnderReviewMessage: LocalizedStringKey = "Community:Trip:UnderReviewMessage"
            public static let StopTracking: LocalizedStringKey = "Community:Trip:StopTracking"
            public static let EndJourney: LocalizedStringKey = "Community:Trip:EndJourney"
            public static let TrackingJourney: LocalizedStringKey = "Community:Trip:TrackingJourney"
            public static let StartTracking: LocalizedStringKey = "Community:Trip:StartTracking"
            public static let StillTracking: LocalizedStringKey = "Community:Trip:StillTracking"
            
            public static let MyJourneys: LocalizedStringKey = "Community:Trip:MyJourneys"
            public static let UnsavedJourneys: LocalizedStringKey = "Community:Trip:UnsavedJourneys"
            public static let NoSaved: LocalizedStringKey = "Community:Trip:NoSaved"
            public static let NoSavedMsg: LocalizedStringKey = "Community:Trip:NoSavedMsg"
            public static let UnsavedInfo: LocalizedStringKey = "Community:Trip:UnsavedInfo"
            
            public static let SearchLinesDesc: LocalizedStringKey = "Comminity:Trip:SearchLinesDesc"
            public static let SearchLinesPrompt: LocalizedStringKey = "Comminity:Trip:SearchLinesPrompt"
            
            public static let UnsavedBtnHint: LocalizedStringKey = "Community:Trip:UnsavedJourneysBtnHint"
            public static func UnsavedBtnLabel(_ count: Int) -> LocalizedStringKey {
                LocalizedStringKey("Community:Trip:UnsavedJourneysBtn:\(count)")
            }
            
            public static func receivedPoints(_ points: Int) -> LocalizedStringKey {
                LocalizedStringKey("Community:Trip:ReceivedPoints:\(points)")
            }
        }
        
        public struct Accessibility {
            public static let StartNowHint: LocalizedStringKey = "Community:A11Y:StartNowHint"
            public static let ScoreboadLabel: LocalizedStringKey = "Community:A11Y:ScoreboardLabel"
            
            public static let ManageFollowersHint: LocalizedStringKey = "Community:A11Y:ManageFollowersHint"
            public static let ManageFollowingHint: LocalizedStringKey = "Community:A11Y:ManageFollowingHint"
            public static let ProfilePicLabel: LocalizedStringKey = "Community:A11Y:ProfilePicLabel"
            public static let ProfilePicHint: LocalizedStringKey = "Community:A11Y:ProfilePicHint"
            public static let AddFriendBtnHint: LocalizedStringKey = "Community:A11Y:AddFriendBtnHint"
            public static let UnblockHint: LocalizedStringKey = "Community:A11Y:UnblockHint"
            public static let ApproveHint: LocalizedStringKey = "Community:A11Y:ApproveHint"
            public static let RejectHint: LocalizedStringKey = "Community:A11Y:RejectHint"
            public static let UnfollowHint: LocalizedStringKey = "Community:A11Y:UnfollowHint"
            public static let RequestedHint: LocalizedStringKey = "Community:A11Y:RequestedHint"
            public static let RemoveHint: LocalizedStringKey = "Community:A11Y:RemoveHint"
            public static let RequestHint: LocalizedStringKey = "Community:A11Y:RequestedHint"
            
            public static let UserInfoLabel: LocalizedStringKey = "Community:A11Y:UserInfoLabel"
            public static let UserInfoHint: LocalizedStringKey = "Community:A11Y:UserInfoHint"
            public static let UserInfoSeeMoreHint: LocalizedStringKey = "Community:A11Y:UserInfoSeeMoreHint"
            public static let SubmitInfoHint: LocalizedStringKey = "Community:A11Y:SubmitInfoHint"
            public static let NoChangeHint: LocalizedStringKey = "Community:A11Y:NoChangeHint"
            public static let DelayedHint: LocalizedStringKey = "Community:A11Y:DelayedHint"
            public static let ClosedHint: LocalizedStringKey = "Community:A11Y:ClosedHint"
            public static let ReportSubmission: LocalizedStringKey = "Community:A11Y:ReportSubmission"
            public static let ReportSubmissionHint: LocalizedStringKey = "Community:A11Y:ReportSubmissionHint"
            public static let Downvote: LocalizedStringKey = "Community:A11Y:Downvote"
            
            public static let UnsavedJourneyHint: LocalizedStringKey = "Community:A11Y:UnsavedJourneyHint"
            
            public static func UnsavedJourney(_ name: String, startedAt: Date) -> LocalizedStringKey {
                LocalizedStringKey("Community:A11Y:UnsavedJourney:\(name):\(startedAt)")
            }
            
            public static func UpVotes(_ score: Int) -> LocalizedStringKey {
                LocalizedStringKey("Community:A11Y:Upvotes:\(score)")
            }
            public static func UpVotesHint(_ hasVoted: Bool) -> LocalizedStringKey {
                if hasVoted {
                    return LocalizedStringKey("Community:A11Y:HasUpVotedHint")
                }
                return LocalizedStringKey("Community:A11Y:HasNotUpVotedHint")
            }
            public static func DownVoteHint(_ hasVoted: Bool) -> LocalizedStringKey {
                if hasVoted {
                    return LocalizedStringKey("Community:A11Y:HasDownVotedHint")
                }
                return LocalizedStringKey("Community:A11Y:HasNotDownVotedHint")
            }
        }
        
        
    }
    
    public struct Misc {
        public static let Searching: LocalizedStringKey = "Misc:Searching..."
        public static let Loading: LocalizedStringKey = "Misc:Loading..."
        public static let And: LocalizedStringKey = "Misc:And"
        public static let OxfordComma: LocalizedStringKey = "Misc:OxfordComma"
        public static let ThenLower: LocalizedStringKey = "Misc:ThenLower"
        public static let Ok: LocalizedStringKey = "Misc:Ok"
        public static let Results: LocalizedStringKey = "Misc:Results"
        public static let TapToSeeMore: LocalizedStringKey = "Misc:TapSeeMore"
        public static let TapToExpand: LocalizedStringKey = "Misc:TapToExpand"
        public static let Or: LocalizedStringKey = "Misc:Or"
        public static let Error: LocalizedStringKey = "Misc:Error"
        public static let Woohoo: LocalizedStringKey = "Misc:Woohoo"
        public static let Continue: LocalizedStringKey = "Misc:Continue"
        public static let Filter: LocalizedStringKey = "Misc:Filter..."
        public static let NoResults: LocalizedStringKey = "Misc:NoResults"
        public static let NoResultsDesc: LocalizedStringKey = "Misc:NoResultsDesc"
        public static let Information: LocalizedStringKey = "Misc:Information"
        public static let Submit: LocalizedStringKey = "Misc:Submit"
        public static let Delete: LocalizedStringKey = "Misc:Delete"
        public static let Cancel: LocalizedStringKey = "Misc:Cancel"
        public static let Success: LocalizedStringKey = "Misc:Success"
        
        public static func Quote(_ content: String) -> LocalizedStringKey {
            LocalizedStringKey("Misc:Quote:\(content)")
        }
    }
    
    public struct Errors {
        public static let NoLineModesAPI: LocalizedStringKey = "Errors:NoLineModesFromAPI"
        public static let NoLineModesAPIDescription: LocalizedStringKey = "Errors:NoLineModesFromAPI:Description"
        public static let StopFailedLoad: LocalizedStringKey = "Errors:StopFailedLoading"
        public static let SomethingWrong: LocalizedStringKey = "Errors:SomethingWentWrong"
        
        public static let AuthInvalidDetails: LocalizedStringKey = "Errors:Auth:InvalidDetails"
        public static let AuthNotEmail: LocalizedStringKey = "Errors:Auth:NotEmail"
        public static let AuthPasswordLength: LocalizedStringKey = "Errors:Auth:PasswordLength"
        public static let AuthUsernameLength: LocalizedStringKey = "Errors:Auth:UsernameLength"
        public static let AuthPasswordMatch: LocalizedStringKey = "Errors:Auth:PasswordMatch"
        public static let AuthEmailValid: LocalizedStringKey = "Errors:Auth:EmailValid"
        public static let AuthEmailTaken: LocalizedStringKey = "Errors:Auth:EmailTaken"
        public static let AuthUsernameTaken: LocalizedStringKey = "Errors:Auth:UsernameTaken"
        public static let AuthTooManyAttempts: LocalizedStringKey = "Errors:Auth:TooManyAttempts"
        public static let AuthPasswordSecure: LocalizedStringKey = "Errors:Auth:PasswordSecure"
        
        public static let InfoSubNoChangeNoText: LocalizedStringKey = "Errors:Info:NoChangeNoText"
        public static let InfoSubTextTooLong: LocalizedStringKey = "Errors:Info:TextTooLong"
        public static let InfoSubTimeWrong: LocalizedStringKey = "Errors:Info:TimeWrong"
        public static let InfoSubError: LocalizedStringKey = "Errors:Info:Error"
    }
    
    public struct Assets {
        public static let BusLoading = "BusLoading"
    }
    
    public struct Accessibility {
        
        public static let MapLabelUserSearch: LocalizedStringKey = "Accessibility:Map:UserSearchLabel"
        public static let MapHintUserSearch: LocalizedStringKey = "Accessibility:Map:UserSearchHint"
        public static let MapLabelMapSearch: LocalizedStringKey = "Accessibility:Map:MapSearchLabel"
        public static let MapHintMapSearch: LocalizedStringKey = "Accessibility:Map:MapSearchHint"
        public static let MapLabelFilterSheet: LocalizedStringKey = "Accessibility:Map:FilterSheetLabel"
        public static let MapHintFilterSheet: LocalizedStringKey = "Accessibility:Map:FilterSheetHint"
        
        public static let MapShowsStopLabel: LocalizedStringKey = "Accessibility:StopPage:MapShowsStopLabel"
        public static let OpensJourneyForStopLabel: LocalizedStringKey = "Accessibility:StopPage:OpensJourneyForStopLabel"
        public static let StopArrivalsLabel: LocalizedStringKey = "Accessibility:StopPage:UpcomingArrivalsLabel"
        public static let StopArrivalsHint: LocalizedStringKey = "Accessibility:StopPage:UpcomingArrivalsHint"
        public static let StopArrivalsUpdatedMessage: LocalizedStringKey = "Accessibility:StopPage:ArrivalsUpdatedMessage"
        public static let StopNextArrivalIs: LocalizedStringKey = "Accessibility:StopPage:NextArrivalIs"
        public static let StopManualRefreshLabel: LocalizedStringKey = "Accessibility:StopPage:RefreshArrivalsLabel"
        
        public static func MapBikesRemaining(_ bikes: Int) -> LocalizedStringKey {
            return "Accessibility:Map:BikesRemainingText:\(bikes)"
        }
        
        public static func MapEBikesRemaining(_ bikes: Int) -> LocalizedStringKey {
            return "Accessibility:Map:EBikesRemainingText:\(bikes)"
        }
        
        public static func MapLineRoute(_ route: String) -> LocalizedStringKey {
            LocalizedStringKey("Accessibility:Map:LineRoute:\(route)")
        }
        
        public static func MapFilterEnables(_ lineMode: String) -> LocalizedStringKey {
            LocalizedStringKey("Accessibility:Map:FilterReEnables:\(lineMode)")
        }
        
        public static func MapFilterHides(_ lineMode: String) -> LocalizedStringKey {
            LocalizedStringKey("Accessibility:Map:FilterHides:\(lineMode)")
        }
        
        public static func FilterSheetAreaLabel(_ area: String) -> LocalizedStringKey {
            LocalizedStringKey("Accessibility:Map:FilterLineModesForArea:\(area)")
        }
        
        public static func LineArrivalsLabel(_ lineName: String) -> LocalizedStringKey {
            LocalizedStringKey("Accessibility:StopPage:LineArrivals:\(lineName)")
        }
        
        public static func ToiletInfoRowLabel(_ info: StopPointToiletInfo) -> LocalizedStringKey {
            let type = info.type
            let accessibleString = info.accessible ? "are disability-friendly" : "are not disability-friendly"
            let babyString = info.hasBabyGate ? "does" : "does not"
            let freeString = info.free ? "are free to enter" : "are not free to enter"
            return LocalizedStringKey("Accessibility:StopPage:ToiletLabel:\(type):\(freeString):\(accessibleString):\(babyString)")
        }
    }
}

public struct Icons {
    public static let gear: String = "gear"
    public static let arrow_right: String = "arrow.right"
    public static let arrow_up: String = "arrow.up"
    public static let arrow_down: String = "arrow.down"
    public static let arrowUpAndDown: String = "arrow.up.arrow.down"
    public static let arrow_clockwise: String = "arrow.clockwise"
    public static let arrowExpandCircleFill = "arrow.up.left.and.arrow.down.right.circle.fill"
    public static let arrowRightCircle = "arrow.triangle.turn.up.right.circle.fill"
    public static let location_slash = "location.slash"
    public static let locationFill = "location.fill"
    public static let cross_circle_fill = "xmark.circle.fill"
    public static let circleInCircle = "circle.circle"
    public static let circleInCircleFilled = "circle.circle.fill"
    public static let cross = "xmark"
    public static let check = "checkmark"
    public static let accessible = "figure.roll"
    public static let family = "figure.and.child.holdinghands"
    public static let map = "map"
    public static let map_circle = "map.circle.fill"
    public static let mapPinSlashed = "mappin.slash"
    public static let bike = "bicycle"
    public static let bike_circle = "bicycle.circle"
    public static let bike_circle_fill = "bicycle.circle.fill"
    public static let train = "tram"
    public static let bus = "bus"
    public static let location = "location"
    public static let location_magnifyingglass = "location.magnifyingglass"
    public static let filter = "line.3.horizontal.decrease.circle"
    public static let info = "info"
    public static let infoCircle = "info.circle"
    public static let add = "plus"
    public static let addCircle = "plus.circle"
    public static let minus = "minus"
    public static let minusCircle = "minus.circle"
    public static let clockFilled = "clock.fill"
    public static let walk = "figure.walk"
    public static let signPostFilled = "signpost.right.and.left.fill"
    public static let personOnBustFilled = "person.bust.fill"
    public static let threePeopleFilled = "person.3.fill"
    public static let threePeopleSeq = "person.3.sequence"
    public static let magnifyingGlass = "magnifyingglass"
    public static let exclamationMarkTriangle = "exclamationmark.triangle"
    public static let exclamationMarkStopFill = "exclamationmark.octagon.fill"
    public static let flag = "flag"
    public static let arrowUpCircle = "arrow.up.circle"
    public static let arrowDownCircle = "arrow.down.circle"
    public static let checkCircleFill = "checkmark.circle.fill"
    public static let circleFill = "circle.fill"
    public static let chevronRight = "chevron.right"
}
