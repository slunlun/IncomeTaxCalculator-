//
//  SKTaxContext.m
//  SKIncomeTaxCalculator
//
//  Created by Eren on 2018/12/27.
//  Copyright © 2018 skyline. All rights reserved.
//

#import "SKTaxContext.h"
#import "SKSocialSecurityStrategy.h"

// 三险一金plist的key
#define ID @"SS_ID"
#define TITLE @"SS_TITLE"
#define P_ED @"P_ED"        // 个人养老保险比例
#define P_MD @"P_MD"        // 个人医疗保险比例
#define P_UE @"P_UE"        // 个人失业保险比例
#define P_PF @"P_PF"        // 个人公积金保险比例
#define C_ED @"C_ED"        // 公司养老保险比例
#define C_MD @"C_MD"        // 公司医疗保险比例
#define C_UE @"C_UE"        // 公司失业保险比例
#define C_PF @"C_PF"        // 公司公积金保险比例
#define MAX_SS_BASELINE @"MAX_SS_BASELINE"  // 社保最高基数
#define MAX_PF_BASELINE @"MAX_PF_BASELINE"  // 公积金最高基数



@interface SKTaxContext()
@property (nonatomic, strong) NSMutableArray<SKSocialSecurityStrategy *> *socialSecurityStrategies;
@property (nonatomic, strong) SKSocialSecurityStrategy *currentSecurityStrategy;
@end

@implementation SKTaxContext
+ (instancetype)sharedInstance {
    static SKTaxContext *sharedObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObj = [[SKTaxContext alloc] init];
    });
    return sharedObj;
}

#pragma mark - init
- (instancetype)init {
    if (self = [super init]) {
        [self loadAllSocialSecurity];
    }
    return self;
}

#pragma mark - social security
- (void)loadAllSocialSecurity {
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"SKSocialSecurity" ofType:@"plist"];
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *strategyDict = (NSDictionary *)obj;
        SKSocialSecurityStrategy *ss = [[SKSocialSecurityStrategy alloc] init];
        [ss setValuesForKeysWithDictionary:strategyDict];
        [self.socialSecurityStrategies addObject:ss];
    }];
    self.currentSecurityStrategy = self.socialSecurityStrategies.firstObject;  // 第一个三险一金策略为默认项
}

- (void)updateCurrentSecurityStrategy:(SKSocialSecurityStrategy *)strategy {
    if (![self.currentSecurityStrategy isEqual:strategy]) {
        self.currentSecurityStrategy = strategy;
        [self.socialSecurityStrategies removeObject:strategy];
        [self.socialSecurityStrategies insertObject:strategy atIndex:0];
    }
}

- (void)updateSocialSecurityPlist {
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"SKSocialSecurity" ofType:@"plist"];
    [self.socialSecurityStrategies writeToFile:plistPath atomically:YES];
}

#pragma mark - setter/getter
- (NSMutableArray *)deductions {
    if (_deductions == nil) {
        _deductions = [NSMutableArray array];
    }
    return _deductions;
}

- (NSMutableArray *)socialSecurityStrategies {
    if (_socialSecurityStrategies == nil) {
        _socialSecurityStrategies = [NSMutableArray array];
    }
    return _socialSecurityStrategies;
}


@end
