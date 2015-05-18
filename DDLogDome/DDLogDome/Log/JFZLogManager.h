//
//  JFZLogManager.h
//  GXQApp
//
//  Created by ganquan on 11/5/14.
//  Copyright (c) 2014 jinfuzi. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JFZ_COMMON_LOG_CONTEXT      (0x01)
#define JFZ_NETWORK_LOG_CONTEXT     (0x02)
#define JFZ_DATABASE_LOG_CONTEXT    (0x03)
#define JFZ_EVENT_LOG_CONTEXT       (0x04)

extern int JCLogLevel;
extern int JNLogLevel;
extern int JDLogLevel;
extern int JELogLevel;

#import "JCommonLog.h"
#import "JNetworkLog.h"
#import "JDatabaseLog.h"
#import "JEventLog.h"



@interface JFZLogManager : NSObject

+ (id)sharedInstance;

- (void)initLogger;

/* 
 * 上传本地日志到服务端
 */
- (void)uploadLocalLogsToServer;
- (void)uploadFile:(NSString *)fileName InPath:(NSString *)filePath ToURL:(NSString *)uploadURL;

@end
