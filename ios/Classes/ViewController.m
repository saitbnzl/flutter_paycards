#import "ViewController.h"
#import "FlutterPaycardsPlugin.h"
#import <PayCardsRecognizer/PayCardsRecognizer.h>
@interface ViewController()<PayCardsRecognizerPlatformDelegate>
@property (nonatomic, strong) UIButton *cancelButton;
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
    UIView *myView = [[UIView alloc] initWithFrame:self.view.bounds];
    myView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview: myView];
    if (@available(iOS 11, *)) {
        UILayoutGuide * guide = self.view.safeAreaLayoutGuide;
        [myView.leadingAnchor constraintEqualToAnchor:guide.leadingAnchor].active = YES;
        [myView.trailingAnchor constraintEqualToAnchor:guide.trailingAnchor].active = YES;
        [myView.topAnchor constraintEqualToAnchor:guide.topAnchor].active = YES;
        [myView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor].active = YES;
    } else {
        UILayoutGuide *margins = self.view.layoutMarginsGuide;
        [myView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
        [myView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
        [myView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor].active = YES;
        [myView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor].active = YES;
    }

    [self.view layoutIfNeeded];
    _recognizer = [[PayCardsRecognizer alloc] initWithDelegate:delegate recognizerMode:PayCardsRecognizerDataModeNumber|PayCardsRecognizerDataModeName|PayCardsRecognizerDataModeDate resultMode:PayCardsRecognizerResultModeSync container:myView frameColor:UIColor.cyanColor];
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
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)payCardsRecognizer:(PayCardsRecognizer *)payCardsRecognizer didCancel:(PayCardsRecognizerResult *)result{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(UIButton *)cancelButton {
    if (_cancelButton) {
        return _cancelButton;
    }
    [self.view addSubview:self.cancelButton];

    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:10];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.cancelButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:[UIScreen mainScreen].bounds.size.width];
    [self.view addConstraints:@[left, bottom]];
    [self.cancelButton addConstraints:@[height, width]];
    self.cancelButton.backgroundColor = UIColor.blackColor;
    self.cancelButton.alpha = 0.5;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName: [UIColor colorWithWhite:1 alpha:0.5], NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)};
    
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Cancel","") attributes:attributes];
    
    _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_cancelButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(tapCancel) forControlEvents:UIControlEventTouchUpInside];
    
    return _cancelButton;
}

- (void)tapCancel {
    NSLog(@"cancel");
}

@end
