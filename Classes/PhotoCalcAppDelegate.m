/*

File: PhotoCalcAppDelegate.m
Abstract: Responsible for creating the view controller and adding its view to
the window.
 
Version: 1.0

*/

#import "PhotoCalcAppDelegate.h"
#import "PhotoCalcViewController.h"


@implementation PhotoCalcAppDelegate

@synthesize window;
@synthesize myViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Set up the view controller
	PhotoCalcViewController *aViewController = [[PhotoCalcViewController alloc] initWithNibName:@"PhotoCalc" bundle:[NSBundle mainBundle]];
	self.myViewController = aViewController;
    
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
	
	// Add the view controller's view as a subview of the window
	UIView *controllersView = [myViewController view];
	[window addSubview:controllersView];
	[window makeKeyAndVisible];
}

@end
