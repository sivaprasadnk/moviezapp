/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

const fun1 = functions
    .runWith({
      timeoutSeconds: 30,
      maxInstances: 10,
    })
    .https.onRequest((request, response) => {
      logger.info("Hello logs!", {structuredData: true});
      response.send("Hello from Firebase!");
    });
exports.hello = fun1;
