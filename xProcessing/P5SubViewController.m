//
//  P5SubViewController.m
//  xProcessing
//
//  Created by n_ryota on 13/5/5.
//  Copyright (c) 2012 n_ryota. All rights reserved.
//

#import "P5SubViewController.h"

@interface P5SubViewController ()

@end

@implementation P5SubViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
