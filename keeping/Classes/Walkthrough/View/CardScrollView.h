//
//  CardScrollView.h
//  GCCardViewController
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CardMoveDirection) {
    CardMoveDirectionNone,
    CardMoveDirectionLeft,
    CardMoveDirectionRight
};

@protocol CardScrollViewDataSource <NSObject>

- (NSInteger)numberOfCards;
- (UIView *)cardReuseView:(UIView *)reuseView atIndex:(NSInteger)index;
@optional
- (void)deleteCardWithIndex:(NSInteger)index;

@end

@protocol CardScrollViewDelegate <NSObject>

- (void)updateCard:(UIView *)card withProgress:(CGFloat)progress direction:(CardMoveDirection)direction;

@end

@interface CardScrollView : UIView

@property (nonatomic, weak) id<CardScrollViewDataSource>cardDataSource;
@property (nonatomic, weak) id<CardScrollViewDelegate>cardDelegate;
@property (nonatomic, assign) BOOL canDeleteCard;

- (void)loadCard;
- (NSArray *)allCards;
- (NSInteger)currentCard;

@end
