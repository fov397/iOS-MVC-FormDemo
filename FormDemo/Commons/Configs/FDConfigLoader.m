//
//  FDConfig.m
//  FormDemo
//
//  Created by sasaki on 2014/07/24.
//  Copyright (c) 2014年 mycompany. All rights reserved.
//

#import "FDConfigLoader.h"

#ifdef DEBUG
    #define FD_CONFIG_LOADER_MIX_PLIST @"DebugConfig"
#else
    #define FD_CONFIG_LOADER_MIX_PLIST @"ReleaseConfig"
#endif

@implementation FDConfigLoader

// 共通コンフィグに環境別コンフィグを追加した辞書を返す
+ (NSDictionary *)mixIn
{
    NSBundle *bundle                  = [NSBundle mainBundle];
    NSString *path                    = [bundle pathForResource:@"CommonConfig" ofType:@"plist"];
    NSMutableDictionary *commonConfig = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    path                    = [bundle pathForResource:FD_CONFIG_LOADER_MIX_PLIST ofType:@"plist"];
    NSDictionary *mixConfig = [NSDictionary dictionaryWithContentsOfFile:path];
    [commonConfig addEntriesFromDictionary:mixConfig];
    
    return [commonConfig copy];
}

@end
