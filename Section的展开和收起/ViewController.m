//
//  ViewController.m
//  Section的展开和收起
//
//  Created by HGDQ on 15/10/24.
//  Copyright (c) 2015年 HGDQ. All rights reserved.
//

#import "ViewController.h"
#import "SectionViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *sectionArray;
@property (nonatomic,strong)NSMutableArray *flagArray;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self makeData];
	_tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	[self.view addSubview:_tableView];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/**
 *  处理数据  _sectionArray里面存储数组
 */
- (void)makeData{
	_sectionArray = [NSMutableArray array];
	_flagArray  = [NSMutableArray array];
	NSInteger num = 6;
	for (int i = 0; i < num; i ++) {
		NSMutableArray *rowArray = [NSMutableArray array];
		for (int j = 0; j < arc4random()%20 + 1; j ++) {
			[rowArray addObject:[NSString stringWithFormat:@"%d",j]];
		}
		[_sectionArray addObject:rowArray];
		[_flagArray addObject:@"0"];
	}
}
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return _sectionArray.count;
}
//设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	NSArray *arr = _sectionArray[section];
	return arr.count;
}
//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 44;
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if ([_flagArray[indexPath.section] isEqualToString:@"0"])
		return 0;
	else
		return 44;
}
//组头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	UILabel *sectionLabel = [[UILabel alloc] init];
	sectionLabel.frame = CGRectMake(0, 0, self.view.frame.size.width, 444);
	sectionLabel.textColor = [UIColor orangeColor];
	sectionLabel.text = [NSString stringWithFormat:@"组%d",section];
	sectionLabel.textAlignment = NSTextAlignmentCenter;
	sectionLabel.tag = 100 + section;
	sectionLabel.userInteractionEnabled = YES;
	sectionLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"itembg.png"]];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
	[sectionLabel addGestureRecognizer:tap];
	
	return sectionLabel;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *identify = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
	}
	cell.textLabel.text= [NSString stringWithFormat:@"第%d组的第%d个cell",indexPath.section,indexPath.row];
	cell.clipsToBounds = YES;//这句话很重要 不信你就试试
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	SectionViewController *sVC = [[SectionViewController alloc] init];
	sVC.rowLabelText = [NSString stringWithFormat:@"第%d组的第%d个cell",indexPath.section,indexPath.row];
	[self presentViewController:sVC animated:YES completion:nil];
}
- (void)sectionClick:(UITapGestureRecognizer *)tap{
	int index = tap.view.tag % 100;
	
	NSMutableArray *indexArray = [[NSMutableArray alloc]init];
	NSArray *arr = _sectionArray[index];
	for (int i = 0; i < arr.count; i ++) {
		NSIndexPath *path = [NSIndexPath indexPathForRow:i inSection:index];
		[indexArray addObject:path];
	}
	//展开
	if ([_flagArray[index] isEqualToString:@"0"]) {
		_flagArray[index] = @"1";
		[_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationBottom];  //使用下面注释的方法就 注释掉这一句
	} else { //收起
		_flagArray[index] = @"0";
		[_tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop]; //使用下面注释的方法就 注释掉这一句
	}
//	NSRange range = NSMakeRange(index, 1);
//	NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
//	[_tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end












































