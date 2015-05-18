//
//  JEventLog.h
//  GXQApp
//
//  Created by ganquan on 11/5/14.
//  Copyright (c) 2014 jinfuzi. All rights reserved.
//

#ifndef GXQApp_JEventLog_h
#define GXQApp_JEventLog_h

#define JE_LOG_CONTEXT JFZ_EVENT_LOG_CONTEXT

// Configure log levels.
#define JE_LOG_FLAG_ERROR   (1 << 0) // 0...00001
#define JE_LOG_FLAG_WARN    (1 << 1) // 0...00010
#define JE_LOG_FLAG_INFO    (1 << 2) // 0...00100
#define JE_LOG_FLAG_DEBUG   (1 << 3) // 0...01000
#define JE_LOG_FLAG_VERBOSE (1 << 4) // 0...10000

#define JE_LOG_LEVEL_OFF     0                                          // 0...00000
#define JE_LOG_LEVEL_ERROR   (JE_LOG_LEVEL_OFF   | JE_LOG_FLAG_ERROR)   // 0...00001
#define JE_LOG_LEVEL_WARN    (JE_LOG_LEVEL_ERROR | JE_LOG_FLAG_WARN)    // 0...00011
#define JE_LOG_LEVEL_INFO    (JE_LOG_LEVEL_WARN  | JE_LOG_FLAG_INFO)    // 0...00111
#define JE_LOG_LEVEL_DEBUG   (JE_LOG_FLAG_INFO   | JE_LOG_FLAG_DEBUG)   // 0...01111
#define JE_LOG_LEVEL_VERBOSE (JE_LOG_LEVEL_INFO  | JE_LOG_FLAG_VERBOSE) // 0...11111

////////////////////////////////////////////////////////////////////////////////

#define JE_LOG_FLAG_TRACE   (1 << 4) // 0...10000

////////////////////////////////////////////////////////////////////////////////

#define JE_LOG_ERROR    (JELogLevel & JE_LOG_FLAG_ERROR)
#define JE_LOG_WARN     (JELogLevel & JE_LOG_FLAG_WARN)
#define JE_LOG_INFO     (JELogLevel & JE_LOG_FLAG_INFO)
#define JE_LOG_DEBUG    (JELogLevel & JE_LOG_FLAG_DEBUG)
#define JE_LOG_VERBOSE  (JELogLevel & JE_LOG_FLAG_VERBOSE)

////////////////////////////////////////////////////////////////////////////////

#define JE_LOG_ASYNC_ENABLED   YES

#define JE_LOG_ASYNC_ERROR   ( NO && JE_LOG_ASYNC_ENABLED)
#define JE_LOG_ASYNC_WARN    (YES && JE_LOG_ASYNC_ENABLED)
#define JE_LOG_ASYNC_INFO    (YES && JE_LOG_ASYNC_ENABLED)
#define JE_LOG_ASYNC_DEBUG   (YES && JE_LOG_ASYNC_ENABLED)
#define JE_LOG_ASYNC_VERBOSE (YES && JE_LOG_ASYNC_ENABLED)

////////////////////////////////////////////////////////////////////////////////

#define JELogError(frmt, ...)    LOG_OBJC_MAYBE(JE_LOG_ASYNC_ERROR,   JELogLevel, JE_LOG_FLAG_ERROR,  \
JE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JELogWarn(frmt, ...)     LOG_OBJC_MAYBE(JE_LOG_ASYNC_WARN,    JELogLevel, JE_LOG_FLAG_WARN,   \
JE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JELogInfo(frmt, ...)     LOG_OBJC_MAYBE(JE_LOG_ASYNC_INFO,    JELogLevel, JE_LOG_FLAG_INFO,    \
JE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JELogDebug(frmt, ...)     LOG_OBJC_MAYBE(JE_LOG_ASYNC_DEBUG,  JELogLevel, JE_LOG_FLAG_DEBUG,   \
JE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JELogVerbose(frmt, ...)  LOG_OBJC_MAYBE(JE_LOG_ASYNC_VERBOSE, JELogLevel, JE_LOG_FLAG_VERBOSE, \
JE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

////////////////////////////////////////////////////////////////////////////////
#define JELogCError(frmt, ...)      LOG_C_MAYBE(JE_LOG_ASYNC_ERROR,   JELogLevel, JE_LOG_FLAG_ERROR,   \
JE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JELogCWarn(frmt, ...)       LOG_C_MAYBE(JE_LOG_ASYNC_WARN,    JELogLevel, JE_LOG_FLAG_WARN,    \
JE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JELogCInfo(frmt, ...)       LOG_C_MAYBE(JE_LOG_ASYNC_INFO,    JELogLevel, JE_LOG_FLAG_INFO,    \
JE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JELogCDebug(frmt, ...)       LOG_C_MAYBE(JE_LOG_ASYNC_DEBUG,  JELogLevel, JE_LOG_FLAG_DEBUG,   \
JE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JELogCVerbose(frmt, ...)    LOG_C_MAYBE(JE_LOG_ASYNC_VERBOSE, JELogLevel, JE_LOG_FLAG_VERBOSE, \
JE_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#endif
