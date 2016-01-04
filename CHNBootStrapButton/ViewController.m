//
//  ViewController.m
//  CHNBootStrapButton
//
//  Created by Chen Bin on 16/1/4.
//  Copyright © 2016年 Chen Bin. All rights reserved.
//

#import "ViewController.h"
#import "CHNBootstrapButton.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation ViewController

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataSource];
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - initialization
- (void)initTableView {
    CGFloat kScreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat kScreenHeight = [UIScreen mainScreen].bounds.size.height;

    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 60;
    [self.view addSubview:self.tableView];
}

- (void)initDataSource {
    NSNumber *defaultStyle = [NSNumber numberWithInt:CHNButtonStyleDefault];
    NSNumber *primaryStyle = [NSNumber numberWithInt:CHNButtonStylePrimary];
    NSNumber *infoStyle = [NSNumber numberWithInt:CHNButtonStyleInfo];
    NSNumber *successStyle = [NSNumber numberWithInt:CHNButtonStyleSuccess];
    NSNumber *warningStyle = [NSNumber numberWithInt:CHNButtonStyleWarning];
    NSNumber *dangerStyle = [NSNumber numberWithInt:CHNButtonStyleDanger];
    self.dataSource = @[defaultStyle, primaryStyle, infoStyle, successStyle, warningStyle, dangerStyle];
    self.titles = @[@"默认", @"主要", @"信息", @"成功", @"警告", @"危险"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"CHNBootstrapButton";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    NSString *title = self.titles[indexPath.row];
    cell.textLabel.text = title;
    
    int style = [self.dataSource[indexPath.row] intValue];
    CGRect frame = CGRectMake(0, 0, 100, 50);
    CHNBootstrapButton *button = [[CHNBootstrapButton alloc] initWithStyle:style title:title frame:frame];
    button.tag = style;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.accessoryView = button;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - event
- (void)buttonClick:(UIButton *)button {
    switch (button.tag) {
        case CHNButtonStyleDefault:
            [self showAlert:@"默认按钮被点击！"];
            break;
        case CHNButtonStylePrimary:
            [self showAlert:@"主要按钮被点击！"];
            break;
        case CHNButtonStyleInfo:
            [self showAlert:@"信息按钮被点击！"];
            break;
        case CHNButtonStyleSuccess:
            [self showAlert:@"成功按钮被点击！"];
            break;
        case CHNButtonStyleWarning:
            [self showAlert:@"警告按钮被点击！"];
            break;
        case CHNButtonStyleDanger:
            [self showAlert:@"危险按钮被点击！"];
            break;
        default:
            break;
    }
}

- (void)showAlert:(NSString *)msg {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

@end
