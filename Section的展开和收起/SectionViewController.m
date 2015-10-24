//
//  SectionViewController.m
//  Section的展开和收起
//
//  Created by HGDQ on 15/10/24.
//  Copyright (c) 2015年 HGDQ. All rights reserved.
//

#import "SectionViewController.h"

@interface SectionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *rowLabel;

@end

@implementation SectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	//设置显示
	self.rowLabel.text = self.rowLabelText;
    // Do any additional setup after loading the view from its nib.
}
//返回上一页
- (IBAction)backButton:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
