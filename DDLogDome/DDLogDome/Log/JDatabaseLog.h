//
//  JDatabaseLog.h
//  GXQApp
//
//  Created by ganquan on 11/5/14.
//  Copyright (c) 2014 jinfuzi. All rights reserved.
//

#ifndef GXQApp_JDatabaseLog_h
#define GXQApp_JDatabaseLog_h

#define JD_LOG_CONTEXT JFZ_DATABASE_LOG_CONTEXT

// Configure log levels.
#define JD_LOG_FLAG_ERROR   (1 << 0) // 0...00001
#define JD_LOG_FLAG_WARN    (1 << 1) // 0...00010
#define JD_LOG_FLAG_INFO    (1 << 2) // 0...00100
#define JD_LOG_FLAG_DEBUG   (1 << 3) // 0...01000
#define JD_LOG_FLAG_VERBOSE (1 << 4) // 0...10000

#define JD_LOG_LEVEL_OFF     0                                          // 0...00000
#define JD_LOG_LEVEL_ERROR   (JD_LOG_LEVEL_OFF   | JD_LOG_FLAG_ERROR)   // 0...00001
#define JD_LOG_LEVEL_WARN    (JD_LOG_LEVEL_ERROR | JD_LOG_FLAG_WARN)    // 0...00011
#define JD_LOG_LEVEL_INFO    (JD_LOG_LEVEL_WARN  | JD_LOG_FLAG_INFO)    // 0...00111
#define JD_LOG_LEVEL_DEBUG   (JD_LOG_FLAG_INFO   | JD_LOG_FLAG_DEBUG)   // 0...01111
#define JD_LOG_LEVEL_VERBOSE (JD_LOG_LEVEL_INFO  | JD_LOG_FLAG_VERBOSE) // 0...11111

////////////////////////////////////////////////////////////////////////////////

#define JD_LOG_FLAG_TRACE   (1 << 4) // 0...10000

////////////////////////////////////////////////////////////////////////////////

#define JD_LOG_ERROR    (JDLogLevel & JD_LOG_FLAG_ERROR)
#define JD_LOG_WARN     (JDLogLevel & JD_LOG_FLAG_WARN)
#define JD_LOG_INFO     (JDLogLevel & JD_LOG_FLAG_INFO)
#define JD_LOG_DEBUG    (JDLogLevel & JD_LOG_FLAG_DEBUG)
#define JD_LOG_VERBOSE  (JDLogLevel & JD_LOG_FLAG_VERBOSE)

////////////////////////////////////////////////////////////////////////////////

#define JD_LOG_ASYNC_ENABLED   YES

#define JD_LOG_ASYNC_ERROR   ( NO && JD_LOG_ASYNC_ENABLED)
#define JD_LOG_ASYNC_WARN    (YES && JD_LOG_ASYNC_ENABLED)
#define JD_LOG_ASYNC_INFO    (YES && JD_LOG_ASYNC_ENABLED)
#define JD_LOG_ASYNC_DEBUG   (YES && JD_LOG_ASYNC_ENABLED)
#define JD_LOG_ASYNC_VERBOSE (YES && JD_LOG_ASYNC_ENABLED)

////////////////////////////////////////////////////////////////////////////////

#define JDLogError(frmt, ...)    LOG_OBJC_MAYBE(JD_LOG_ASYNC_ERROR,   JDLogLevel, JD_LOG_FLAG_ERROR,  \
JD_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JDLogWarn(frmt, ...)     LOG_OBJC_MAYBE(JD_LOG_ASYNC_WARN,    JDLogLevel, JD_LOG_FLAG_WARN,   \
JD_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JDLogInfo(frmt, ...)     LOG_OBJC_MAYBE(JD_LOG_ASYNC_INFO,    JDLogLevel, JD_LOG_FLAG_INFO,    \
JD_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JDLogDebug(frmt, ...)     LOG_OBJC_MAYBE(JD_LOG_ASYNC_DEBUG,  JDLogLevel, JD_LOG_FLAG_DEBUG,   \
JD_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JDLogVerbose(frmt, ...)  LOG_OBJC_MAYBE(JD_LOG_ASYNC_VERBOSE, JDLogLevel, JD_LOG_FLAG_VERBOSE, \
JD_LOG_CONTEXT, frmt, ##__VA_ARGS__)

////////////////////////////////////////////////////////////////////////////////
#define JDLogCError(frmt, ...)      LOG_C_MAYBE(JD_LOG_ASYNC_ERROR,   JDLogLevel, JD_LOG_FLAG_ERROR,   \
JD_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JDLogCWarn(frmt, ...)       LOG_C_MAYBE(JD_LOG_ASYNC_WARN,    JDLogLevel, JD_LOG_FLAG_WARN,    \
JD_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JDLogCInfo(frmt, ...)       LOG_C_MAYBE(JD_LOG_ASYNC_INFO,    JDLogLevel, JD_LOG_FLAG_INFO,    \
JD_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JDLogCDebug(frmt, ...)       LOG_C_MAYBE(JD_LOG_ASYNC_DEBUG,  JDLogLevel, JD_LOG_FLAG_DEBUG,   \
JD_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#define JDLogCVerbose(frmt, ...)    LOG_C_MAYBE(JD_LOG_ASYNC_VERBOSE, JDLogLevel, JD_LOG_FLAG_VERBOSE, \
JD_LOG_CONTEXT, frmt, ##__VA_ARGS__)

#endif
