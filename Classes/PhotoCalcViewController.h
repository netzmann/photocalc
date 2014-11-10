/*
 
 File: MyViewController.h
 Abstract: A view controller responsible for managing the Hello World view.
 
 Version: 1.0
 
 */

#import <UIKit/UIKit.h>

@interface PhotoCalcScrollView : UIScrollView 

@property (nonatomic, strong) UIViewController* viewController;

@end

@interface PhotoCalcViewController : UIViewController <UITextFieldDelegate>

// Outlets
@property (nonatomic, strong) IBOutlet UITextField *text_format_x;
@property (nonatomic, strong) IBOutlet UITextField *text_format_y;
@property (nonatomic, strong) IBOutlet UITextField *text_brennweite;
@property (nonatomic, strong) IBOutlet UITextField *text_bildwinkel_x;
@property (nonatomic, strong) IBOutlet UITextField *text_bildwinkel_y;
@property (nonatomic, strong) IBOutlet UITextField *text_objekt_x;
@property (nonatomic, strong) IBOutlet UITextField *text_objekt_y;
@property (nonatomic, strong) IBOutlet UITextField *text_abstand;
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet PhotoCalcScrollView* scrollView;

@property (nonatomic, strong) UITextField *currentTextField;
@property (nonatomic, copy) NSString *string;

- (void)updateString;
- (void)updateDistanceWithAngle:(float)bildwinkel objectSize:(float)objekt;
- (void)updateSize;
- (void)updateAngleWithSensorFormat:(float)format textField:(UITextField *)bildwinkelTextField;

@end

