//
//  YHOCViewController.m
//  YHOCMonkey
//
//  Created by pencilCool on 12/11/2018.
//  Copyright (c) 2018 pencilCool. All rights reserved.
//

#import "YHOCViewController.h"
#import <UIKit/UIKit.h>
@interface YHOCViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mapView;
@end

@implementation YHOCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSURL *url = [NSURL URLWithString:@"https://www.google.com/maps"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    self.mapView.delegate = self;
    [self.mapView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
