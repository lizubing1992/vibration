#import "VibrationPlugin.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation VibrationPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
        methodChannelWithName:@"vibration"
              binaryMessenger:[registrar messenger]];
    VibrationPlugin* instance = [[VibrationPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if([@"hasVibrator" isEqualToString:call.method]){
      result(@TRUE);
  }else if([@"hasAmplitudeControl" isEqualToString:call.method]){
      result(@TRUE);
  }else if([@"hasCustomVibrationsSupport" isEqualToString:call.method]){
      result(@TRUE);
  }else if([@"vibrate" isEqualToString:call.method]){
      if (@available(iOS 10.0, *)) {
          UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleHeavy];
          [generator impactOccurred];
      } else {
          // Fallback on earlier versions
          AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
      }
        
  }else if([@"cancel" isEqualToString:call.method]){
      result(@"");
  }else{
    result(FlutterMethodNotImplemented);
  }
}
@end
