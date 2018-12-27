//
//  SKTaxContext.h
//  SKIncomeTaxCalculator
//
//  Created by Eren on 2018/12/27.
//  Copyright © 2018 skyline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SKSocialSecurityStrategy.h"
NS_ASSUME_NONNULL_BEGIN

@interface SKTaxContext : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong) SKSocialSecurityStrategy *currentSecurityStrategy;
@property (nonatomic, assign) CGFloat salary;
// 三险一金策略
- (void)updateCurrentSecurityStrategy:(SKSocialSecurityStrategy *)strategy;
- (void)loadAllSocialSecurity;
@property (nonatomic, strong) NSMutableArray<SKSocialSecurityStrategy *> *socialSecurityStrategies;
@property (nonatomic, strong) NSMutableArray *deductions;
@end

NS_ASSUME_NONNULL_END
