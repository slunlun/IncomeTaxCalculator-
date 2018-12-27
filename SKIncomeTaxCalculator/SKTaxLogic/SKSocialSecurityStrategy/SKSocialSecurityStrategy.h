//
//  SKSocialSecurityStrategy.h
//  SKIncomeTaxCalculator
//
//  Created by Eren on 2018/12/27.
//  Copyright © 2018 skyline. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SKSocialSecurityStrategy : NSObject
@property (nonatomic, strong) NSString *SS_ID;
@property (nonatomic, strong) NSString *SS_TITLE;

@property (nonatomic, strong) NSNumber *P_ED;
@property (nonatomic, strong) NSNumber *P_MD;
@property (nonatomic, strong) NSNumber *P_UE;
@property (nonatomic, strong) NSNumber *P_PF;

@property (nonatomic, strong) NSNumber *C_ED;
@property (nonatomic, strong) NSNumber *C_MD;
@property (nonatomic, strong) NSNumber *C_UE;
@property (nonatomic, strong) NSNumber *C_PF;


@property (nonatomic, strong) NSNumber *MAX_SS_BASELINE;
@property (nonatomic, strong) NSNumber *MAX_PF_BASELINE;

- (CGFloat)calculateCompanyPaied:(CGFloat)salary;
- (CGFloat)calculatePersonalPaied:(CGFloat)salary;
- (CGFloat)calculateTotaolPaied:(CGFloat)salary;
@end

NS_ASSUME_NONNULL_END
