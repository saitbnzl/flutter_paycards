#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (instancetype)initWithRecognizerDelegate:recognizerDelegate withCancelLabel:(NSString*)cancelLabel;
@end
