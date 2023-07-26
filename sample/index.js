const functions = require("firebase-functions");
const admin = require('firebase-admin');
const cron = require('node-cron');
const nodemailer = require("nodemailer");


let serviceAccount = require("./serviceAccountKey.json");
let token = "";
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
// const express = require("express");
// const {Firestore} = require('@google-cloud/firestore');
// const firestore = new Firestore();
// const app = express();
const db = admin.firestore();

const {
  log,
  info,
  debug,
  warn,
  error,
  write,
} = require("firebase-functions/logger");
const axios = require("axios");
const { MailtrapClient } = require("mailtrap");


// const TOKEN = "e0242be27d3b367c9a254c6682840718";
const TOKEN = "e0242be27d3b367c9a254c6682840718";
const ENDPOINT = "https://send.api.mailtrap.io/";
// const SENDER_EMAIL = "sivaprasadnk123@gmail.com";
// const RECIPIENT_EMAIL = "recipient@email.com";
// const cors = require("cors");
const apiKey = "8d5a3dfeea83619117402fc317d79d25";
const baseUrl = "https://api.themoviedb.org/3";
const sender = {
  email: "mailtrap@sivaprasadnk.dev",
  name: "Mailtrap Test",
};
const recipients = [
  {
    email: "sivaprasadtest123@gmail.com",
  },
];

const client = new MailtrapClient({ endpoint: ENDPOINT, token: TOKEN });

// app.get("/", (req, res) => {
//   return res.status(200).send("Hai there");
// });

exports.getGenreList = functions
  .runWith({
    maxInstances: 10,
  })
  .https.onRequest(async (request, response) => {
    // const url = "${kBaseUrl}genre/$show/list?api_key=$apiKey";
    const url = baseUrl + "/genre/movie/list?api_key=" + apiKey;
    // const url = baseUrl + "/trending/movie/day?api_key=" + apiKey + "&region=IN&page=1";
    const apiResponse = await axios.get(url);
    const responseData = apiResponse.data;
    response.set("Access-Control-Allow-Origin", "*");
    response.set("Access-Control-Allow-Methods", "GET, POST");
    response.set("Access-Control-Allow-Headers", "Content-Type");
    response.status(200).send({ "data": responseData });
  });

// exports.trendingMovies = functions
//   .runWith({
//     maxInstances: 10,
//   })
//   .https.onRequest(async (request, response) => {
//     const url = baseUrl + "/trending/movie/day?api_key=" + apiKey + "&region=IN&page=1";
//     const apiResponse = await axios.get(url);
//     const responseData = apiResponse.data;
//     response.set("Access-Control-Allow-Origin", "*");
//     response.set("Access-Control-Allow-Methods", "GET, POST");
//     response.set("Access-Control-Allow-Headers", "Content-Type");
//     response.status(200).send({ "data": responseData });
//   });

exports.movieResults = functions
  .runWith({
    maxInstances: 10,
  })
  .https.onRequest(async (request, response) => {
    const type = request.body.type;
    const id = request.body.id;
    const region = request.body.region;
    const query = request.body.query;
    let url = "";

    if (type == "trending") {

      url = baseUrl + "/trending/movie/day";

    } else if (type == "similar") {

      url = baseUrl + "/movie/" + id + "/similar";

    } else if (type == "search") {

      url = baseUrl + "/search/movie";

    } else {

      url = baseUrl + "/movie/" + type;

    }
    url = url + "?api_key=" + apiKey;

    if (type == 'search') {

      url = url + "&query=" + query;
    } else {

      if (region.length != 0) {

        url = url + "&region=" + region + "&page=1";
      }
    }

    const apiResponse = await axios.get(url);
    // const responseData = apiResponse.data.results.sort((a, b)=>{
    //   return a.original_title - b.original_title;
    // });

    response.set("Access-Control-Allow-Origin", "*");
    response.set("Access-Control-Allow-Methods", "GET, POST");
    response.set("Access-Control-Allow-Headers", "Content-Type");
    response.status(200).send({ "data": apiResponse.data });
  });

exports.movieResultsWithSort = functions
  .runWith({
    maxInstances: 10,
  })
  .https.onRequest(async (request, response) => {
    try {
      const type = request.body.type;
      const id = request.body.id;
      const region = request.body.region;
      const query = request.body.query;
      const sortBy = request.body.sortBy;
      let url = "";

      if (type == "trending") {

        url = baseUrl + "/trending/movie/day";

      } else if (type == "similar") {

        url = baseUrl + "/movie/" + id + "/similar";

      } else if (type == "search") {

        url = baseUrl + "/search/movie";

      } else {

        url = baseUrl + "/movie/" + type;

      }
      url = url + "?api_key=" + apiKey;

      if (type == 'search') {

        url = url + "&query=" + query;
      } else {

        if (region.length != 0) {

          url = url + "&region=" + region + "&page=1";
        }
      }

      const apiResponse = await axios.get(url);
      const data = apiResponse.data.results;
      if (sortBy.length != 0) {

        if (sortBy == "title") {

          data.sort((a, b) => {
            return a.original_title.localeCompare(b.original_title);
          });
        } else if (sortBy == "id") {
          data.sort((a, b) => {
            return a.id - b.id;
          });
        } else if (sortBy == "release_date") {
          data.sort((a, b) => {
            return a.release_date.localeCompare(b.release_date);
          });
        } else if (sortBy == "vote") {
          data.sort((a, b) => {
            return a.vote_average - b.vote_average;
          });
        }
      }


      response.set("Access-Control-Allow-Origin", "*");
      response.set("Access-Control-Allow-Methods", "GET, POST");
      response.set("Access-Control-Allow-Headers", "Content-Type");
      response.status(200).send({ "data": data });

    } catch (err) {
      response.status(500).send({ "data": [], "error": err });

    }
  });
//
//  {
//  "email": "sivaprasadnk123@gmail.com",
//  "port": 587,
//  "username": "admin@sivaprasadnk.dev",
//  "password": "55829705b0303809b73a33c1",
//  "from": "sivaprasadnk.dev@gmail.com",
//  "to": "sivaprasadnk123@gmail.com"
//  }
//

exports.sendWelcomeEmail = functions
  .runWith({
    maxInstances: 10,

  })
  .https.onRequest(async (request, response) => {
    // request.body.data
    // const client = new MailtrapClient({token: TOKEN});
    log("email :" + request.body.email);
    // const sender = {name: "MoviezApp", email: SENDER_EMAIL};
    // client
    //     .send({
    //       from: sender,
    //       to: [{email: request.email}],
    //       subject: "Welcome to MoviezApp!",
    //       text: "Thank you for sign-up!",
    //     })
    //     .then(console.log, console.error);
    try {
      const transporter = nodemailer.createTransport({
        host: "smtp.forwardemail.net",
        port: request.body.port,
        secure: true,
        auth: {
          // TODO: replace `user` and `pass` values from <https://forwardemail.net>
          // user: 'admin@sivaprasadnk.dev',
          user: request.body.username,
          // pass: '55829705b0303809b73a33c1'
          pass: request.body.password,
        },
      });
      const info = await transporter.sendMail({
        from: request.body.from, // sender address
        to: request.body.to, // list of receivers
        subject: "Hello ✔", // Subject line
        text: "Hello world?", // plain text body
        html: "<b>Hello world?</b>", // html body
      });

      log("Message sent: %s", info.messageId);
      // client
      //   .send({
      //     from: sender,
      //     to: recipients,
      //     template_uuid: "18fa6404-4ef8-4fdb-9223-b99a50a654e8",
      //     template_variables: {
      //       "user_name": "Test_User_name",
      //       "next_step_link": "Test_Next_step_link",
      //       "get_started_link": "Test_Get_started_link",
      //       "onboarding_video_link": "Test_Onboarding_video_link"
      //     }
      //     // subject: "Hello from Mailtrap !!",
      //     // text: "Welcome to Mailtrap Sending!",
      //   });
      // response.set("Access-Control-Allow-Origin", "*");
      // response.set("Access-Control-Allow-Methods", "GET, POST");
      // response.set("Access-Control-Allow-Headers", "Content-Type");
      // response.status(200).send({ "data": "success" });
    } catch (err) {
      error(err);
      response.status(200).send({ "data": "failed" });

    }
  });

exports.sendWelcomeEmail = functions
  .runWith({
    maxInstances: 10,

  })
  .https.onRequest(async (request, response) => {
    // request.body.data
    // const client = new MailtrapClient({token: TOKEN});
    log("email :" + request.body.email);
    // const sender = {name: "MoviezApp", email: SENDER_EMAIL};
    // client
    //     .send({
    //       from: sender,
    //       to: [{email: request.email}],
    //       subject: "Welcome to MoviezApp!",
    //       text: "Thank you for sign-up!",
    //     })
    //     .then(console.log, console.error);
    try {
      const transporter = nodemailer.createTransport({
        host: request.body.host,
        port: request.body.port,
        auth: {
          // TODO: replace `user` and `pass` values from <https://forwardemail.net>
          // user: 'admin@sivaprasadnk.dev',
          user: request.body.username,
          // pass: '55829705b0303809b73a33c1'
          pass: request.body.password,
        },
      });
      const info = await transporter.sendMail({
        from: request.body.from, // sender address
        to: request.body.to, // list of receivers
        subject: "Hello ✔", // Subject line
        text: "Hello world?", // plain text body
        html: "<b>Hello world?</b>", // html body
      });

      log("Message sent: %s", info.messageId);
      // client
      //   .send({
      //     from: sender,
      //     to: recipients,
      //     template_uuid: "18fa6404-4ef8-4fdb-9223-b99a50a654e8",
      //     template_variables: {
      //       "user_name": "Test_User_name",
      //       "next_step_link": "Test_Next_step_link",
      //       "get_started_link": "Test_Get_started_link",
      //       "onboarding_video_link": "Test_Onboarding_video_link"
      //     }
      //     // subject: "Hello from Mailtrap !!",
      //     // text: "Welcome to Mailtrap Sending!",
      //   });
      response.set("Access-Control-Allow-Origin", "*");
      response.set("Access-Control-Allow-Methods", "GET, POST");
      response.set("Access-Control-Allow-Headers", "Content-Type");
      response.status(200).send({ "data": "success" });
    } catch (err) {
      error(err);
      response.status(200).send({ "data": "failed" });

    }
  });

exports.sendWelcomeNotification = functions
  .runWith({
    maxInstances: 10,

  })
  .https.onRequest(async (request, response) => {
    let userToken = "";
    if (request == undefined || request.body == undefined) {
      userToken = token;
    } else {
      userToken = request.body.token;
    }
    log("token :" + userToken);
    try {
      const message = {
        token: userToken,
        notification: {
          title: 'Welcome to MoviezApp',
          body: 'Find movie details here',
        },
      };
      admin.messaging().send(message);
      response.set("Access-Control-Allow-Origin", "*");
      response.set("Access-Control-Allow-Methods", "GET, POST");
      response.set("Access-Control-Allow-Headers", "Content-Type");
      response.status(200).send({ "data": "success" });
    } catch (err) {
      error(err);
      response.status(200).send({ "data": "failed" });

    }
  });

exports.sendSignInNotification = functions
  .runWith({
    maxInstances: 10,

  })
  .https.onRequest(async (request, response) => {
    if (request.body == undefined) {
      log("no token ");
      log("token :" + token);
      try {
        const message = {
          token: token,
          notification: {
            title: 'Welcome Back to MoviezApp',
            body: 'Please visit us often',
          },
        };
        admin.messaging().send(message);
        response.set("Access-Control-Allow-Origin", "*");
        response.set("Access-Control-Allow-Methods", "GET, POST");
        response.set("Access-Control-Allow-Headers", "Content-Type");
        response.status(200).send({ "data": "success" });
      } catch (err) {
        error(err);
        response.status(200).send({ "data": "failed" });

      }

    } else {

      log("token :" + request.body.token);
      try {
        const message = {
          token: request.body.token,
          notification: {
            title: 'Welcome Back to MoviezApp',
            body: 'Please visit us often',
          },
        };
        admin.messaging().send(message);
        response.set("Access-Control-Allow-Origin", "*");
        response.set("Access-Control-Allow-Methods", "GET, POST");
        response.set("Access-Control-Allow-Headers", "Content-Type");
        response.status(200).send({ "data": "success" });
      } catch (err) {
        error(err);
        response.status(200).send({ "data": "failed" });

      }
    }
  });

exports.sendSignOutNotification = functions
  .runWith({
    maxInstances: 10,

  })
  .https.onRequest(async (request, response) => {
    log("token :" + request.body.token);
    try {
      const message = {
        token: request.body.token,
        notification: {
          title: 'Thanks for using MoviezApp',
          body: 'Please visit us often',
        },
      };
      admin.messaging().send(message);
      response.set("Access-Control-Allow-Origin", "*");
      response.set("Access-Control-Allow-Methods", "GET, POST");
      response.set("Access-Control-Allow-Headers", "Content-Type");
      response.status(200).send({ "data": "success" });
    } catch (err) {
      error(err);
      response.status(200).send({ "data": "failed" });

    }
  });


exports.sendNotification = functions
  .runWith({
    maxInstances: 10,

  })
  .https.onRequest(async (request, response) => {
    log("token :" + request.body.token);
    try {
      const message = {
        token: request.body.token,
        notification: {
          title: request.body.title,
          body: request.body.details,
        },
      };
      admin.messaging().send(message);
      response.set("Access-Control-Allow-Origin", "*");
      response.set("Access-Control-Allow-Methods", "GET, POST");
      response.set("Access-Control-Allow-Headers", "Content-Type");
      response.status(200).send({ "data": "success" });
    } catch (err) {
      error(err);
      response.status(200).send({ "data": "failed" });

    }
  });

exports.scheduleNotification = functions
  .https.onRequest(async (request, response) => {
    try {
      let query = db.collection("users");
      let tokens = [];

      await query.get().then((data) => {
        let docs = data.docs; // query results
        docs.map((doc) => {
          if (doc.data().fcmToken != null) {

            sendPushNotification(doc.data().fcmToken, doc.data().displayName, "");
          }
        });
      });
    } catch (err) {
      error(err);

    }
  });

exports.updateUser = functions
  .runWith({
    maxInstances: 10,

  })
  .https.onRequest(async (request, response) => {
    try {
      let userId = request.body.userId;
      token = request.body.fcmToken;
      const isWeb = request.body.isWeb;

      let email = request.body.email;
      let rating = request.body.rating;
      let displayName = request.body.displayName;
      // let bookMarkedMovieIdList = request.body.bookMarkedMovieIdList;
      let accountType = request.body.accountType;
      let createdDateTimeString = request.body.createdDateTimeString;
      let createdDateTime = request.body.createdDateTime;
      let isNewUser = request.body.isNewUser;
      let query = db.collection("users");
      // let tokens = [];


      if (isNewUser === "1") {
        await query.doc(userId).set({
          'email': email,
          'userId': userId,
          'rating': 0,
          'displayName': displayName,
          'fcmToken': token,
          'bookMarkedMovieIdList': [],
          'bookMarkedShowIdList': [],
          'accountType': accountType,
          'createdDateTime': createdDateTime,
          'createdDateTimeString': createdDateTimeString,
        });
        if (isWeb == "0") {
          this.sendWelcomeNotification(token, response);
        }
      } else {
        await query.doc(userId).update({
          'fcmToken': request.body.fcmToken,
        });
        if (isWeb == "0") {
          this.sendSignInNotification(token, response);
        }
      }

      // await query.get().then((data) => {
      //   let docs = data.docs; // query results
      //   docs.map((doc) => {
      //     if (doc.data().fcmToken != null) {

      //       tokens.push(doc.data().fcmToken);
      //     }
      //   });
      // });
      // response.set("Access-Control-Allow-Origin", "*");
      // response.set("Access-Control-Allow-Methods", "GET, POST");
      // response.set("Access-Control-Allow-Headers", "Content-Type");
      // response.status(200).send({ "data": "success" });
    } catch (err) {
      error(err);
      response.status(200).send({ "data": "failed" });

    }
  });

const sendPushNotification = async (registrationTokens, notificationTitle, notificationBody) => {
  try {
    const message = {
      tokens: [registrationTokens],
      notification: {
        title: " Hi, " + notificationTitle + " !",
        body: 'Have a great time!',
      },
    };

    const response = await admin.messaging().sendEachForMulticast(message);
  } catch (error) {
    log(error);
  }
};

cron.schedule('0 6 * * *', this.scheduleNotification);

