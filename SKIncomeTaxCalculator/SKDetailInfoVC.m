//
//  SKDetailInfoVC.m
//  SKIncomeTaxCalculator
//
//  Created by Tim (Xinyin) Liu on 2018/12/27.
//  Copyright © 2018 skyline. All rights reserved.
//

#import "SKDetailInfoVC.h"
#import "SKSocialSecurityView.h"
#import "Masonry.h"
#import "SKBaseFormView.h"
@interface SKDetailInfoVC ()
@property (nonatomic, strong) UILabel *payLabel;
@property (nonatomic, strong) UILabel *incomeLabel;
@property (nonatomic, strong) UIScrollView *bgScrollView;
@end

@implementation SKDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"1月详细";
    [self commonInit];
}
- (void)commonInit {
    UILabel *payLabel = [[UILabel alloc]init];
    [self.view addSubview:payLabel];
    self.payLabel = payLabel;
    self.payLabel.text = [NSString stringWithFormat:@"月薪 : 20000"];
    
    UILabel *incomeLabel = [[UILabel alloc]init];
    [self.view addSubview:incomeLabel];
    self.incomeLabel = incomeLabel;
    self.incomeLabel.text = [NSString stringWithFormat:@"税后所得 : 15000"];
    UIScrollView *bgScrollView = [[UIScrollView alloc]init];
    bgScrollView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:bgScrollView];
    self.bgScrollView = bgScrollView;
    bgScrollView.contentSize = CGSizeMake(0, 900);
    
    UILabel *thresholdLabel = [[UILabel alloc]init];
    thresholdLabel.text = [NSString stringWithFormat:@"起征点 : 5000"];
    [bgScrollView addSubview:thresholdLabel];
    NSArray *securityDataArray = @[@[@" ",@"个人",@"单位"],@[@" ",@"比例%",@"金额",@"比例%",@"金额"],@[@"养老",@"0",@"0",@"0",@"0"],@[@"医疗",@"0",@"0",@"0",@"0"],@[@"失业",@"0",@"0",@"0",@"0"],@[@"公积金",@"0",@"0",@"0",@"0"],@[@"小计",@"0",@"0"]];
    SKSocialSecurityView *socialView = [[SKSocialSecurityView alloc]initWithDataArray:securityDataArray];
    [bgScrollView addSubview:socialView];
    
    NSArray *dataArray = @[@[@"项目",@"金额"],@[@"子女",@"1000元"],@[@"父母",@"2000"],@[@"租金",@"1500"]];
    
    SKBaseFormView *specialView = [[SKBaseFormView alloc]initWithDataArray:dataArray];
    [bgScrollView addSubview:specialView];
    specialView.titleLabel.text = @"专项扣除";
   NSArray *taxDataArray =  @[@[@"预扣率(%)",@"速算扣除数",@"纳税额"],@[@"3",@"0",@"300"]];
    SKBaseFormView *taxView = [[SKBaseFormView alloc]initWithDataArray:taxDataArray];
    [bgScrollView addSubview:taxView];
    taxView.titleLabel.text = @"个税";
    [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft).offset(10);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight).offset(-10);
            make.height.equalTo(@40);

        } else {
            make.top.equalTo(self.mas_topLayoutGuideBottom).offset(10);
            make.left.equalTo(self.view).offset(10);
            make.right.equalTo(self.view).offset(-10);
            make.height.equalTo(@40);
        }
       
    }];
    [incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payLabel.mas_bottom).offset(10);
        make.left.right.equalTo(payLabel);
        make.height.equalTo(@40);
    }];
    [bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(incomeLabel.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [thresholdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgScrollView).offset(10);
        make.left.right.equalTo(payLabel);
        make.height.equalTo(@40);
    }];
    [socialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thresholdLabel.mas_bottom).offset(10);
        make.left.right.equalTo(incomeLabel);
    }];
    [specialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(socialView.mas_bottom).offset(10);
        make.left.right.equalTo(socialView);
    }];
    [taxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(specialView.mas_bottom);
        make.left.right.equalTo(specialView);
    }];
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
