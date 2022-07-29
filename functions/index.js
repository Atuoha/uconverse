const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.myFunction = functions.firestore
    .document("chats/i9IFa7EAlYRZvzQkdUVQ/messages/{msg}")
    .onCreate((snapshot, context)=>{
      return admin.messaging()
          .sendToTopic("chat", {notification: {
            title: snapshot.data().username, body: snapshot.data().msg,
            clickAction: "FLUTTER_NOTIFICATION_CLICK"},
          });
    });
