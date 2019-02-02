//
//  YWTableViewCell.m
//  WishTree
//
//  Created by MingmingSun on 2019/1/12.
//  Copyright © 2019 Sunmingming. All rights reserved.
//

#import "YWTableViewCell.h"

@implementation YWTableViewCell

- (void)awakeFromNib {
	[super awakeFromNib];
	// Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// configure control(s)
		self.bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 70)];
		self.bgImgView.image = [UIImage imageNamed:@"bg_0.jpg"];
		[self.bgImgView setContentMode:UIViewContentModeScaleToFill];
		[self addSubview:self.bgImgView];
		
		self.tagImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 50)];
		self.tagImgView.image = [UIImage imageNamed:@"bookmark"];
		[self.tagImgView setContentMode:UIViewContentModeScaleToFill];
		[self addSubview:self.tagImgView];
		
		self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 15)];
		self.numberLabel.textColor = [UIColor darkGrayColor];
		self.numberLabel.textAlignment = NSTextAlignmentLeft;
		self.numberLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
		[self addSubview:self.numberLabel];
		
		self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 250, 20)];
		self.mainLabel.textColor = [UIColor blackColor];
		self.mainLabel.textAlignment = NSTextAlignmentLeft;
		self.mainLabel.font = [UIFont fontWithName:@"Arial" size:16.0f];
		[self addSubview:self.mainLabel];
		
		self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 45, 200, 15)];
		self.dateLabel.textColor = [UIColor darkGrayColor];
		self.dateLabel.textAlignment = NSTextAlignmentLeft;
		self.dateLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
		[self addSubview:self.dateLabel];
		
		self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth - 100, 10, 90, 15)];
		self.moneyLabel.textColor = [UIColor darkGrayColor];
		self.moneyLabel.textAlignment = NSTextAlignmentRight;
		self.moneyLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
		[self addSubview:self.moneyLabel];
		
		self.praiseLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth - 100, 25, 90, 15)];
		self.praiseLabel.textColor = [UIColor darkGrayColor];
		self.praiseLabel.textAlignment = NSTextAlignmentRight;
		self.praiseLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
		[self addSubview:self.praiseLabel];
	}
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

@end
