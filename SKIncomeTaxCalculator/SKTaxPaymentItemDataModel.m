//
//  SKTaxPaymentItemDataModel.m
//  SKIncomeTaxCalculator
//
//  Created by Stepanoval (Xinxin) Huang on 2018/12/26.
//  Copyright © 2018 skyline. All rights reserved.
//

#import "SKTaxPaymentItemDataModel.h"

@implementation SKTaxPaymentItemDataModel

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content placeholder:(NSString *)placeholder isSelected:(BOOL)isSelected modelType:(SKTaxModelType)type;
{
    self = [super init];
    if (self) {
        _itemTitle = title;
        _content = content;
        _placeholder = placeholder;
        _isSelected = isSelected;
        _type = type;
    }
    return self;
}

@end

