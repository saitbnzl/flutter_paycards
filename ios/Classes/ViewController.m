#import "ViewController.h"
#import "PayCardsRecognizer.h"
#import "FlutterPaycardsPlugin.h"

@interface ViewController()<PayCardsRecognizerPlatformDelegate>
@end

@implementation ViewController{
    PayCardsRecognizer *_recognizer;
    FlutterPaycardsPlugin<PayCardsRecognizerPlatformDelegate> *delegate;
}

- (instancetype)initWitRecognizerDelegate:recognizerDelegate
{
    self = [super init];
    if (self) {
        delegate = recognizerDelegate;
    }
    return self;
}

-(void)vinitWithRecognizer:recognizer{
    _recognizer = recognizer;
}

- (void)viewDidLoad {
  [super viewDidLoad];
    _recognizer = [[PayCardsRecognizer alloc] initWithDelegate:delegate recognizerMode:PayCardsRecognizerDataModeNumber|PayCardsRecognizerDataModeName|PayCardsRecognizerDataModeDate resultMode:PayCardsRecognizerResultModeSync container:self.view frameColor:UIColor.cyanColor];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_recognizer startCamera];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_recognizer stopCamera];
}

- (void)payCardsRecognizer:(PayCardsRecognizer *)payCardsRecognizer didRecognize:(PayCardsRecognizerResult *)result{
    //[self dismissViewControllerAnimated:true completion:nil];
}
@end
