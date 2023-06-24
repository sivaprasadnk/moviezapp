importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    //   apiKey: 'AIzaSyB7wZb2tO1-Fs6GbDADUSTs2Qs3w08Hovw',
    //   appId: '1:406099696497:web:87e25e51afe982cd3574d0',
    //   messagingSenderId: '406099696497',
    //   projectId: 'flutterfire-e2e-tests',
    //   authDomain: 'flutterfire-e2e-tests.firebaseapp.com',
    //   databaseURL:
    //       'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    //   storageBucket: 'flutterfire-e2e-tests.appspot.com',
    //   measurementId: 'G-JN95N1JV2E',
    apiKey: 'AIzaSyD10oiiOiNlIw-qtU2kfzUByblygKl6ijM',
    appId: '1:1042736811024:web:86bf9fc78b8a83c09a0e95',
    messagingSenderId: '1042736811024',
    projectId: 'moviezapp-test',
    authDomain: 'moviezapp-test.firebaseapp.com',
    storageBucket: 'moviezapp-test.appspot.com',
    measurementId: 'G-RG0B7QSNB0',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
    console.log("onBackgroundMessage", m);
});