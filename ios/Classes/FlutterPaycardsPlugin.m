  #import "FlutterPaycardsPlugin.h"
#import <PayCardsRecognizer/PayCardsRecognizer.h>
#import "ViewController.h"

@interface FlutterPaycardsPlugin ()<PayCardsRecognizerPlatformDelegate>
@end

@implementation FlutterPaycardsPlugin{
    UIViewController *_viewController;
    ViewController *_pcViewController;
    FlutterResult _result;
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        _viewController = viewController;
    }
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_paycards"
            binaryMessenger:[registrar messenger]];
    UIViewController *viewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    FlutterPaycardsPlugin *instance = [[FlutterPaycardsPlugin alloc] initWithViewController:viewController];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"startRecognizer" isEqualToString:call.method]) {
      _pcViewController = [[ViewController alloc] initWithRecognizerDelegate:self withCancelLabel:call.arguments[@"cancelLabel"]];
      _result = result;
      if (@available(iOS 13, *)){
          //NSNumber *fullScreen = call.arguments[@"fullScreen"];
          UIModalPresentationStyle uiModalPresentationStyle = UIModalPresentationFullScreen;
          [_pcViewController setModalPresentationStyle:uiModalPresentationStyle];
          //NSLog(@"set fullscreen %d", (int)fullScreen);
      }
      [_viewController presentViewController:_pcViewController animated:true completion:^{
          NSLog(@"presentViewController completed");
      }];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)payCardsRecognizer:(PayCardsRecognizer *)payCardsRecognizer didRecognize:(PayCardsRecognizerResult *)result{
    NSLog(@"didRecognize %@ %@", result.recognizedNumber, result.recognizedExpireDateYear);
    [_pcViewController dismissViewControllerAnimated:true completion:nil];
    _result(@{
              @"cardHolderName": ObjectOrNull((result.recognizedHolderName)),
              @"cardNumber": ObjectOrNull(result.recognizedNumber),
              @"expiryMonth": ObjectOrNull(result.recognizedExpireDateMonth),
              @"expiryYear": ObjectOrNull(result.recognizedExpireDateYear)
              });
}

- (void)payCardsRecognizer:(PayCardsRecognizer *)payCardsRecognizer didCancel:(PayCardsRecognizerResult *)result{
    NSLog(@"didCancel %@ %@", result.recognizedNumber, result.recognizedExpireDateYear);
    [_pcViewController dismissViewControllerAnimated:true completion:nil];
}

static id ObjectOrNull(id object) {
    return object ?: [NSNull null];
}

@end
