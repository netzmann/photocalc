/*
 
 File: MyViewController.m
 Abstract: A view controller responsible for managing the Hello World view.
 
 Version: 1.0
 
 */

#import "PhotoCalcViewController.h"

@implementation PhotoCalcScrollView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.viewController touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

@end

@implementation PhotoCalcViewController

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasShown:)
												 name:UIKeyboardDidShowNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWillBeHidden:)
												 name:UIKeyboardWillHideNotification object:nil];
	
}

- (void)viewDidLoad {
    // When the user starts typing, show the clear button in the text field.
	self.text_format_x.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.text_format_y.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.text_brennweite.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.text_bildwinkel_x.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.text_bildwinkel_y.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.text_objekt_x.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.text_objekt_y.clearButtonMode = UITextFieldViewModeWhileEditing;
	self.text_abstand.clearButtonMode = UITextFieldViewModeWhileEditing;
	[self updateAngleWithSensorFormat:self.text_format_x.text.floatValue textField:self.text_bildwinkel_x];
	[self updateAngleWithSensorFormat:self.text_format_y.text.floatValue textField:self.text_bildwinkel_y];
	//self.scrollView.contentSize = CGSizeMake(320, 1000);
    self.scrollView.viewController = self;
	[self registerForKeyboardNotifications];
}


- (void)updateString {
	// Store the text of the text field in the 'string' instance variable.
	self.string = self.text_format_x.text;
}

- (void)updateDistanceWithAngle:(float)bildwinkel objectSize:(float)objekt {
	
	float alpha, abstand;
	
	alpha = bildwinkel*M_PI/360;
	abstand = (objekt/2)/sin(alpha)*cos(alpha);
	self.text_abstand.text = [NSString stringWithFormat:@"%.2f", abstand];
	[self updateSize];
	
}

- (void)updateSize {

	float alpha_x, alpha_y, objekt_x, objekt_y;
	alpha_x = self.text_bildwinkel_x.text.floatValue*M_PI/360; //  *Math.PI/360;
	objekt_x = 2*(self.text_abstand.text.floatValue/cos(alpha_x))*(sin(alpha_x)); ///Math.cos(alpha_x))*(Math.sin(alpha_x));
	alpha_y = self.text_bildwinkel_y.text.floatValue*M_PI/360; //*Math.PI/360;
	objekt_y = 2*(self.text_abstand.text.floatValue/cos(alpha_y))*(sin(alpha_y)); // /Math.cos(alpha_y))*(Math.sin(alpha_y));

	self.text_objekt_x.text = [NSString stringWithFormat:@"%.2f", objekt_x]; //Math.round(1000*objekt_x)/1000;
	self.text_objekt_y.text = [NSString stringWithFormat:@"%.2f", objekt_y]; // Math.round(1000*objekt_y)/1000;
	
}

- (void)updateAngleWithSensorFormat:(float)format textField:(UITextField *)bildwinkelTextField {

	float bildwinkel = 2*atan((format/(2*self.text_brennweite.text.floatValue)));
	bildwinkelTextField.text = [NSString stringWithFormat:@"%.2f", (180*bildwinkel/M_PI)];
	[self updateSize];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	if (![self.currentTextField.text length]) self.currentTextField.text = self.string;
	self.string = textField.text;
	self.currentTextField = textField;
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	// When the user presses return, take focus away from the text field so that the keyboard is dismissed.
	// *do it anyway, no matter which TextField* if (theTextField == textField) {
	if (![self.currentTextField.text length]) self.currentTextField.text = self.string;
		[theTextField resignFirstResponder];

	if (theTextField == self.text_format_x) {
		self.label.text = @"Format x geändert, Winkel und Größe berechnet";
		[self updateAngleWithSensorFormat:self.text_format_x.text.floatValue textField:self.text_bildwinkel_x];
	} else if (theTextField == self.text_format_y) {
		self.label.text = @"Format y geändert, Winkel und Größe berechnet";
		[self updateAngleWithSensorFormat:self.text_format_y.text.floatValue textField:self.text_bildwinkel_y];
	} else if (theTextField == self.text_brennweite) {
		self.label.text = @"Brennweite geändert, Winkel und Größe berechnet";
		[self updateAngleWithSensorFormat:self.text_format_x.text.floatValue textField:self.text_bildwinkel_x];
		[self updateAngleWithSensorFormat:self.text_format_y.text.floatValue textField:self.text_bildwinkel_y];
	} else if (theTextField == self.text_objekt_x) {
		self.label.text = @"Objektgröße x geändert, Abstand berechnet";
		[self updateDistanceWithAngle:self.text_bildwinkel_x.text.floatValue objectSize:self.text_objekt_x.text.floatValue];
	} else if (theTextField == self.text_objekt_y) {
		self.label.text = @"Objektgröße y geändert, Abstand berechnet";
		[self updateDistanceWithAngle:self.text_bildwinkel_y.text.floatValue objectSize:self.text_objekt_y.text.floatValue];
	} else if (theTextField == self.text_abstand) {
		self.label.text = @"Abstand geändert, Größe berechnet";
		[self updateSize];
	}

        // Invoke the method that changes the greeting.
        [self updateString];
	// *currently removed* }
	return YES;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (self.currentTextField.isFirstResponder) {
		// Dismiss the keyboard when the view outside the text field is touched.
		[self.currentTextField resignFirstResponder];
		// Revert the text field to the previous value.
		if (![self.currentTextField.text length]) self.currentTextField.text = self.string;
        // calculate
        else [self textFieldShouldReturn:self.currentTextField];
	}
    [super touchesBegan:touches withEvent:event];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
	
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, self.currentTextField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.currentTextField.frame.origin.y-kbSize.height);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
/*    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets; */
	[self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

@end
