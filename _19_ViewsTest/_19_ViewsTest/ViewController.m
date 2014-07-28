//
//  ViewController.m
//  _19_ViewsTest
//
//  Created by Exo-terminal on 4/9/14.
//  Copyright (c) 2014 Evgenia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) UIView* testView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIView* view1 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
    view1.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:0.8];
    [self.view addSubview:view1];
    
    UIView* view2 = [[UIView alloc]initWithFrame:CGRectMake(80, 80, 50, 250)];
    view2.backgroundColor = [[UIColor cyanColor]colorWithAlphaComponent:0.8];
    
    view2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleLeftMargin |
                              UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:view2];
    
    self.testView = view2;
    
    [self.view bringSubviewToFront:view1];
    
}
-(NSUInteger) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
//    NSLog(@"\nframe - %@\nbountes - %@", NSStringFromCGRect(self.testView.frame),NSStringFromCGRect(self.testView.bounds));
    NSLog(@"\nframe - %@\nbountes - %@", NSStringFromCGRect(self.view.frame),NSStringFromCGRect(self.view.bounds));

    CGPoint origin = CGPointZero;
    
    origin = [self.view convertPoint:origin toView:self.view.window];
    NSLog(@"origin - %@",NSStringFromCGPoint(origin));
    
    CGRect r = self.view.bounds;
    r.origin.y = 0;
    r.origin.x = CGRectGetWidth(r) - 100;
    r.size = CGSizeMake(100, 100);
    
    UIView* v = [[UIView alloc]initWithFrame:r];
    v.backgroundColor = [[UIColor blueColor]colorWithAlphaComponent:0.8];
    [self.view addSubview:v];
    
}
@end
