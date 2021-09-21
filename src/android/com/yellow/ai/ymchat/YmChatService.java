package com.yellow.ai.ymchat;

import android.content.Context;
import android.util.Log;

import com.yellow.ai.ymchat.utils.Utils;
import com.yellowmessenger.ymchat.YMChat;
import com.yellowmessenger.ymchat.YMConfig;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.json.JSONObject;

import java.util.HashMap;

public class YmChatService {
  YMChat ymChat;
  final String Tag = "YmChat";
  final String ExceptionString = "Exception";
  final String code = "code";
  final String data = "data";

  HashMap<String, Object> payloadData = new HashMap<>();

  YmChatService() {
    this.ymChat = YMChat.getInstance();
  }

  public void setBotId(String botId, CallbackContext callbackContext) {
    ymChat.config = new YMConfig(botId);
    ymChat.config.ymAuthenticationToken = "";
    ymChat.config.payload = payloadData;
  }

  public void startChatbot(Context context, CallbackContext callbackContext) {
    try {
      ymChat.startChatbot(context);
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public void closeBot() {
    ymChat.closeBot();
  }

  public void setDeviceToken(String token, CallbackContext callbackContext) {
    ymChat.config.deviceToken = token;
  }

  public void setEnableSpeech(boolean speech, CallbackContext callbackContext) {
    ymChat.config.enableSpeech = speech;
  }

  public void setEnableHistory(boolean history, CallbackContext callbackContext) {
    ymChat.config.enableHistory = history;
  }

  public void setAuthenticationToken(String token, CallbackContext callbackContext) {
    ymChat.config.ymAuthenticationToken = token;
  }

  public void showCloseButton(boolean show, CallbackContext callbackContext) {
    ymChat.config.showCloseButton = show;
  }

  public void customBaseUrl(String url, CallbackContext callbackContext) {
    ymChat.config.customBaseUrl = url;
  }

  public void setPayload(JSONObject payload, CallbackContext callbackContext)  {
    try{
      ymChat.config.payload.putAll(Utils.jsonToMap(payload));
    }
    catch (Exception e) {
      Utils.genericErrorHelper(e, callbackContext);
    }
  }

  public void onEventFromBot(CallbackContext callback) {
    ymChat.onEventFromBot(botEvent ->
    {
      JSONObject jsonObject = new JSONObject();
      try {
        jsonObject.put(code, botEvent.getCode());
        jsonObject.put(data, new JSONObject(botEvent.getData()));
        PluginResult result = new PluginResult(PluginResult.Status.OK, jsonObject);
        result.setKeepCallback(true);
        callback.sendPluginResult(result);
      } catch (Exception e) {
        Log.e(Tag, ExceptionString, e);
      }
    });
  }

  public void onBotClose(CallbackContext callback) {
    ymChat.onBotClose(() ->
    {
      try {
        PluginResult result = new PluginResult(PluginResult.Status.OK);
        result.setKeepCallback(true);
        callback.sendPluginResult(result);
      } catch (Exception e) {
        Log.e(Tag, ExceptionString, e);
      }
    });
  }
}
