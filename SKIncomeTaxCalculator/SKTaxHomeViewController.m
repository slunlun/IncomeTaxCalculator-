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

@interface SKTaxHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) UITableView *tableView;
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
        SKTaxPaymentItemDataModel *model4 = [[SKTaxPaymentItemDataModel alloc] initWithTitle:@"住房情况:" content:@"" placeholder:@"选择住房/租房类型" isSelected:NO modelType:SKTaxModelTypeContinuingEducation];
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
    self.textField.placeholder = @"请输入税前月薪或税后月薪";
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:_textField];
    
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
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField).offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    self.textField.backgroundColor = [UIColor clearColor];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SKTaxHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TAX_HOME_TABLEVIEW_CELL"];
    if (!cell) {
        cell = [[SKTaxHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TAX_HOME_TABLEVIEW_CELL"];
    }
    
    SKTaxPaymentItemDataModel *model = self.data[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKTaxPaymentItemDataModel *model = self.data[indexPath.row];
    NSLog(@"%@--------clicked",model.itemTitle);
}

@end

