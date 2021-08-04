var exec = require("cordova/exec");

const YmChatAPI = {
  setBotId: (botId) => {
    console.log("setting bot id");
    exec(null, null, "ymchat", "setBotId", [botId]);
  },
  setDeviceToken: (token) => {
    exec(null, null, "ymchat", "setDeviceToken", [token]);
  },
  setEnableSpeech: (speech) => {
    exec(null, null, "ymchat", "setEnableSpeech", [speech]);
  },
  setEnableHistory: (history) => {
    exec(null, null, "ymchat", "setEnableHistory", [history]);
  },
  setAuthenticationToken: (token) => {
    exec(null, null, "ymchat", "setAuthenticationToken", [token]);
  },
  showCloseButton: (closeBot) => {
    exec(null, null, "ymchat", "showCloseButton", [closeBot]);
  },
  setCustomURL: (url) => {
    exec(null, null, "ymchat", "setCustomURL", [url]);
  },
  setPayload: (payload) => {
    console.log("setting payload");
    exec(null, null, "ymchat", "setPayload", [payload]);
  },
  onEventFromBot: (eventListener) => {
    console.log("listening to events");
    exec(eventListener, null, "ymchat", "onEventFromBot", []);
  },
  onBotClose: (onBotCloseEvent) => {
    console.log("listening to bot close events");
    exec(onBotCloseEvent, null, "ymchat", "onBotClose", []);
  },
  startChatbot: (success, failure) => {
    console.log("Starting chatbot");
    exec(success, failure, "ymchat", "startChatbot", []);
  },
  closeBot: () => {
    exec(null, null, "ymchat", "closeBot", []);
  },
};

module.exports = YmChatAPI;