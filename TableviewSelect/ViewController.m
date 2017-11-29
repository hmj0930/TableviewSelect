//
//  ViewController.m
//  TableviewSelect
//
//  Created by MJ on 2017/11/29.
//  Copyright © 2017年 韩明静. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)NSArray *buttonsArr;

@end

@implementation ViewController

-(NSArray *)buttonsArr{
    
    if (_buttonsArr==nil) {
        
        NSMutableArray *tmp=[NSMutableArray array];
        
        for (int i=0; i<6; i++) {
            
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.tag=333+i;
            button.backgroundColor=[UIColor redColor];
            [button setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            button.selected=NO;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [tmp addObject:button];
        }
        _buttonsArr=[NSArray arrayWithArray:tmp];
    }
    return _buttonsArr;
}

-(void)buttonAction:(UIButton *)button{
    
    button.selected=!button.isSelected;
    
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:button.tag-333] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tableview.frame=self.view.frame;
    [self.view addSubview:self.tableview];
    
}

-(UITableView *)tableview{
    
    if (_tableview==nil) {
        _tableview=[UITableView new];
        _tableview.delegate=self;
        _tableview.dataSource=self;
    }
    return _tableview;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.buttonsArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    UIButton *button=self.buttonsArr[section];
    
    if (button.selected==YES) {
        return 1;
    }else{
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str=@"cellid";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.textLabel.text=[NSString stringWithFormat:@"第%li节",indexPath.section];
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIButton *button=self.buttonsArr[section];
    
    return button;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

@end
