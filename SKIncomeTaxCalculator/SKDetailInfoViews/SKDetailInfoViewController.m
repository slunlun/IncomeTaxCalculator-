//
//  SKDetailInfoViewController.m
//  SKIncomeTaxCalculator
//
//  Created by Tim (Xinyin) Liu on 2018/12/26.
//  Copyright © 2018 skyline. All rights reserved.
//

#import "SKDetailInfoViewController.h"
#import "SKSocialSecurityView.h"
#import "Masonry.h"
@interface SKDetailInfoViewController ()

@property (nonatomic, strong) UILabel *payLabel;
@property (nonatomic, strong) UILabel *incomeLabel;


@end

@implementation SKDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"1月详细";
    [self commonInit];
}
- (void)commonInit {
    UILabel *payLabel = [[UILabel alloc]init];
    [self.view addSubview:payLabel];
    self.payLabel = payLabel;
    
    UILabel *incomeLabel = [[UILabel alloc]init];
    [self.view addSubview:incomeLabel];
    self.incomeLabel = incomeLabel;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
