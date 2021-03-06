//
//  FireworksViewController.m
//  EmitterAnimation
//
//  Created by 刘梦桦 on 2017/12/27.
//  Copyright © 2017年 lmh. All rights reserved.
//

#import "FireworksViewController.h"

@interface FireworksViewController ()
@property (nonatomic, strong) CAEmitterLayer * fireworksLayer;
@end

@implementation FireworksViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupEmitter];
}

- (void)setupEmitter{
    // 配置layer
    CAEmitterLayer * fireworksLayer = [CAEmitterLayer layer];
    [self.view.layer addSublayer:fireworksLayer];
    self.fireworksLayer = fireworksLayer;
    
    fireworksLayer.emitterPosition = CGPointMake(self.view.layer.bounds.size.width * 0.5, self.view.layer.bounds.size.height); // 在底部
    fireworksLayer.emitterSize = CGSizeMake(self.view.layer.bounds.size.width * 0.1, 0.f);  // 宽度为一半
    fireworksLayer.emitterMode = kCAEmitterLayerOutline;
    fireworksLayer.emitterShape = kCAEmitterLayerLine;
    fireworksLayer.renderMode = kCAEmitterLayerAdditive;
    
    // 发射
    CAEmitterCell * shootCell = [CAEmitterCell emitterCell];
    shootCell.name = @"shootCell";
    
    shootCell.birthRate = 1.f;
    shootCell.lifetime = 1.02;  // 上一个销毁了下一个再发出来
    
    shootCell.velocity = 600.f;
    shootCell.velocityRange = 100.f;
    shootCell.yAcceleration = 75.f;  // 模拟重力影响
    
    shootCell.emissionRange = M_PI * 0.25; // 
    
    shootCell.scale = 0.05;
    shootCell.color = [[UIColor redColor] CGColor];
    shootCell.greenRange = 1.f;
    shootCell.redRange = 1.f;
    shootCell.blueRange = 1.f;
    shootCell.contents = (id)[[UIImage imageNamed:@"shoot_white"] CGImage];
    
    shootCell.spinRange = M_PI;  // 自转360度
    
    // 爆炸
    CAEmitterCell * explodeCell = [CAEmitterCell emitterCell];
    explodeCell.name = @"explodeCell";
    
    explodeCell.birthRate = 1.f;
    explodeCell.lifetime = 0.5f;
    explodeCell.velocity = 0.f;
    explodeCell.scale = 2.5;
    explodeCell.redSpeed = -1.5;  //爆炸的时候变化颜色
    explodeCell.blueRange = 1.5; //爆炸的时候变化颜色
    explodeCell.greenRange = 1.f; //爆炸的时候变化颜色
    
    // 火花
    CAEmitterCell * sparkCell = [CAEmitterCell emitterCell];
    sparkCell.name = @"sparkCell";
    
    sparkCell.birthRate = 400.f;
    sparkCell.lifetime = 3.f;
    sparkCell.velocity = 125.f;
    sparkCell.yAcceleration = 75.f;  // 模拟重力影响
    sparkCell.emissionRange = M_PI * 2;  // 360度
    
    sparkCell.scale = 1.2f;
    sparkCell.contents = (id)[[UIImage imageNamed:@"star_white_stroke"] CGImage];
    sparkCell.redSpeed = 0.4;
    sparkCell.greenSpeed = -0.1;
    sparkCell.blueSpeed = -0.1;
    sparkCell.alphaSpeed = -0.25;
    
    sparkCell.spin = M_PI * 2; // 自转
    
    //添加动画
    fireworksLayer.emitterCells = @[shootCell];
    shootCell.emitterCells = @[explodeCell];
    explodeCell.emitterCells = @[sparkCell];
}
@end
