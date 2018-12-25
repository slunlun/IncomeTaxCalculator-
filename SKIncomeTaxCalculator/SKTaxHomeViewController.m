//
//  SKTaxHomeViewController.m
//  SKIncomeTaxCalculator
//
//  Created by Stepanoval (Xinxin) Huang on 2018/12/25.
//  Copyright © 2018 skyline. All rights reserved.
//

#import "SKTaxHomeViewController.h"
#import "Masonry.h"

@interface SKTaxHomeViewController ()

@property (nonatomic,strong) UITextField *textField;

@end

@implementation SKTaxHomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textField = [[UITextField alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个税计算器";
    [self commonInit];
    [self commonInitNavgationBar];
    // Do any additional setup after loading the view.
}

- (void)commonInit
{
    self.textField.placeholder = @"请输入税前或税后月薪";
    [self.view addSubview:_textField];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.width.equalTo(self.view);
        make.height.equalTo(@55);
    }];
    
}

- (void)commonInitNavgationBar {
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UIBarButtonItem *setBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Settings.png"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClcik:)];
    setBarButton.accessibilityValue = @"HOME_PAGE_SET_BTN";
    self.navigationItem.leftBarButtonItems = @[setBarButton];
    // add rightButton just for titleView is center.
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    rightButton.enabled = NO;
    self.navigationItem.rightBarButtonItems = @[rightButton];
    
}

- (void)leftBarButtonItemClcik:(UIBarButtonItem *) sender {
 //TODO
    NSLog(@"left button clicked!");
}

@end
