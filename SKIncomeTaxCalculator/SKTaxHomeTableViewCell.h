//
//  SKTaxHomeTableViewCell.h
//  SKIncomeTaxCalculator
//
//  Created by Stepanoval (Xinxin) Huang on 2018/12/27.
//  Copyright © 2018 skyline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKTaxPaymentItemDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SKTaxHomeTableViewCell : UITableViewCell

@property(nonatomic, weak, readonly) UILabel *titleLabel;
@property(nonatomic, weak, readonly) UILabel *contentLabel;
@property(nonatomic, weak, readonly) UIView *customAccessView;
@property(nonatomic, weak, readonly) UIButton *deleteButton;

@property(nonatomic, strong) SKTaxPaymentItemDataModel *model;

@end
NS_ASSUME_NONNULL_END
