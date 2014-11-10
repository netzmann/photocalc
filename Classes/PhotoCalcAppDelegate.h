/*

File: PhotoCalcAppDelegate.h
Abstract: Responsible for creating the view controller and adding its view to
the window.
 
Version: 1.0
*/

#import <UIKit/UIKit.h>

@class PhotoCalcViewController;

@interface PhotoCalcAppDelegate : NSObject <UIApplicationDelegate> {
	
	IBOutlet UIWindow* window;
	PhotoCalcViewController* myViewController;
}

@property (nonatomic, strong) UIWindow* window;
@property (nonatomic, strong) PhotoCalcViewController* myViewController;

@end
