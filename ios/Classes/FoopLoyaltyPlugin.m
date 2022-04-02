#import "FoopLoyaltyPlugin.h"
#if __has_include(<foop_loyalty_plugin/foop_loyalty_plugin-Swift.h>)
#import <foop_loyalty_plugin/foop_loyalty_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "foop_loyalty_plugin-Swift.h"
#endif

@implementation FoopLoyaltyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFoopLoyaltyPlugin registerWithRegistrar:registrar];
}
@end
