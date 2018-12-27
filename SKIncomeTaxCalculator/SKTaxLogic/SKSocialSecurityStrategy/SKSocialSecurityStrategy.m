//
//  SKSocialSecurityStrategy.m
//  SKIncomeTaxCalculator
//
//  Created by Eren on 2018/12/27.
//  Copyright © 2018 skyline. All rights reserved.
//

#import "SKSocialSecurityStrategy.h"
#import "NSObject+SKRuntime.h"

@implementation SKSocialSecurityStrategy

- (CGFloat)calculateCompanyPaied:(CGFloat)salary {
    CGFloat socialSecurityBaseLine = salary > self.MAX_SS_BASELINE.floatValue?self.MAX_SS_BASELINE.floatValue:salary;
    CGFloat PFBaseLine = salary > self.MAX_PF_BASELINE.floatValue?self.MAX_PF_BASELINE.floatValue:salary;
    
    return socialSecurityBaseLine * self.C_ED.floatValue * self.C_MD.floatValue * self.C_UE.floatValue  +  PFBaseLine * self.C_PF.floatValue;
}

- (CGFloat)calculatePersonalPaied:(CGFloat)salary {
    CGFloat socialSecurityBaseLine = salary > self.MAX_SS_BASELINE.floatValue?self.MAX_SS_BASELINE.floatValue:salary;
    CGFloat PFBaseLine = salary > self.MAX_PF_BASELINE.floatValue?self.MAX_PF_BASELINE.floatValue:salary;
    
    return socialSecurityBaseLine * self.P_ED.floatValue * self.P_MD.floatValue * self.P_UE.floatValue + PFBaseLine * self.P_PF.floatValue;
}

- (CGFloat)calculateTotaolPaied:(CGFloat)salary {
    return [self calculatePersonalPaied:salary] + [self calculateCompanyPaied:salary];
}

#pragma mark - Equal
- (BOOL)isEqual:(id)object {
    if ([object isMemberOfClass:[SKSocialSecurityStrategy class]]) {
        if ([((SKSocialSecurityStrategy *)object).SS_ID isEqualToString:self.SS_ID]) {
            return YES;
        }
    }
    return NO;
}

- (NSUInteger)hash {
    return [self.SS_ID hash];
}

#pragma mark - convertToDictionary
- (NSDictionary *)convertToDictionary {
    return [self getAllPropertiesAndVaules];
    
}

@end
