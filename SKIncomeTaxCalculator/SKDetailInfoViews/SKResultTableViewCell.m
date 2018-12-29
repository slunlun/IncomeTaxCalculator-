//
//  SKResultTableViewCell.m
//  SKIncomeTaxCalculator
//
//  Created by Tim (Xinyin) Liu on 2018/12/27.
//  Copyright © 2018 skyline. All rights reserved.
//

#import "SKResultTableViewCell.h"
#import "Masonry.h"
static const CGFloat topSpace = 10;
static const CGFloat leftOrRightSpace = 10;
@interface SKResultTableViewCell ()
@property(nonatomic, strong) UILabel *payValueLabel;
@property(nonatomic, strong) UILabel *socialValueLabel;
@property(nonatomic, strong) UILabel *specialValueLabel;
@property(nonatomic, strong) UILabel *taxValueLabel;
@property(nonatomic, strong) UILabel *incomeValueLabel;
@end
@implementation SKResultTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self commonInit];
    }
    return self;
}
- (void)commonInit {
    UILabel *payLabel = [[UILabel alloc]init];
    payLabel.text = @"月薪 :";
    [self.contentView addSubview:payLabel];
    
    UILabel *payValueLabel = [[UILabel alloc]init];
    [self.contentView addSubview:payValueLabel];
    self.payValueLabel = payValueLabel;
    
    UILabel *socialLabel = [[UILabel alloc]init];
    socialLabel.text = @"三线一金 :";
    [self.contentView addSubview:socialLabel];
    
    UILabel *socialValueLabel = [[UILabel alloc]init];
    [self.contentView addSubview:socialValueLabel];
    self.socialValueLabel = socialValueLabel;
    
    UILabel *specialLabel = [[UILabel alloc]init];
    specialLabel.text = @"专项扣除 :";
    [self.contentView addSubview:specialLabel];
    
    UILabel *specialValueLabel = [[UILabel alloc]init];
    [self.contentView addSubview:specialValueLabel];
    self.specialValueLabel = specialValueLabel;
    
    UILabel *taxLabel = [[UILabel alloc]init];
    taxLabel.text = @"纳税额 :";
    [self.contentView addSubview:taxLabel];
    
    UILabel *taxValueLabel = [[UILabel alloc]init];
    [self.contentView addSubview:taxValueLabel];
    self.taxValueLabel = taxValueLabel;
    
    UILabel *incomeLabel = [[UILabel alloc]init];
    incomeLabel.text = @"实际所得 :";
    [self.contentView addSubview:incomeLabel];
    
    UILabel *incomeValueLabel = [[UILabel alloc]init];
    [self.contentView addSubview:incomeValueLabel];
    
    
    [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(topSpace);
        make.left.equalTo(self.contentView).offset(leftOrRightSpace);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    [payValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(payLabel);
        make.left.equalTo(payLabel.mas_right).offset(leftOrRightSpace);
        make.right.equalTo(self.contentView).offset(-leftOrRightSpace);
    }];
    [socialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(payLabel);
        make.top.equalTo(payLabel.mas_bottom).offset(topSpace/2);
    }];
    [socialValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(payValueLabel);
        make.top.equalTo(socialLabel);
    }];
    [specialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(socialLabel);
        make.top.equalTo(socialLabel.mas_bottom).offset(topSpace/2);
    }];
    [specialValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(socialValueLabel);
        make.top.equalTo(socialValueLabel.mas_bottom).offset(topSpace/2);
    }];
    [taxLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(specialLabel.mas_bottom).offset(topSpace/2);
        make.left.width.height.equalTo(specialLabel);
    }];
    [taxValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(specialValueLabel.mas_bottom).offset(topSpace/2);
        make.left.right.height.equalTo(specialValueLabel);
    }];
    [incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(taxLabel.mas_bottom).offset(topSpace/2);
        make.width.height.left.equalTo(taxLabel);
    }];
    [incomeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(incomeLabel);
        make.left.right.height.equalTo(taxValueLabel);
        make.bottom.equalTo(self.contentView).offset(-topSpace);
    }];
}
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    self.payValueLabel.text = dataArray[0];
    self.socialValueLabel.text = dataArray[1];
    self.specialValueLabel.text = dataArray[2];
    self.taxValueLabel.text = dataArray[3];
    self.incomeValueLabel.text = dataArray[4];
}


@end
