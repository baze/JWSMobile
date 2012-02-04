//
//  SubstitutionsFetcher.m
//  Shutterbug
//
//  Created by Björn Martensen on 24.01.12.
//  Copyright (c) 2012 eberle & wollweber COMMUNICATIONS GmbH. All rights reserved.
//

#import "SubstitutionsFetcher.h"

#define BASE_URL @"http://jws.bjoernmartensen.de/vplan/show/"

@implementation SubstitutionsFetcher

+ (NSArray *)executeSubstitutionsFetch:(NSString *)query
{
    //query = [NSString stringWithFormat:@"%@&format=json&nojsoncallback=1&api_key=%@", query, FlickrAPIKey];
    //query = [query stringByAppendingPathComponent:@"tage"];
    // NSLog(@"[%@ %@] sent %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), query);
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    // NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
    return results;
}

+ (NSArray *)recentSubstitutions
{
    //NSString *request = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&per_page=500&license=1,2,4,7&has_geo=1&extras=original_format,tags,description,geo,date_upload,owner_name,place_url"];
    NSString *request = [NSString stringWithFormat:@"%@", BASE_URL];
    return [self executeSubstitutionsFetch:request];
}




@end
