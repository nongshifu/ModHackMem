//
//  DLGMemUIView.m
//  memui
//
//  Created by Liu Junqi on 11/11/2016.
//  by：十三哥 经过几天不断的努力终于将此源码完善。QQ350722326
//

#import "DLGMemUIView.h"
#import "DLGMemUIViewCell.h"
#import "SCLAlertView.h"
#import "NSObject+UI.h"
#import "NSObject+Menu.h"
#import <AdSupport/AdSupport.h>
#import <CommonCrypto/CommonCrypto.h>


#include <mach-o/dyld.h>


DLGMemValueType preType;

//搜索结果
#define MaxResultCount  50000



@interface DLGMemUIView () <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, DLGMemUIViewCellDelegate> {
    search_result_t *chainArray;
}

@property (nonatomic) UIButton *btnConsole;
@property (nonatomic) UITapGestureRecognizer *tapGesture;

@property (nonatomic) CGRect rcCollapsedFrame;
@property (nonatomic) CGRect rcExpandedFrame;

@property (nonatomic) UIView *vContent;
@property (nonatomic) UILabel *lblType;
@property (nonatomic) UIView *vSearch;
@property (nonatomic) UITextField *tfValue;
@property (nonatomic) UIButton *btnSearch;
@property (nonatomic) UIButton *lianheSearch;
@property (nonatomic) UIButton *fullgai;
@property (nonatomic) UIView *vOption;
@property (nonatomic) UISegmentedControl *scComparison;
@property (nonatomic) UISegmentedControl *scUValueType;
@property (nonatomic) UISegmentedControl *scSValueType;

@property (nonatomic) UIView *vResult;
@property (nonatomic) UILabel *lblResult;
@property (nonatomic) UITableView *tvResult;

@property (nonatomic) UIView *vMore;
@property (nonatomic) UIButton *btnReset;
@property (nonatomic) UIButton *btnMemory;
@property (nonatomic) UIButton *btnRefresh;

@property (nonatomic) UIView *vMemoryContent;
@property (nonatomic) UIView *vMemory;
@property (nonatomic) UITextField *tfMemorySize;
@property (nonatomic) UITextField *tfMemory;
@property (nonatomic) UIButton *btnSearchMemory;

@property (nonatomic) UITextView *tvMemory;
@property (nonatomic) UIButton *btnBackFromMemory;

@property (nonatomic, weak) UIView *vShowingContent;

@property (nonatomic) NSLayoutConstraint *lcUValueTypeTopMargin;

@property (nonatomic) BOOL isUnsignedValueType;
@property (nonatomic) NSInteger selectedValueTypeIndex;
@property (nonatomic) NSInteger selectedComparisonIndex;
@property (nonatomic, weak) UITextField *tfFocused;
@property (nonatomic)NSDictionary *dlgmemvalueKind;
@property (nonatomic,assign)NSInteger editIndex;

@property (nonatomic) BOOL tianxianareyouok;

@property (strong,nonatomic) NSArray<NSDictionary *>  *configs;
@end

@implementation DLGMemUIView



+ (instancetype)instance
{
    static DLGMemUIView *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DLGMemUIView alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initVars];
        [self initViews];
//        [self getFunctions];
    }
    return self;
}
 - (id )dictionaryWithJsonString:(NSString *)jsonString {
 
 if (jsonString == nil) {
 
 return nil;
 
 }
 
 NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
 
 NSError *err;
 
 id dic = [NSJSONSerialization JSONObjectWithData:jsonData
 
 options:NSJSONReadingMutableContainers
 
 error:&err];
 
 if(err) {
 
 //        NSLog(@"json解析失败：%@",err);
 
 return nil;
 
 }
 
 return dic;
 
 }
 
 - (void)getFunctions{
     [self expand];
     
 }


- (void)initVars {
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    self.rcExpandedFrame = screenBounds;
    self.rcCollapsedFrame = CGRectMake(0, 0, DLG_DEBUG_CONSOLE_VIEW_SIZE, DLG_DEBUG_CONSOLE_VIEW_SIZE);
    
    _shouldNotBeDragged = NO;
    _expanded = NO;
    self.isUnsignedValueType = NO;
    self.selectedValueTypeIndex = 2;
    self.selectedComparisonIndex = 2;
    self.tianxianareyouok   =   NO;
}

- (void)initViews {
    self.backgroundColor = [UIColor blackColor];//图标背景色
  //  self.backgroundColor = [UIColor clearColor];//图标背景色
    
    
    
    self.clipsToBounds = YES;
    
    self.frame = self.rcCollapsedFrame;
    self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2;
    self.layer.borderColor = [[UIColor purpleColor] CGColor];//图标边框颜色
    self.layer.borderWidth = 1.f;//图标边框大小
    [self initConsoleButton];
    [self initContents];
    [self initMemoryContents];
    self.vShowingContent = self.vContent;
}

- (void)buttonDragged:(UIButton *)button withEvent:(UIEvent *)event {
    UITouch *touch = [[event touchesForView:button] anyObject];
    
    CGPoint previousLocation = [touch previousLocationInView:button];
    CGPoint location = [touch locationInView:button];
    CGFloat delta_x = location.x - previousLocation.x;
    CGFloat delta_y = location.y - previousLocation.y;
    
    button.center = CGPointMake(button.center.x + delta_x, button.center.y + delta_y);
}


- (void)initConsoleButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"醉情" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:12]];
    [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];//图标颜色
    [self addSubview:button];
    NSDictionary *views = NSDictionaryOfVariableBindings(button);
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button]|"
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    [self addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|"
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    [self addConstraints:cv];
    [button addTarget:self action:@selector(onConsoleButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.btnConsole = button;
}

- (void)doExpand {
    [self expand];
}


- (void)doCollapse {
    [self collapse];
    self.btnConsole.hidden = NO;
    [self.tfValue resignFirstResponder];
}

#pragma mark - Init Content View
- (void)initContents {
    [self initContentView];
    [self initSearchView];
    [self initOptionView];
    [self initResultView];
    [self initMoreView];
    self.vContent.hidden = YES;
}

- (void)initContentView {
    UIView *v = [[UIView alloc] init];
    v.translatesAutoresizingMaskIntoConstraints = NO;
    v.backgroundColor = [UIColor clearColor];
    [self addSubview:v];
    
    NSDictionary *views = @{@"v":v};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v]|" options:0 metrics:nil views:views];
    [self addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v]|" options:0 metrics:nil views:views];
    [self addConstraints:cv];
    
    self.vContent = v;
}

#pragma mark - Init Search View
- (void)initSearchView {
    [self initSearchViewContainer];
    [self initNewSearchButton];
    [self initquangaiButton];
    [self initSearchValueType];
    [self initSearchButton];
    [self initSearchValueInput];
}


- (void)initSearchViewContainer {
    UIView *v = [[UIView alloc] init];
    v.translatesAutoresizingMaskIntoConstraints = NO;
    v.backgroundColor = [UIColor clearColor];
    [self.vContent addSubview:v];
    
    NSDictionary *views = @{@"v":v};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[v]-8-|" options:0 metrics:nil views:views];
    [self.vContent addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[v(32)]" options:0 metrics:nil views:views];
    [self.vContent addConstraints:cv];
    
    self.vSearch = v;
}
- (void)initSearchValueType {
    UILabel *lbl = [[UILabel alloc] init];
    lbl.translatesAutoresizingMaskIntoConstraints = NO;
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.textColor = [UIColor greenColor];
    lbl.text = @"类型";
    [self.vSearch addSubview:lbl];
    
    NSDictionary *views = @{@"lbl":lbl};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lbl(64)]" options:0 metrics:nil views:views];
    [self.vSearch addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lbl]|" options:0 metrics:nil views:views];
    [self.vSearch addConstraints:cv];
    
    self.lblType = lbl;
}
- (void)initSearchButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:@"精确搜索" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onSearchTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.vSearch addSubview:btn];
    
    NSDictionary *views = @{@"btn":btn};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[btn(64)]|" options:0 metrics:nil views:views];
    [self.vSearch addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn]|" options:0 metrics:nil views:views];
    [self.vSearch addConstraints:cv];
    
    self.btnSearch = btn;
}


- (void)initSearchValueInput {
    UITextField *tf = [[UITextField alloc] init];
    tf.translatesAutoresizingMaskIntoConstraints = NO;
    tf.delegate = self;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.backgroundColor = [UIColor whiteColor];
    tf.textColor = [UIColor blackColor];
    tf.placeholder = @"请输入您要搜索的值";
    tf.returnKeyType = UIReturnKeySearch;
    tf.keyboardType = UIKeyboardTypeDefault;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.spellCheckingType = UITextSpellCheckingTypeNo;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.enabled = YES;
    [self.vSearch addSubview:tf];
    
    NSDictionary *views = @{@"lianhe":self.lianheSearch,@"quangai":self.fullgai,@"lbl":self.lblType,@"btn":self.btnSearch, @"input":tf};
    
    
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[lbl]-2-[input]-1-[lianhe]-3-[quangai]-30-[btn]" options:0 metrics:nil views:views];
    [self.vSearch addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[input]|" options:0 metrics:nil views:views];
    [self.vSearch addConstraints:cv];
    
    
    self.tfValue = tf;
}

#pragma mark - Init Option View
- (void)initOptionView {
    [self initOptionViewContainer];
    [self initComparisonSegmentedControl];
    [self initUValueTypeSegmentedControl];
    [self initSValueTypeSegmentedControl];
}
//修改器主页面
- (void)initOptionViewContainer {
    UIView *v = [[UIView alloc] init];
    v.translatesAutoresizingMaskIntoConstraints = NO;
    v.backgroundColor = [UIColor clearColor];
    [self.vContent addSubview:v];
    
    NSDictionary *views = @{@"vv":self.vSearch, @"v":v};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[v]-8-|" options:0 metrics:nil views:views];
    [self addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[vv]-8-[v]" options:0 metrics:nil views:views];
    [self.vContent addConstraints:cv];
    
    self.vOption = v;
}

- (void)initComparisonSegmentedControl {
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:@[@"<", @"<=", @"=", @">=", @">"]];
    sc.translatesAutoresizingMaskIntoConstraints = NO;
    [sc setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateNormal];
    [sc setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
    sc.selectedSegmentIndex = 2;
    [sc addTarget:self action:@selector(onComparisonChanged:) forControlEvents:UIControlEventValueChanged];
    [self.vOption addSubview:sc];
    
    NSDictionary *views = @{@"sc":sc};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[sc]|" options:0 metrics:nil views:views];
    [self.vOption addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sc]" options:0 metrics:nil views:views];
    [self.vOption addConstraints:cv];
    
    self.scComparison = sc;
}

- (void)initUValueTypeSegmentedControl {
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:@[@"U8", @"U16", @"U32", @"U64", @"F32"]];
    sc.translatesAutoresizingMaskIntoConstraints = NO;
    [sc setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateNormal];
    [sc setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
    sc.selectedSegmentIndex = -1;
    sc.selected = NO;
    [sc addTarget:self action:@selector(onValueTypeChanged:) forControlEvents:UIControlEventValueChanged];
    [self.vOption addSubview:sc];
    
    NSDictionary *views = @{@"cmp":self.scComparison, @"sc":sc};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[sc]|" options:0 metrics:nil views:views];
    [self.vOption addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[cmp]-8-[sc]" options:0 metrics:nil views:views];
    [self.vOption addConstraints:cv];
    self.lcUValueTypeTopMargin = [cv firstObject];
    self.scUValueType = sc;
}

- (void)initSValueTypeSegmentedControl {
    UISegmentedControl *sc = [[UISegmentedControl alloc] initWithItems:@[@"I8", @"I16", @"I32", @"I64", @"F64"]];
    sc.translatesAutoresizingMaskIntoConstraints = NO;
    [sc setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateNormal];
    [sc setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
    sc.selectedSegmentIndex = 2;
    sc.selected = YES;
    [sc addTarget:self action:@selector(onValueTypeChanged:) forControlEvents:UIControlEventValueChanged];
    [self.vOption addSubview:sc];
    
    NSDictionary *views = @{@"usc":self.scUValueType, @"sc":sc};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[sc]|" options:0 metrics:nil views:views];
    [self.vOption addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[usc][sc]|" options:0 metrics:nil views:views];
    [self.vOption addConstraints:cv];
    
    self.scSValueType = sc;
}

#pragma mark - Init Result View
- (void)initResultView {
    [self initResultViewContainer];
    [self initResultLabel];
    [self initResultTableView];
}

- (void)initNewSearchButton {
    UIButton *lianhe = [UIButton buttonWithType:UIButtonTypeSystem];
    lianhe.translatesAutoresizingMaskIntoConstraints = NO;
    [lianhe setTitle:@"联合" forState:UIControlStateNormal];
    [lianhe setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [lianhe addTarget:self action:@selector(onSearch2Tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.vSearch addSubview:lianhe];
    NSDictionary *views = @{@"lianhe":lianhe};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[lianhe(40)]" options:0 metrics:nil views:views];
    [self.vSearch addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lianhe]|" options:0 metrics:nil views:views];
    [self.vSearch addConstraints:cv];
    self.lianheSearch = lianhe;
}
- (void)initquangaiButton {
    UIButton *quangai = [UIButton buttonWithType:UIButtonTypeSystem];
    quangai.translatesAutoresizingMaskIntoConstraints = NO;
    [quangai setTitle:@"全改" forState:UIControlStateNormal];
    
    [quangai setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [quangai addTarget:self action:@selector(onfullgaiTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.vSearch addSubview:quangai];
    NSDictionary *views = @{@"quangai":quangai};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[quangai(40)]" options:0 metrics:nil views:views];
    [self.vSearch addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[quangai]|" options:0 metrics:nil views:views];
    [self.vSearch addConstraints:cv];
    self.fullgai = quangai;
}



- (void)initResultViewContainer {
    UIView *v = [[UIView alloc] init];
    v.translatesAutoresizingMaskIntoConstraints = NO;
    v.backgroundColor = [UIColor clearColor];
    [self.vContent addSubview:v];
    
    NSDictionary *views = @{@"vv":self.vOption, @"v":v};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[v]-8-|" options:0 metrics:nil views:views];
    [self.vContent addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[vv]-8-[v]" options:0 metrics:nil views:views];
    [self.vContent addConstraints:cv];
    
    self.vResult = v;
}

- (void)initResultLabel {
    UILabel *lbl = [[UILabel alloc] init];
    lbl.translatesAutoresizingMaskIntoConstraints = NO;
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textAlignment = NSTextAlignmentLeft;
    lbl.textColor = [UIColor redColor];
    lbl.text = @"双指点击三次隐藏 QQ:630904094";
    [self.vResult addSubview:lbl];
    
    NSDictionary *views = @{@"lbl":lbl};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[lbl]|" options:0 metrics:nil views:views];
    [self.vResult addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[lbl]" options:0 metrics:nil views:views];
    [self.vResult addConstraints:cv];
    
    self.lblResult = lbl;
}


- (void)initResultTableView {
    UITableView * tv = [[UITableView alloc] init];
    tv.translatesAutoresizingMaskIntoConstraints = NO;
    tv.delegate = self;
    tv.dataSource = self;
    tv.backgroundColor = [UIColor clearColor];
    tv.separatorStyle = UITableViewCellSeparatorStyleNone;
    tv.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self.vResult addSubview:tv];
    
    NSDictionary *views = @{@"lbl":self.lblResult, @"tv":tv};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tv]|" options:0 metrics:nil views:views];
    [self.vResult addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[lbl]-8-[tv]|" options:0 metrics:nil views:views];
    [self.vResult addConstraints:cv];
    
    [tv registerClass:[DLGMemUIViewCell class] forCellReuseIdentifier:DLGMemUIViewCellID];
    self.tvResult = tv;
}

#pragma mark - Init More View
- (void)initMoreView {
    [self initMoreViewContainer];
    [self initResetButton];
    [self initRefreshButton];
    [self initMemoryButton];
}


- (void)initMoreViewContainer {
    UIView *v = [[UIView alloc] init];
    v.translatesAutoresizingMaskIntoConstraints = NO;
    v.backgroundColor = [UIColor clearColor];
    [self.vContent addSubview:v];
    
    NSDictionary *views = @{@"vv":self.vResult, @"v":v};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[v]-8-|" options:0 metrics:nil views:views];
    [self.vContent addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[vv]-8-[v(32)]|" options:0 metrics:nil views:views];
    [self.vContent addConstraints:cv];
    
    self.vMore = v;
}

- (void)initResetButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:@"重置" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onResetTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.vMore addSubview:btn];
    
    NSDictionary *views = @{@"btn":btn};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[btn(64)]" options:0 metrics:nil views:views];
    [self.vMore addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn]|" options:0 metrics:nil views:views];
    [self.vMore addConstraints:cv];
    
    self.btnReset = btn;
}

- (void)initRefreshButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:@"刷新" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onRefreshTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.vMore addSubview:btn];
    
    NSDictionary *views = @{@"btn":btn};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[btn(64)]|" options:0 metrics:nil views:views];
    [self.vMore addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn]|" options:0 metrics:nil views:views];
    [self.vMore addConstraints:cv];
    
    self.btnRefresh = btn;
}

- (void)initMemoryButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:@"查看教程" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onMemoryTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.vMore addSubview:btn];
    
    NSDictionary *views = @{@"reset":self.btnReset, @"btn":btn, @"refresh":self.btnRefresh};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[reset][btn][refresh]" options:0 metrics:nil views:views];
    [self.vMore addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn]|" options:0 metrics:nil views:views];
    [self.vMore addConstraints:cv];
    
    self.btnMemory = btn;
}

#pragma mark - Init Memory Content View
- (void)initMemoryContents {
    [self initMemoryContentView];
    [self initMemoryView];
    self.vMemoryContent.hidden = YES;
}

- (void)initMemoryContentView {
    UIView *v = [[UIView alloc] init];
    v.translatesAutoresizingMaskIntoConstraints = NO;
    v.backgroundColor = [UIColor clearColor];
    [self addSubview:v];
    
    NSDictionary *views = @{@"v":v};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[v]|" options:0 metrics:nil views:views];
    [self addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[v]|" options:0 metrics:nil views:views];
    [self addConstraints:cv];
    
    self.vMemoryContent = v;
}

#pragma mark - Init Memory View
- (void)initMemoryView {
    [self initMemoryViewContainer];
    [self initMemorySearchButton];
    [self initMemorySizeInput];
    [self initMemoryInput];
    [self initMemoryTextView];
    [self initBackFromMemoryButton];
}

- (void)initMemoryViewContainer {
    UIView *v = [[UIView alloc] init];
    v.translatesAutoresizingMaskIntoConstraints = NO;
    v.backgroundColor = [UIColor clearColor];
    [self.vMemoryContent addSubview:v];
    
    NSDictionary *views = @{@"v":v};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[v]-8-|" options:0 metrics:nil views:views];
    [self.vMemoryContent addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[v(32)]" options:0 metrics:nil views:views];
    [self.vMemoryContent addConstraints:cv];
    
    self.vMemory = v;
}

- (void)initMemorySearchButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor  redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onSearchMemoryTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.vMemory addSubview:btn];
    
    NSDictionary *views = @{@"btn":btn};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[btn(64)]|" options:0 metrics:nil views:views];
    [self.vMemory addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[btn]|" options:0 metrics:nil views:views];
    [self.vMemory addConstraints:cv];
    
    self.btnSearchMemory = btn;
}

- (void)initMemorySizeInput {
    UITextField *tf = [[UITextField alloc] init];
    tf.translatesAutoresizingMaskIntoConstraints = NO;
    tf.delegate = self;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.backgroundColor = [UIColor redColor];
    tf.textColor = [UIColor blackColor];
    tf.text = @"1024";
    tf.placeholder = @"Size";
    tf.returnKeyType = UIReturnKeyNext;
    tf.keyboardType = UIKeyboardTypeDefault;
    tf.clearButtonMode = UITextFieldViewModeNever;
    tf.spellCheckingType = UITextSpellCheckingTypeNo;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.enabled = YES;
    [self.vMemory addSubview:tf];
    
    NSDictionary *views = @{@"tf":tf};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tf(64)]" options:0 metrics:nil views:views];
    [self.vMemory addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tf]|" options:0 metrics:nil views:views];
    [self.vMemory addConstraints:cv];
    
    self.tfMemorySize = tf;
}

- (void)initMemoryInput {
    UITextField *tf = [[UITextField alloc] init];
    tf.translatesAutoresizingMaskIntoConstraints = NO;
    tf.delegate = self;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.backgroundColor = [UIColor redColor];
    tf.textColor = [UIColor blackColor];
    tf.text = @"0";
    tf.placeholder = @"Enter the address";
    tf.returnKeyType = UIReturnKeySearch;
    tf.keyboardType = UIKeyboardTypeDefault;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.spellCheckingType = UITextSpellCheckingTypeNo;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    tf.autocorrectionType = UITextAutocorrectionTypeNo;
    tf.enabled = YES;
    [self.vMemory addSubview:tf];
    
    NSDictionary *views = @{@"sz":self.tfMemorySize, @"tf":tf, @"btn":self.btnSearchMemory};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[sz]-8-[tf][btn]" options:0 metrics:nil views:views];
    [self.vMemory addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tf]|" options:0 metrics:nil views:views];
    [self.vMemory addConstraints:cv];
    
    self.tfMemory = tf;
}

- (void)initMemoryTextView {
    UITextView *tv = [[UITextView alloc] init];
    tv.translatesAutoresizingMaskIntoConstraints = NO;
    tv.font = [UIFont fontWithName:@"Courier New" size:12];
    tv.backgroundColor = [UIColor clearColor];
    tv.textColor = [UIColor redColor];
    tv.textAlignment = NSTextAlignmentCenter;
    tv.editable = NO;
    tv.selectable = YES;
    [self.vMemoryContent addSubview:tv];
    tv.text =@
    "使用教程：联合搜索\n\n比如:搜索F32 8888联合1，1改9999，\n修改器选择F32 输入框输入8888，按(精确搜索)按钮，等待出结果后 \n输入框输入1 按(联合)按钮 等出结果 此时列表里有8888和1的内存 \n然后 输入框输入1 按(精确搜索)按钮就可以筛选出1， 输入框输入9999按(全改)即可\n\n联合搜索可以联合N个 不限次数 一般联合1~3个即可找到结果\n联合搜索适用于较小的数值比如1 搜索结果可能上亿个 所以只能先搜索它附近较大的值 再联合找到它使用\n\n教程：精确搜索\n 如：F64 8888改9999999 \n 输入框输入8888选择F64格式格式，按按(精确搜索)按钮 \n出结果后 输入框输入9999999 按(全改)即可\n\n 有时候精确搜索结果可能太多无法修改或则修改闪退\n 比如以上搜索金币值8888出很多结果无法修改\n此时游戏里花掉金币或则领取金币让值改变\n比如花掉8金币 变成8880\n在当前8888搜索结果输入框输入8880\n 按（精确搜索）结果变少按（全改）即可 \n如果还是太多就再花掉/获得金币 再精确搜新的j值 全改即可";
    NSDictionary *views = @{@"v":self.vMemory, @"tv":tv};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tv]|" options:0 metrics:nil views:views];
    [self.vMemoryContent addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[v]-8-[tv]" options:0 metrics:nil views:views];
    [self.vMemoryContent addConstraints:cv];
    
    self.tvMemory = tv;
}

- (void)initBackFromMemoryButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBackFromMemoryTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.vMemoryContent addSubview:btn];
    
    NSDictionary *views = @{@"tv":self.tvMemory, @"btn":btn};
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[btn]|" options:0 metrics:nil views:views];
    [self.vMemoryContent addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[tv][btn(32)]|" options:0 metrics:nil views:views];
    [self.vMemoryContent addConstraints:cv];
    
    self.btnBackFromMemory = btn;
}

#pragma mark - Setter / Getter
- (void)setChainCount:(NSInteger)chainCount {
    _chainCount = chainCount;
    self.lblResult.text = [NSString stringWithFormat:@"搜到 %lld.", (long long)chainCount];
    if (chainCount > 0) {
        
    } else {
        self.lcUValueTypeTopMargin.constant = 8;
        self.scUValueType.hidden = NO;
        self.scSValueType.hidden = NO;
    }
}
- (void)editWith:(search_result_t)result{
    NSString *address = [NSString stringWithFormat:@"%llX", result->address];
    if ([self.delegate respondsToSelector:@selector(DLGMemUISearchValue:type:comparison:)] || [self.delegate respondsToSelector:@selector(DLGMemUINearMemSearch:type:range:)]) {
        DLGMemValueType type = [self.dlgmemvalueKind[@"valueType"][self.editIndex]integerValue];
        if ([self.dlgmemvalueKind[@"editValue"][self.editIndex] length] == 0) {
            NSLog(@"editvaule is NULL");
            return;
        }
        [self.delegate DLGMemUIModifyValue:self.dlgmemvalueKind[@"editValue"][self.editIndex] address:address type:type];
    }
}
- (void)editWithss:(search_result_t)result{
    [self.tfValue resignFirstResponder];
    NSString *value =self.tfValue.text;
    NSString *address = [NSString stringWithFormat:@"%llX", result->address];
    if ([self.delegate respondsToSelector:@selector(DLGMemUISearchValue:type:comparison:)] || [self.delegate respondsToSelector:@selector(DLGMemUINearMemSearch:type:range:)]){
        if(value.length == 0)return;
        DLGMemValueType type = [self currentValueType];
        [self.delegate DLGMemUIModifyValue:value address:address type:type];
    }
}

- (void)setChain:(search_result_chain_t)chain {
    _chain = chain;
    if (chainArray) {
        free(chainArray);
        chainArray = NULL;
    }
    
    if (self.chainCount > 0 && self.chainCount <= MaxResultCount) {
        chainArray = malloc(sizeof(search_result_t) * self.chainCount);
        search_result_chain_t c = chain;
        int i = 0;
        while (i < self.chainCount) {
            if (c->result) chainArray[i++] = c->result;
            c = c->next;
            if (c == NULL) break;
        }
        if (i < self.chainCount) self.chainCount = i;
    }
    if (chainArray==NULL) {
        return;
    }
    
    
    
    ///////////////////////////////////功能代码 代码修改在这里 这里开始修改为代码/////////////////////////////////
    ////////////////////////一段代码修改开始////////////////////////
    
    if (self.dlgmemvalueKind==DLGMemValueTypexiugaiqi)
    {
        [self.tvResult reloadData];
        return;
    }
    
    if ([self.dlgmemvalueKind[@"editValue"][self.editIndex] isEqualToString:@"no"]) {
        self.editIndex++;
        [self actionWithModel:self.dlgmemvalueKind];
        return;
    }
    
    if ([self.dlgmemvalueKind[@"range"][self.editIndex] isEqualToString:@"all" ] ) {//全部修改
        for (int index=0; index<self.chainCount; index++)
        {
            search_result_t result = chainArray[index];
            [self editWith:result];
        }
    }else {//有范围
        NSArray *arr = [self.dlgmemvalueKind[@"range"][self.editIndex] componentsSeparatedByString:@"&&"];
        search_result_t * temp = malloc(sizeof(search_result_t) * self.chainCount);
        NSInteger count = 0;
        for (NSString *rang in arr) {
            NSArray *rang1 = [rang componentsSeparatedByString:@"-"];
            if (rang1.count==2) {
                //范围
                NSInteger max = MIN([rang1[1] integerValue],count>0?count:self.chainCount);
                
                if ([rang1[0] integerValue]>=0) {
                    for (NSInteger index=[rang1[0] integerValue]-1; index<max; index++)
                    {
                        if (count>0) {
                            search_result_t result = temp[index];
                            [self editWith:result];
                        }else{
                            search_result_t result = chainArray[index];
                            [self editWith:result];
                        }
                        
                    }
                }else{
                    for (NSInteger index=1; index<max; index++)
                    {
                        if (count>0) {
                            search_result_t result = temp[count-index];
                            [self editWith:result];
                        }else{
                            search_result_t result = chainArray[self.chainCount-index];
                            [self editWith:result];
                        }
                    }
                }
                
            }else if(rang1.count==1){
                //匹配
                if ([rang1[0] containsString:@"m"]) {
                    NSString *m = [rang1[0] substringFromIndex:1];
                    
                    
                    for (int index=0; index<self.chainCount; index++)
                    {
                        search_result_t result = chainArray[index];
                        NSString *address = [NSString stringWithFormat:@"%llx", result->address];
                        if ([address containsString:m]) {
                            
                            if (arr.count==1) {
                                [self editWith:result];
                            }else{
                                temp[count] = result;
                                count++;
                            }
                        }
                    }
                }
                if ([rang1[0] containsString:@"w"]){
                    NSString *w = [rang1[0] substringFromIndex:1];
                    for (int index=0; index<self.chainCount; index++)
                    {
                        search_result_t result = chainArray[index];
                        NSString *address = [NSString stringWithFormat:@"%llX", result->address];
                        
                        if ([[address substringFromIndex:address.length-w.length] isEqualToString:w]) {
                            
                            if (arr.count==1) {
                                [self editWith:result];
                            }else{
                                temp[count] = result;
                                count++;
                            }
                        }
                    }
                }
                
            }
        }
        
        free(temp);
    }
    if ([self.delegate respondsToSelector:@selector(DLGMemUIReset)]) {
        [self.delegate DLGMemUIReset];
    }
    
    if (self.editIndex<[self.dlgmemvalueKind[@"range"] count]-1) {
        self.editIndex++;
        [self actionWithModel:self.dlgmemvalueKind];
        
    }
    
}
- (void)gogo {
    _shouldNotBeDragged = YES;
    CGRect frame = self.rcCollapsedFrame;
    frame.origin = self.frame.origin;
    self.rcCollapsedFrame = frame;
    self.btnConsole.hidden = YES;
    self.layer.cornerRadius = 0;
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.frame = self.rcExpandedFrame;
                         self.alpha = DLG_DEBUG_CONSOLE_VIEW_MAX_ALPHA;
                     }
                     completion:^(BOOL finished) {
                         self.frame = self.rcExpandedFrame;
                         self.alpha = DLG_DEBUG_CONSOLE_VIEW_MAX_ALPHA;
                         self.vShowingContent.hidden = NO;
                         self->_expanded = YES;
                     }];
    
    [self addGesture];
}





#pragma mark - Gesture
- (void)addGesture {
    if (self.tapGesture != nil) return;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
    self.tapGesture = tap;
}

- (void)removeGesture {
    if (self.tapGesture == nil) { return; }
    
    [self removeGestureRecognizer:self.tapGesture];
    self.tapGesture = nil;
}

#pragma mark - Events
- (void)onSearchTapped:(id)sender {
    [self.tfValue resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(DLGMemUISearchValue:type:comparison:)]) {
        NSString *value = self.tfValue.text;
        if (value.length == 0) return;
        DLGMemValueType type;
        if ((_chain == NULL)||(preType == NULL)) {
            type = [self currentValueType];
            preType = type;
        }else{
            type = preType;
        }
        
        DLGMemComparison comparison = [self currentComparison];
        switch (self.selectedComparisonIndex) {
            case 0: comparison = DLGMemComparisonLT; break;
            case 1: comparison = DLGMemComparisonLE; break;
            case 2: comparison = DLGMemComparisonEQ; break;
            case 3: comparison = DLGMemComparisonGE; break;
            case 4: comparison = DLGMemComparisonGT; break;
        }
        
        
        [self.delegate DLGMemUISearchValue:value type:type comparison:comparison];
    }
}


- (void)onResetTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(DLGMemUIReset)]) {
        [self.delegate DLGMemUIReset];
    }
}
- (void)onRefreshTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(DLGMemUIRefresh)]) {
        [self.delegate DLGMemUIRefresh];
    }
}

- (void)onMemoryTapped:(id)sender {
    if (self.tvMemory.text.length == 0) {
        [self showMemory:self.tfMemory.text];
    } else {
        [self showMemory];
    }
}

- (void)onComparisonChanged:(id)sender {
    self.selectedComparisonIndex = self.scComparison.selectedSegmentIndex;
}

- (void)onValueTypeChanged:(id)sender {
    BOOL isUnsigned = (sender == self.scUValueType);
    UISegmentedControl *sc = isUnsigned ? self.scUValueType : self.scSValueType;
    UISegmentedControl *sc2 = isUnsigned ? self.scSValueType : self.scUValueType;
    sc.selected = YES;
    sc2.selected = NO;
    sc2.selectedSegmentIndex = -1;
    self.isUnsignedValueType = isUnsigned;
    self.selectedValueTypeIndex = sc.selectedSegmentIndex;
    self.lblType.text = [self stringFromValueType:[self currentValueType]];
}

- (void)onSearchMemoryTapped:(id)sender {
    [self.tfMemory resignFirstResponder];
    [self.tfMemorySize resignFirstResponder];
    NSString *address = self.tfMemory.text;
    NSString *size = self.tfMemorySize.text;
    if (address.length == 0) return;
    if ([self.delegate respondsToSelector:@selector(DLGMemUIMemory:size:)]) {
        NSString *memory = [self.delegate DLGMemUIMemory:address size:size];
        self.tvMemory.text = memory;
    }
}

- (void)onSearch2Tapped:(id)sender {
    [self.tfValue resignFirstResponder];
    if([self.delegate respondsToSelector:@selector(DLGMemUINearMemSearch:type:range:)]){
        NSString *value =self.tfValue.text;
        if(value.length == 0)return;
        DLGMemValueType type = [self currentValueType];
        //联合范围
        [self.delegate DLGMemUINearMemSearch:value type:type range:50];
        
    }
}

- (void)onfullgaiTapped:(id)sender {
    for (int index=0; index<self.chainCount; index++)
    {
        search_result_t result = chainArray[index];
        [self editWithss:result];
    }
    [self.delegate DLGMemUIRefresh];
}

- (void)onBackFromMemoryTapped:(id)sender {
    self.vMemoryContent.hidden = YES;
    self.vContent.hidden = NO;
    self.vShowingContent = self.vContent;
    self.tvMemory.text = @"";
}

- (void)showMemory {
    self.vContent.hidden = YES;
    self.vMemoryContent.hidden = NO;
    self.vShowingContent = self.vMemoryContent;
}

- (void)showMemory:(NSString *)address {
    [self showMemory];
    self.tfMemory.text = address;
    self.tvMemory.text = @"";
    [self onSearchMemoryTapped:nil];
}

- (void)onConsoleButtonTapped:(id)sender {
    //测试图标
    [self doExpand];
    
}
- (NSMutableString *)encryptMd5:(NSString *)origingString{
    //md5加密
    const char *cStr = [origingString UTF8String];
    unsigned char digest[16];
    
    CC_MD5( cStr,(CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    //加密成md5的字符串
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    NSLog(@"output=====%@",output);
    return output;
}

#pragma mark - Expand & Collapse

- (void)actionWithModel:(NSDictionary *)model{
    
    if ([self.delegate respondsToSelector:@selector(DLGMemUISearchValue:type:comparison:)] || [self.delegate respondsToSelector:@selector(DLGMemUINearMemSearch:type:range:)]) {
        
        self.dlgmemvalueKind    =  model;
        
        NSString *value =  model[@"searchValue"][self.editIndex];
        
        if (value.length == 0) return;
        
        NSString *searchType =  model[@"searchType"][self.editIndex];
        
        
        DLGMemValueType type = [model[@"valueType"][self.editIndex] integerValue];
        DLGMemComparison comparison = DLGMemComparisonEQ;
        if ([searchType isEqualToString:@"near"]) {//near n联合
            [self.delegate DLGMemUINearMemSearch:value type:type range:55];//联合范围
            
        }else{
             dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self.delegate DLGMemUISearchValue:value type:type comparison:comparison];
            });
        }
    }
}
//越狱秒改
//-(void)kais:(uint64_t)address bt:(NSString *)Bytes{
//    NSString *value = [NSString stringWithFormat:@"%ld",strtoul([Bytes UTF8String],0,16)];
//    uint64_t ASLR = address + _dyld_get_image_vmaddr_slide(0);
//    NSString *addressx = [NSString stringWithFormat:@"%0llx",ASLR];
//    if ([self.delegate respondsToSelector:@selector(DLGMemUIModifyValue:address:type:)]) {
//        [self.delegate DLGMemUIModifyValue:value address:addressx type:6];
//    }
//}
//菜单解析

 - (void)expand {
     self.dlgmemvalueKind=DLGMemValueTypexiugaiqi;
     [self gogo];
 }

//总带单取消按钮结束////
- (void)collapse {
    // _shouldNotBeDragged = NO;
    CGRect frame = self.rcExpandedFrame;
    frame.origin = self.frame.origin;
    self.rcExpandedFrame = frame;
    self.layer.cornerRadius = CGRectGetWidth(self.rcCollapsedFrame) / 2;
    self.vShowingContent.hidden = YES;
    [self.tfFocused resignFirstResponder];
    [self removeGesture];
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.frame = self.rcCollapsedFrame;
                         self.alpha = DLG_DEBUG_CONSOLE_VIEW_MIN_ALPHA;
                     }
                     completion:^(BOOL finished) {
                         self.frame = self.rcCollapsedFrame;
                         self.alpha = DLG_DEBUG_CONSOLE_VIEW_MIN_ALPHA;
                         self->_expanded = NO;
                     }];
}

#pragma mark - Gesture

- (void)handleGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint pt = [sender locationInView:self.window];
        CGRect frameInScreen = self.tfValue.frame;
        frameInScreen.origin.x += CGRectGetMinX(self.frame);
        frameInScreen.origin.y += CGRectGetMinY(self.frame);
        if (CGRectContainsPoint(frameInScreen, pt)) {
            if ([self.tfValue canBecomeFirstResponder]) {
                [self.tfValue becomeFirstResponder];
            }
        } else {
            [self doCollapse];
        }
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.tfValue) {
        if (textField.returnKeyType == UIReturnKeySearch) {
            [self onSearchTapped:nil];
        }
    } else if (textField == self.tfMemory) {
        if (textField.returnKeyType == UIReturnKeySearch) {
            [self onSearchMemoryTapped:nil];
        }
    } else if (textField == self.tfMemorySize) {
        if (textField.returnKeyType == UIReturnKeyNext) {
            [self.tfMemory becomeFirstResponder];
        }
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.tfFocused = textField;
}

#pragma mark - UITableViewDataSource

- (NSUInteger)memTypeFromSearchResultType:(int)type {
    switch (type) {
        case SearchResultValueTypeUInt8: return DLGMemValueTypeUnsignedByte;
        case SearchResultValueTypeSInt8: return DLGMemValueTypeSignedByte;
        case SearchResultValueTypeUInt16: return DLGMemValueTypeUnsignedShort;
        case  SearchResultValueTypeSInt16: return DLGMemValueTypeSignedShort;
        case  SearchResultValueTypeUInt32: return DLGMemValueTypeUnsignedInt;
        case  SearchResultValueTypeSInt32: return DLGMemValueTypeSignedInt;
        case  SearchResultValueTypeUInt64: return DLGMemValueTypeUnsignedLong;
        case  SearchResultValueTypeSInt64: return DLGMemValueTypeSignedLong;
        case  SearchResultValueTypeFloat: return DLGMemValueTypeFloat;
        case  SearchResultValueTypeDouble: return DLGMemValueTypeDouble;
        default: return DLGMemValueTypeSignedInt;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.chainCount > MaxResultCount) return 0;
    return self.chainCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return DLGMemUIViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DLGMemUIViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DLGMemUIViewCellID forIndexPath:indexPath];
    cell.delegate = self;
    cell.textFieldDelegate = self;
    
    NSInteger index = indexPath.row;
    search_result_t result = chainArray[index];
    NSString *address = [NSString stringWithFormat:@"%llX", result->address];
    int type = result->type;
    NSString *value = [self valueStringFromResult:result];
    cell.address = address;
    cell.Type = [self memTypeFromSearchResultType:type];
    cell.value = value;
    cell.modifying = NO;
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger index = indexPath.row;
    search_result_t result = chainArray[index];
    NSString *address = [NSString stringWithFormat:@"%llX", result->address];
    [self showMemory:address];
}

#pragma mark - DLGMemUIViewCellDelegate
- (void)DLGMemUIViewCellModify:(NSString *)address value:(NSString *)value type:(int)type{
    if ([self.delegate respondsToSelector:@selector(DLGMemUIModifyValue:address:type:)]) {
        
        [self.delegate DLGMemUIModifyValue:value address:address type:type];
    }
}

- (void)DLGMemUIViewCellViewMemory:(NSString *)address {
    [self showMemory:address];
}

#pragma mark - Utils
- (NSString *)valueStringFromResult:(search_result_t)result {
    NSString *value = nil;
    int type = result->type;
    if (type == SearchResultValueTypeUInt8) {
        uint8_t v = *(uint8_t *)(result->value);
        value = [NSString stringWithFormat:@"%u", v];
    } else if (type == SearchResultValueTypeSInt8) {
        int8_t v = *(int8_t *)(result->value);
        value = [NSString stringWithFormat:@"%d", v];
    } else if (type == SearchResultValueTypeUInt16) {
        uint16_t v = *(uint16_t *)(result->value);
        value = [NSString stringWithFormat:@"%u", v];
    } else if (type == SearchResultValueTypeSInt16) {
        int16_t v = *(int16_t *)(result->value);
        value = [NSString stringWithFormat:@"%d", v];
    } else if (type == SearchResultValueTypeUInt32) {
        uint32_t v = *(uint32_t *)(result->value);
        value = [NSString stringWithFormat:@"%u", v];
    } else if (type == SearchResultValueTypeSInt32) {
        int32_t v = *(int32_t *)(result->value);
        value = [NSString stringWithFormat:@"%d", v];
    } else if (type == SearchResultValueTypeUInt64) {
        uint64_t v = *(uint64_t *)(result->value);
        value = [NSString stringWithFormat:@"%llu", v];
    } else if (type == SearchResultValueTypeSInt64) {
        int64_t v = *(int64_t *)(result->value);
        value = [NSString stringWithFormat:@"%lld", v];
    } else if (type == SearchResultValueTypeFloat) {
        float v = *(float *)(result->value);
        value = [NSString stringWithFormat:@"%f", v];
    } else if (type == SearchResultValueTypeDouble) {
        double v = *(double *)(result->value);
        value = [NSString stringWithFormat:@"%f", v];
    } else {
        NSMutableString *ms = [NSMutableString string];
        char *v = (char *)(result->value);
        for (int i = 0; i < result->size; ++i) {
            printf("%02X ", v[i]);
            [ms appendFormat:@"%02X ", v[i]];
        }
        value = ms;
    }
    return value;
}

- (DLGMemValueType)currentValueType {
    DLGMemValueType type = DLGMemValueTypeSignedInt;
    switch (self.selectedValueTypeIndex) {
        case 0: type = self.isUnsignedValueType ? DLGMemValueTypeUnsignedByte : DLGMemValueTypeSignedByte; break;
        case 1: type = self.isUnsignedValueType ? DLGMemValueTypeUnsignedShort : DLGMemValueTypeSignedShort; break;
        case 2: type = self.isUnsignedValueType ? DLGMemValueTypeUnsignedInt : DLGMemValueTypeSignedInt; break;
        case 3: type = self.isUnsignedValueType ? DLGMemValueTypeUnsignedLong : DLGMemValueTypeSignedLong; break;
        case 4: type = self.isUnsignedValueType ? DLGMemValueTypeFloat : DLGMemValueTypeDouble; break;
    }
    return type;
}

- (DLGMemComparison)currentComparison {
    DLGMemComparison comparison = DLGMemComparisonEQ;
    switch (self.selectedComparisonIndex) {
        case 0: comparison = DLGMemComparisonLT; break;
        case 1: comparison = DLGMemComparisonLE; break;
        case 2: comparison = DLGMemComparisonEQ; break;
        case 3: comparison = DLGMemComparisonGE; break;
        case 4: comparison = DLGMemComparisonGT; break;
    }
    return comparison;
}

- (NSString *)stringFromValueType:(DLGMemValueType)type {
    switch (type) {
        case DLGMemValueTypeUnsignedByte: return @"U8";
        case DLGMemValueTypeSignedByte: return @"I8";
        case DLGMemValueTypeUnsignedShort: return @"U16";
        case DLGMemValueTypeSignedShort: return @"I16";
        case DLGMemValueTypeUnsignedInt: return @"U32";
        case DLGMemValueTypeSignedInt: return @"I32";
        case DLGMemValueTypeUnsignedLong: return @"U64";
        case DLGMemValueTypeSignedLong: return @"I64";
        case DLGMemValueTypeFloat: return @"F32";
        case DLGMemValueTypeDouble: return @"F64";
        default: return @"--";
    }
}

@end
