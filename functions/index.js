const functions = require("firebase-functions");

exports.myFunction = functions.firestore
    .document("chats/i9IFa7EAlYRZvzQkdUVQ/messages/{msg}")
    .onCreate((snapshot, context)=>{
      console.log(snapshot.data());
      return;
    });
