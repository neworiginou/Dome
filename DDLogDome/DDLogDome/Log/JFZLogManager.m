//
//  JFZLogManager.m
//  GXQApp
//
//  Created by ganquan on 11/5/14.
//  Copyright (c) 2014 jinfuzi. All rights reserved.
//

#import "JFZLogManager.h"
#import "JFZLogFormatter.h"
#import "DDLog.h"
#import "DDASLLogger.h"
#import "DDTTYLogger.h"
#import "DDFileLogger.h"

//#import "UserModule.h"
//#import "HttpManager.h"
//#import "JFZPushNotificationManager.h"

@interface JFZLogManager ()

@property (strong, nonatomic) DDFileLogger* fileLogger;

@end

@implementation JFZLogManager

+ (id)sharedInstance
{
    static dispatch_once_t once;
    static JFZLogManager *instance;
    dispatch_once(&once, ^ {
        
        instance = [[JFZLogManager alloc] init];
        
    });
    
    return instance;
}

- (void)initLogger
{
    if (self) {

        JFZLogFormatter *formatter = [[JFZLogFormatter alloc] init];
        
        [[DDASLLogger sharedInstance] setLogFormatter:formatter];
        [[DDTTYLogger sharedInstance] setLogFormatter:formatter];
        
        [DDLog addLogger:[DDASLLogger sharedInstance]];
        [DDLog addLogger:[DDTTYLogger sharedInstance]];
        
        
        _fileLogger = [[DDFileLogger alloc] init];
        [_fileLogger setLogFormatter:formatter];
        _fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        _fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        
        [DDLog addLogger:_fileLogger];
        
        JCLogInfo(@"FileLogPath = %@", [_fileLogger.logFileManager logsDirectory]);
    }
}

- (void)uploadLocalLogsToServer
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *logPath = [self.fileLogger.logFileManager logsDirectory];
        NSArray *logFiles = [self.fileLogger.logFileManager sortedLogFileNames];
        
        NSString *api = @"api/Index/LogFileReport";
        NSString *uploadLogURL = [NSString stringWithFormat:@"%@%@", GXQ_REPORT_BASE_URL, api];
        
        for (NSString *log in logFiles) {
            [self uploadFile:log InPath:logPath ToURL:uploadLogURL];
        }
        
        if (nil != logFiles) {
            JCLogInfo(@"Upload %lu logs to server.", (unsigned long)logFiles.count);
        }
        else{
            JCLogWarn(@"Upload log to server fail, find 0 log.");
        }
    });
}

- (void)uploadFile:(NSString *)fileName InPath:(NSString *)filePath ToURL:(NSString *)uploadURL
{
    NSString *fullFilePath = [NSString stringWithFormat:@"%@/%@", filePath, fileName];
    NSData *fileData = [[NSFileManager defaultManager] contentsAtPath:fullFilePath];
    NSString *uid = [[UserModule defaultModule] getUid];
    NSString *registrationId = [[JFZPushNotificationManager sharedInstance] registrationId];
    
    if (nil != uid) {
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:uploadURL]];
        [request setHTTPMethod:@"POST"];
        
        NSString *stringBoundary = @"---------------------------14737809831466499882746641449";
        
        //Header
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        //Body
        NSMutableData *body = [NSMutableData data];
        
        //参数
        NSDictionary *_params = @{
                                 @"uid":        uid,
                                 @"filename":   fileName,
                                 @"registrationId": registrationId
                                 };
        
        NSDictionary *signedParamDic = [_LOGIC getSignedParameter:_params];
        for (NSString *param in signedParamDic) {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n", [signedParamDic objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        //文件数据
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"applog\"; filename=\"%@\"\r\n", fileName] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:fileData];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        
        JCLogInfo(@"Upload log result: %@", returnString);
        
    }
    else
    {
        JCLogWarn(@"Upload log file to server fail. uid is nil");
    }
}

@end
