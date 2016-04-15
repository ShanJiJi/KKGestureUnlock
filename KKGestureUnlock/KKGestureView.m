//
//  KKGestureView.m
//  KKGestureLock
//
//  Created by 珍玮 on 16/4/15.
//  Copyright © 2016年 ZhenWei. All rights reserved.
//

#import "KKGestureView.h"

@interface KKGestureView (){
    
    NSMutableArray *_gestureButtonArr;//存放选中的按钮
    CGPoint _gestureLastPoint;//手指移动的点
    
}

@end

@implementation KKGestureView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        [self configLockButtonUI];
        
        _gestureButtonArr = [NSMutableArray array];
        
    }
    return self;
    
}

//创建解锁的按钮界面
-(void)configLockButtonUI{
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    CGFloat X = 10;
    
    CGFloat Y = 10;
    
    CGFloat cutOff = 10;
    
    CGFloat btnWidth = (rect.size.width - 4 * X)/3;
    
    CGFloat btnHeight = btnWidth;
    //创建按钮
    for (int i = 0; i < 9; i ++) {
        
        UIButton *btn = [UIButton buttonWithType:0];
        
        btn.frame = CGRectMake(X,Y, btnWidth, btnHeight);
        btn.tag = i + 1;
        //设置按钮默认状态图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        
        //设置按钮选中状态图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        //禁止用户编辑按钮
        [btn setUserInteractionEnabled:NO];
        
        [self addSubview:btn];
        
        X += btnWidth + cutOff;
        
        if (X >= rect.size.width) {
            X = 10;
            Y += btnHeight + cutOff;
        }
        
//        NSLog(@"i == %d,X---%f,Y---%f",i,X,Y);
    }
    
}

//得到手指触摸点
-(CGPoint)pointWithTouches:(NSSet *)touches{
    
    //触摸事件
    UITouch *touch = [touches anyObject];
    //在View中拿到触摸点
    CGPoint point = [touch locationInView:self];
    
    return point;
    
}

//得到对应范围内的按钮
-(UIButton *)buttonWithPoint:(CGPoint)point{
    //遍历所有按钮
    for (UIButton *btn in self.subviews) {
        //如果点在按钮的范围内，则返回该按钮
        if (CGRectContainsPoint(btn.frame, point)) {
            return btn;
        }
        
    }
    return nil;
}

//手指开始触摸屏幕
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //得到手指触摸点
    CGPoint point = [self pointWithTouches:touches];
    
    //通过触摸点来得到手指碰到的按钮
    UIButton *gestBtn = [self buttonWithPoint:point];
    
    //如果按钮存在并且该按钮没有被选中
    if (gestBtn && gestBtn.selected == NO) {
        
        //选中按钮
        gestBtn.selected = YES;
        
        //保存选中的按钮
        [_gestureButtonArr addObject:gestBtn];
        
    }
}

//手指在屏幕上滑动时调用的方法
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //得到手指触摸点
    CGPoint point = [self pointWithTouches:touches];
    
    //保存当前手指移动点，用于线路绘制
    _gestureLastPoint = point;
    
    //通过触摸点来得到手指碰到的按钮
    UIButton *gestBtn = [self buttonWithPoint:point];
    
    //如果按钮存在并且该按钮没有被选中
    if (gestBtn && gestBtn.selected == NO) {
      
        //选中按钮
        gestBtn.selected = YES;
        
        //保存选中的按钮
        [_gestureButtonArr addObject:gestBtn];
        
    }
    
    //重新绘制界面
    [self setNeedsDisplay];
  
}


//手指离开屏幕
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //取消所有选中按钮的选中状态
    [_gestureButtonArr makeObjectsPerformSelector:@selector(setSelected:) withObject:NO];
    
    //清空所有选中按钮
    [_gestureButtonArr removeAllObjects];
    
//    _gestureLastPoint = CGPointZero;
    //重新绘制界面
    [self setNeedsDisplay];
    
    
}

//选中按钮图案绘制
- (void)drawRect:(CGRect)rect {
    
    // 判断有没有选中按钮
    if (_gestureButtonArr.count == 0) {
        return;
    }
    
    //创建绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置线路宽度
    path.lineWidth = 10;
    //设置起始点样式
    path.lineCapStyle = kCGLineCapRound;
    //设置线路拐点样式
    path.lineJoinStyle = kCGLineCapRound;
    //设置线路颜色
    [[UIColor greenColor]set];
    
    for (int i = 0; i < _gestureButtonArr.count;i ++) {
        
        UIButton *btn = _gestureButtonArr[i];
        //判断是不是第一个按钮
        if (i == 0) {
            //设置起点
            [path moveToPoint:btn.center];
        }else{
            //连接选中的按钮线路
            [path addLineToPoint:btn.center];
        }
        
    }
    
    //当没有选中按钮的时候连接手指的触摸点
    [path addLineToPoint:_gestureLastPoint];
    
    //渲染到视图上
    [path stroke];
    
    
}


@end
