//
//  JFZLogFormatter.m
//  GXQApp
//
//  Created by ganquan on 11/5/14.
//  Copyright (c) 2014 jinfuzi. All rights reserved.
//

#import "JFZLogFormatter.h"

@implementation JFZLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *log;
    NSDateFormatter *logTimeFormatter = [[NSDateFormatter alloc] init];
    [logTimeFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss.SSS"];
    NSString *logTimeStamp =[logTimeFormatter stringFromDate: logMessage->_timestamp];
    
    switch (logMessage->_context) {
        case JFZ_COMMON_LOG_CONTEXT:
        {
            NSString *logPrefix = @"[COMMON]: ";
            
            if ((logMessage->logLevel == JC_LOG_LEVEL_DEBUG)
                || (logMessage->logLevel == JC_LOG_LEVEL_VERBOSE)) {
                NSString *fullLogMessage = [NSString stringWithFormat:@"%@ | %s @%i | %@",
                                            [logMessage fileName], logMessage->function, logMessage->lineNumber, logMessage->logMsg];
                log = [NSString stringWithFormat:@"%@ %@%@", logTimeStamp, logPrefix, fullLogMessage];
            }
            else
            {
                log = [NSString stringWithFormat:@"%@ %@%@", logTimeStamp, logPrefix, logMessage->logMsg];
            }
            
        }
            break;
        case JFZ_NETWORK_LOG_CONTEXT:
        {
            NSString *logPrefix = @"[NETWORK]: ";
            
            if ((logMessage->logLevel == JN_LOG_LEVEL_DEBUG)
                || (logMessage->logLevel == JN_LOG_LEVEL_VERBOSE)) {
                NSString *fullLogMessage = [NSString stringWithFormat:@"%@ | %s @%i | %@",
                                            [logMessage fileName], logMessage->function, logMessage->lineNumber, logMessage->logMsg];
                log = [NSString stringWithFormat:@"%@ %@%@", logTimeStamp, logPrefix, fullLogMessage];
            }
            else
            {
                log = [NSString stringWithFormat:@"%@ %@%@", logTimeStamp, logPrefix, logMessage->logMsg];
            }
        }
            break;
        case JFZ_DATABASE_LOG_CONTEXT:
        {
            NSString *logPrefix = @"[DATABASE]: ";
            
            if ((logMessage->logLevel == JD_LOG_LEVEL_DEBUG)
                || (logMessage->logLevel == JD_LOG_LEVEL_VERBOSE)) {
                NSString *fullLogMessage = [NSString stringWithFormat:@"%@ | %s @%i | %@",
                                            [logMessage fileName], logMessage->function, logMessage->lineNumber, logMessage->logMsg];
                log = [NSString stringWithFormat:@"%@ %@%@", logTimeStamp, logPrefix, fullLogMessage];
            }
            else
            {
                log = [NSString stringWithFormat:@"%@ %@%@", logTimeStamp, logPrefix, logMessage->logMsg];
            }        }
            break;
        case JFZ_EVENT_LOG_CONTEXT:
        {
            NSString *logPrefix = @"[EVENT]: ";
            
            if ((logMessage->logLevel == JE_LOG_LEVEL_DEBUG)
                || (logMessage->logLevel == JE_LOG_LEVEL_VERBOSE)) {
                NSString *fullLogMessage = [NSString stringWithFormat:@"%@ | %s @%i | %@",
                                            [logMessage fileName], logMessage->function, logMessage->lineNumber, logMessage->logMsg];
                log = [NSString stringWithFormat:@"%@ %@%@", logTimeStamp, logPrefix, fullLogMessage];
            }
            else
            {
                log = [NSString stringWithFormat:@"%@ %@%@", logTimeStamp, logPrefix, logMessage->logMsg];
            }
        }
            break;
        default:
        {
            NSString *logPrefix = @"[DDLog]: ";
            
                NSString *fullLogMessage = [NSString stringWithFormat:@"%@ | %s @%i | %@",
                                            [logMessage fileName], logMessage->function, logMessage->lineNumber, logMessage->logMsg];
                log = [NSString stringWithFormat:@"%@ %@%@", logTimeStamp, logPrefix, fullLogMessage];
        }
            break;
    }
    
    return log;
}
@end
