const functions = require("firebase-functions");
const admin = require('firebase-admin');
admin.initializeApp();

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
// const SENDER_EMAIL = "sivaprasadnk123@gmail.com";
const ENDPOINT = "https://send.api.mailtrap.io/";
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
      client
        .send({
          from: sender,
          to: recipients,
          subject: "Hello from Mailtrap !!",
          text: "Welcome to Mailtrap Sending!",
        });
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
    log("token :" + request.body.token);
    try {
      const message = {
        token: request.body.token,
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
