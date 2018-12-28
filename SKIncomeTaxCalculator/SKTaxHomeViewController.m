//
//  SKTaxHomeViewController.m
//  SKIncomeTaxCalculator
//
//  Created by Stepanoval (Xinxin) Huang on 2018/12/25.
//  Copyright © 2018 skyline. All rights reserved.
//

#import "SKTaxHomeViewController.h"
#import "Masonry.h"
#import "SKDef.h"
#import "SKTaxHomeTableViewCell.h"
#import "SKTaxPaymentItemDataModel.h"
#import "SKUniversalSingleSelectionPickerView.h"
#import "SKCityChooseViewController.h"

@interface SKTaxHomeViewController ()<UITableViewDelegate,UITableViewDataSource,SKBasePickerViewDelegate,SKTaxHomeTableViewCellDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *cityChooseButton;
@property (nonatomic,strong) UIButton *cityDisplayButton;
@property (nonatomic,strong) UIButton *taxCalculateButton;
@property (nonatomic,strong) NSArray *data;

@end

@implementation SKTaxHomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _textField = [[UITextField alloc] init];
        _data = [[NSArray alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个税计算器";
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBackground:)];
    tapGesture.delegate = self;
    [self.view addGestureRecognizer:tapGesture];
    
    [self tableData];
    [self commonInit];
    [self commonInitNavgationBar];
    // Do any additional setup after loading the view.
}

-(NSArray *)tableData
{
    if (self.data.count == 0) {
        NSMutableArray *dataModelArray = [[NSMutableArray alloc] init];
        
        SKTaxPaymentItemDataModel *model1 = [[SKTaxPaymentItemDataModel alloc] initWithTitle:@"专项附加扣除:" content:@"" placeholder:@"" isSelected:NO modelType:SKTaxModelTypeSpecialAdditionalDeduction];
        SKTaxPaymentItemDataModel *model2 = [[SKTaxPaymentItemDataModel alloc] initWithTitle:@"子女教育:" content:@"" placeholder:@"选择受教育子女" isSelected:NO modelType:SKTaxModelTypeChildEducation];
        SKTaxPaymentItemDataModel *model3 = [[SKTaxPaymentItemDataModel alloc] initWithTitle:@"继续教育:" content:@"" placeholder:@"选择继续教育情况" isSelected:NO modelType:SKTaxModelTypeContinuingEducation];
        SKTaxPaymentItemDataModel *model4 = [[SKTaxPaymentItemDataModel alloc] initWithTitle:@"住房情况:" content:@"" placeholder:@"选择住房/租房类型" isSelected:NO modelType:SKTaxModelTypeHousingSituation];
        SKTaxPaymentItemDataModel *model5 = [[SKTaxPaymentItemDataModel alloc] initWithTitle:@"赡养老人:" content:@"" placeholder:@"选择赡养老人情况" isSelected:NO modelType:SKTaxModelTypeSupportForTheElderly];
        
        [dataModelArray addObject:model1];
        [dataModelArray addObject:model2];
        [dataModelArray addObject:model3];
        [dataModelArray addObject:model4];
        [dataModelArray addObject:model5];
        
        self.data = [dataModelArray copy];
    }
    return self.data;
}

- (void)commonInit
{
    self.textField.placeholder = @"请输入税前月薪月薪";
    self.textField.delegate = self;
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.view addSubview:_textField];
    
    UIButton *cityButton = [[UIButton alloc] init];
    cityButton.backgroundColor = [UIColor clearColor];
    [cityButton setTitle:@"所在地区" forState:UIControlStateNormal];
    [cityButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cityButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [cityButton setImage:[UIImage imageNamed:@"accessoryIcon"] forState:UIControlStateNormal];
    cityButton.titleEdgeInsets = UIEdgeInsetsMake(0, - cityButton.imageView.bounds.size.width - 40.0, 0, cityButton.imageView.bounds.size.width);
    cityButton.imageEdgeInsets = UIEdgeInsetsMake(0, cityButton.imageView.bounds.size.width + 68.0, 0, 0);
    [cityButton addTarget:self action:@selector(cityChooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.cityChooseButton = cityButton;
    [self.view addSubview:cityButton];
    
    UIButton *cityDisplayButton = [[UIButton alloc] init];
    cityDisplayButton.backgroundColor = [UIColor clearColor];
    NSString *dispalyName = [SKTaxContext sharedInstance].currentSecurityStrategy.SS_TITLE;
    [cityDisplayButton setTitle:dispalyName forState:UIControlStateNormal];
    [cityDisplayButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cityDisplayButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.cityDisplayButton = cityDisplayButton;
    [self.view addSubview:cityDisplayButton];
    
    UIButton *calculateButton = [[UIButton alloc] init];
    calculateButton.layer.cornerRadius = 2.0;
    calculateButton.backgroundColor = [UIColor clearColor];
    [calculateButton setTitle:@"计算" forState:UIControlStateNormal];
    [calculateButton addTarget:self action:@selector(calculateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [calculateButton setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:150.0/255.0 blue:73.0/255.0 alpha:1.0]];
    calculateButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.taxCalculateButton = calculateButton;
    [self.view addSubview:calculateButton];
    
    //init tableview
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 50;
    tableView.backgroundColor = [UIColor clearColor];
    
    [tableView registerClass:[SKTaxHomeTableViewCell class] forCellReuseIdentifier:@"TAX_HOME_TABLEVIEW_CELL"];
    tableView.allowsMultipleSelection = NO;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, kMargin * 4, 0);
    tableView.cellLayoutMarginsFollowReadableWidth = NO;
    tableView.tableFooterView =[[UIView alloc]init];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
    CGFloat textFieldWidth = self.view.frame.size.width - 20*2;
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(20);
        make.width.equalTo(@(textFieldWidth));
        make.height.equalTo(@55);
    }];
    
    [_cityChooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.height.equalTo(@(45));
        make.width.equalTo(@(90));
        make.top.equalTo(self.textField.mas_bottom).offset(8);
    }];
    
    [_cityDisplayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@(45));
        make.width.equalTo(@(90));
        make.top.equalTo(self.textField.mas_bottom).offset(8);
    }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@(280));
        //make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    [calculateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@(45));
        make.top.equalTo(self.tableView.mas_bottom).offset(20);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-60);
    }];
    
    //    self.textField.backgroundColor = [UIColor orangeColor];
    //    self.cityChooseButton.backgroundColor = [UIColor greenColor];
    
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

#pragma mark - table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKTaxHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TAX_HOME_TABLEVIEW_CELL"];
    cell.delegate = self;
    if (!cell) {
        cell = [[SKTaxHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TAX_HOME_TABLEVIEW_CELL"];
    }
    
    SKTaxPaymentItemDataModel *model = self.data[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
    SKTaxPaymentItemDataModel *model = self.data[indexPath.row];
    
    //pickView
    SKUniversalSingleSelectionPickerView *pickerView = [[SKUniversalSingleSelectionPickerView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight) delegate:self title:@"" leftBtnTitle:@"" rightBtnTitle:@"完成" dataModel:model];
    //    self.resultDict = pickerView.resultDict;
    pickerView.resultBlock = ^(SKTaxPaymentItemDataModel *newModel) {
        //        ws.resultDict = [[NSDictionary alloc] initWithDictionary:dict];
        model.content = newModel.content;
        [self.tableView reloadData];
    };
    
    [pickerView show];
    
    NSLog(@"%@--------clicked",model.itemTitle);
}

#pragma -mark SKBasePickerViewDelegate
- (void)actionWithButton:(UIButton *)sender title:(nonnull NSString *)title {
    switch (sender.tag) {
        case 100:
        {
            //            [YMBlackSmallAlert showAlertWithMessage:sender.titleLabel.text time:2.0f];
        }
            break;
        case 101:
        {
            //            NSLog(@"self.resultDict-- == %@", self.resultDict);
            //            NSString *pickerViewTitle = self.resultDict[@"pickerViewTitle"];
            //            [YMBlackSmallAlert showAlertWithMessage:pickerViewTitle time:2.0f];
            //
            //            if (![title isEqualToString:@"时间选择"]) {
            //                [[YMObtainUserLocationManager shareManager] transferMapWithAddress:pickerViewTitle view:self.view];
            //            }
        }
            break;
        default:
            break;
    }
}

#pragma -mark SKTaxHomeTableViewCellDelegate
- (void)actionWithDeleteButton:(SKTaxHomeTableViewCell *)cell dataModel:(SKTaxPaymentItemDataModel *)model
{
    [self.tableView reloadData];
}

#pragma -mark button click event

- (void)cityChooseButtonClicked:(id)sender
{
    SKCityChooseViewController *vc = [[SKCityChooseViewController alloc] init];
    [vc setChooseCompletedBlock:^(NSString *cityName) {
        [self.cityDisplayButton setTitle:cityName forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)calculateButtonClicked:(id)sender
{
    
}


#pragma -mark UITextfield Delagate

// 限制只能输入数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

#pragma mark - OnClick Background Event
- (void)onClickBackground:(id)sender
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    if ([touch.view isKindOfClass:[UIScrollView class]]){
        return YES;
    }else{
        return NO;
    }
}

@end


