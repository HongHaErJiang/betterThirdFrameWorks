//
//  ViewController.m
//  LSPaomaView
//
//  Created by Sen on 15/8/1.
//  Copyright (c) 2015年 Sen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString* text = @"两块钱,你买不了吃亏,两块钱,你买不了上当,真正的物有所值,拿啥啥便宜,买啥啥不贵,都两块,买啥都两块,全场卖两块,随便挑,随便选,都两块！";
    
    LSPaoMaView* paomav = [[LSPaoMaView alloc] initWithFrame:CGRectMake(10, 64, self.view.bounds.size.width-20, 44) title:text];
    [self.view addSubview:paomav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
