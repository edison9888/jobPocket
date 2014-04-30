#import <Foundation/Foundation.h>
#import "MAMapKit.h"

@interface BasicMapAnnotation : NSObject <MAAnnotation> {
	CLLocationDegrees _latitude;
	CLLocationDegrees _longitude;
	NSString *_title;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) int tag;

- (id)initWithLatitude:(CLLocationDegrees)latitude
		  andLongitude:(CLLocationDegrees)longitude;
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
