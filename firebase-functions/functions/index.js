const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
  
// http request function
exports.addMessage = functions.https.onRequest(async (req, res) => {
    const text = req.query.text; 

    const writeResult = await admin.firestore().collection('messages')
        .add({MsgText: text}); 

    res.json({result: `Message with ID: ${writeResult.id} added.`}); 
});

// http callable functions
exports.sayHello = functions.https.onCall((data, context) => {
    return `hello`;    
});

exports.echo = functions.https.onCall((data, context) => {
    return data.text;
});

exports.addMessage_Callable = functions.https.onCall((data, context) => {
    admin.firestore().collection('messages')
        .add({MsgText: data.text})
            .then((result) => {
                return `Message with ID: ${result.id} added.`;
            })
            .catch((error) => {
                return error;
            });
});