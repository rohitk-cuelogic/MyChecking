//
//  LanguageCustomCell.m
//  TigglySafari
//
//  Created by Sachin Patil on 30/04/14.
//  Copyright (c) 2014 Sachin Patil. All rights reserved.
//

#import "LanguageCustomCell.h"
#import "TConstant.h"

@implementation LanguageCustomCell
@synthesize textLabel = _textLabel;
@synthesize imgViewCell = _imgViewCell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 10, self.frame.size.width - 75, 30)];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.textAlignment = UITextAlignmentLeft;
        self.textLabel.font = [UIFont fontWithName:FONT_ROCKWELL_BOLD size:20.0f];
        [self addSubview:self.textLabel];
        
        
        self.imgViewCell = [[UIImageView alloc] initWithFrame:CGRectMake(15,self.frame.size.height/2 - 35/2 , 60, 35)];

        [self addSubview:self.imgViewCell];
        
    }
    return self;
}
@end
