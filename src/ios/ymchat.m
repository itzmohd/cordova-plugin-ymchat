/********* ymchat.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@import YMChat;

@interface ymchat : CDVPlugin<YMChatDelegate> 
{
    CDVInvokedUrlCommand* onEvent;
    CDVInvokedUrlCommand* onBotClosed;
}

@end

@implementation ymchat
- (void)setBotId:(CDVInvokedUrlCommand*)command
{
    NSString* botId = [command.arguments objectAtIndex:0];
    YMConfig *config = [[YMConfig alloc] initWithBotId:botId];
    YMChat.shared.config = config;
    YMChat.shared.enableLogging = true;
}

- (void)setDeviceToken:(CDVInvokedUrlCommand*)command
{
    NSString* deviceToken = [command.arguments objectAtIndex:0];
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.deviceToken = deviceToken;
}

- (void)setEnableSpeech:(CDVInvokedUrlCommand*)command
{
    BOOL enableSpeech = [command.arguments objectAtIndex:0];
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.enableSpeech = enableSpeech;
}

- (void)setAuthenticationToken:(CDVInvokedUrlCommand*)command
{
    NSString* authToken = [command.arguments objectAtIndex:0];
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.ymAuthenticationToken = authToken;
}

- (void)showCloseButton:(CDVInvokedUrlCommand*)command
{
    BOOL closeBot = [command.arguments objectAtIndex:0];
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.showCloseButton = closeBot;
}

- (void)setCustomURL:(CDVInvokedUrlCommand*)command
{
    NSString* url = [command.arguments objectAtIndex:0];
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.customBaseUrl = url;
}

- (void)setPayload:(CDVInvokedUrlCommand*)command
{
    NSDictionary* payload = [command.arguments objectAtIndex:0];
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.payload = payload;
}

- (void)showCloseBot:(CDVInvokedUrlCommand*)command
{
    BOOL enableSpeech = [command.arguments objectAtIndex:0];
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.enableSpeech = enableSpeech;
}

- (void)onEventFromBot:(CDVInvokedUrlCommand*)command
{
    onEvent = command;
}

- (void)onBotClose:(CDVInvokedUrlCommand*)command
{
    onBotClosed = command;
}

- (void)startChatbot:(CDVInvokedUrlCommand*)command
{
    assert(YMChat.shared.config != nil);
    YMChat.shared.delegate = self;
    [[YMChat shared] startChatbotWithAnimated:YES error: nil completion:nil];
}

- (void)closeBot:(CDVInvokedUrlCommand*)command
{
    [[YMChat shared] closeBot];
}


- (void)onEventFromBotWithResponse:(YMBotEventResponse *)response {
    CDVPluginResult* pluginResult = nil;
    NSDictionary* event = @{ @"code":response.code,@"data": response.data};
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:event];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:onEvent.callbackId];
}

- (void) onBotClose {
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Hello"];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:onBotClosed.callbackId];
}

- (void)setVersion:(CDVInvokedUrlCommand*)command
{
    assert(YMChat.shared.config != nil);
    NSNumber* version = [command.arguments objectAtIndex:0];
    YMChat.shared.config.version = version.integerValue;
}

- (void) unlinkDeviceToken:(CDVInvokedUrlCommand*)command {
    NSString* botId = [command.arguments objectAtIndex:0];
    NSString* apiKey = [command.arguments objectAtIndex:1];
    NSString* deviceToken = [command.arguments objectAtIndex:2];
    [[YMChat shared] unlinkDeviceTokenWithBotId:botId apiKey:apiKey deviceToken:deviceToken success:^{
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    } failure:^(NSString * _Nonnull failureMessage) {
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:failureMessage];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)setCustomLoaderURL:(CDVInvokedUrlCommand*)command
{
    NSString* url = [command.arguments objectAtIndex:0];
    assert(YMChat.shared.config != nil);
    YMChat.shared.config.customLoaderUrl = url;
}

@end
