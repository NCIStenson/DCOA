//
//  CCityNotficModel.m
//  LFOA
//
//  Created by  abcxdx@sina.com on 2017/9/13.
//  Copyright © 2017年  abcxdx@sina.com. All rights reserved.
//

#import "CCityNotficModel.h"

@implementation CCityFileModel

-(instancetype)initWithDic:(NSDictionary *)dic {
    
    self = [super initWithDic:dic];
    
    if (self) {
       
        _fileName = dic[@"name"];
        _fileSize = dic[@"size"];
        _fileUrl  = dic[@"path"];
        _type = [[_fileName componentsSeparatedByString:@"."] lastObject];
    }
    
    return self;
}


@end

@implementation CCityNotficModel

-(instancetype)initWithDic:(NSDictionary *)dic {
    
    self = [super initWithDic:dic];
    
    if (self) {
        
        _isHeightLevel  = [dic[@"emergency"] boolValue];
        _notficFromName = dic[@"orgname"];
        _notficPostTime = [self formatTiemWithTime:dic[@"releasedate"]];
        _notficTitle    = dic[@"noticename"];
        _notficContent  = dic[@"noticecontent"];
        
        NSArray* files = dic[@"children"];
        
        if (files.count) {
            _isHaveFile = YES;
            
            NSMutableArray* filesMuArr = [NSMutableArray arrayWithCapacity:files.count];
            for (int i = 0; i < files.count; i++) {
                
                CCityFileModel* fileModel = [[CCityFileModel alloc]initWithDic:files[i]];
                [filesMuArr addObject:fileModel];
            }
            
            _files = [filesMuArr mutableCopy];
            
        } else {
            
            _isHaveFile = NO;
        }
    }
    return self;
}

-(NSString*)formatTiemWithTime:(NSString*)time {
    
    NSArray* times = [time componentsSeparatedByString:@" "];
    NSString* YMD = [times firstObject];
    NSArray* YMDS = [YMD componentsSeparatedByString:@"/"];
    
    return [NSString stringWithFormat:@"%@-%@-%@", YMDS[0], YMDS[1], YMDS[2]];
}

@end
