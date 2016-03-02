//
//  GSCoreLogging.h
//  GSShared
//
//  Created by Trent Fitzgibbon on 29/10/2015.
//  Copyright © 2015 GRIDSTONE. All rights reserved.
//

#if __has_include("CocoaLumberjack.h")

// Use CocoaLumberjack since available

#undef LOG_LEVEL_DEF
#define LOG_LEVEL_DEF DDLogLevelVerbose
#import <CocoaLumberjack/CocoaLumberjack.h>

#define GSLogTrace   DDLogVerbose
#define GSLogDebug   DDLogDebug
#define GSLogInfo    DDLogInfo
#define GSLogWarn    DDLogWarn
#define GSLogError   DDLogError

#else

// Otherwise just use NSLog

#define GSLogTrace(frmt, ...)   NSLog((@"[%@] "  frmt), @"TRACE", ##__VA_ARGS__)
#define GSLogDebug(frmt, ...)   NSLog((@"[%@] "  frmt), @"DEBUG", ##__VA_ARGS__)
#define GSLogInfo(frmt, ...)    NSLog((@"[%@]  " frmt), @"INFO", ##__VA_ARGS__)
#define GSLogWarn(frmt, ...)    NSLog((@"[%@]  " frmt), @"WARN", ##__VA_ARGS__)
#define GSLogError(frmt, ...)   NSLog((@"[%@] "  frmt), @"ERROR", ##__VA_ARGS__)

#endif
