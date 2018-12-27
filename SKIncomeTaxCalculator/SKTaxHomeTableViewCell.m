//
//  SKTaxHomeTableViewCell.m
//  SKIncomeTaxCalculator
//
//  Created by Stepanoval (Xinxin) Huang on 2018/12/26.
//  Copyright © 2018 skyline. All rights reserved.
//

#import "SKTaxHomeTableViewCell.h"
#import "Masonry.h"
#import "SKDef.h"

@interface SKTaxHomeTableViewCell ()

@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *contentLabel;
@property(nonatomic, weak) UIView *customAccessView;
@property(nonatomic, weak) UIButton *deleteButton;
@property(nonatomic, weak) UIButton *policyDescripButton;

@end

@implementation SKTaxHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self commonInit];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setModel:(SKTaxPaymentItemDataModel *)model
{
    _model = model;
    self.titleLabel.text = model.itemTitle;
    if (model.isSelected || model.content.length > 0) {
        self.contentLabel.text = model.content;
        self.contentLabel.textColor = [UIColor blackColor];
    }else{
        self.contentLabel.text = model.placeholder;
        self.contentLabel.textColor = [UIColor lightGrayColor];
    }
    
    if (model.type == SKTaxModelTypeSpecialAdditionalDeduction) {
        [self.deleteButton setHidden:YES];
        [self.customAccessView setHidden:YES];
        [self.policyDescripButton setHidden:NO];
    }else{
        [self.deleteButton setHidden:NO];
        [self.customAccessView setHidden:NO];
        [self.policyDescripButton setHidden:YES];
    }
}

- (void)commonInit
{
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel = contentLabel;
    [self.contentView addSubview:contentLabel];
    
    UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"accessoryIcon"]];
    //accessoryView.backgroundColor = [UIColor redColor];
    self.customAccessView = accessoryView;
    [self.contentView addSubview:accessoryView];
    
    UIButton *deleteButton = [[UIButton alloc] init];
    [deleteButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    [deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.deleteButton = deleteButton;
    [self.contentView addSubview:deleteButton];
    
    UIButton *policyDesButton = [[UIButton alloc] init];
    [policyDesButton setTitle:@"政策解读" forState:UIControlStateNormal];
    [policyDesButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    policyDesButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [policyDesButton addTarget:self action:@selector(policyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.policyDescripButton = policyDesButton;
    [self.contentView addSubview:policyDesButton];
    
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor blackColor];
    
    contentLabel.font = [UIFont systemFontOfSize:16];
    contentLabel.textColor = [UIColor lightGrayColor];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kMargin);
        make.left.equalTo(self.contentView).offset(15);
        make.height.equalTo(@30);
        make.width.equalTo(@120);
    }];
    
    [accessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kMargin/2);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];
    
    [deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
        make.right.equalTo(accessoryView.mas_left).offset(-kMargin/2);
    }];
    
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kMargin);
        make.left.equalTo(titleLabel.mas_right).offset(15);
        make.right.equalTo(deleteButton).offset(-2);
        make.height.equalTo(@30);
    }];
    
    [policyDesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kMargin);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(0, kMargin, 0, kMargin));
    }];
}

#pragma -mark touch event
-(void)deleteButtonClicked:(id)sender
{
    //TODO
}

- (void)policyButtonClicked:(id)sender
{
    //TODO
}

@end

