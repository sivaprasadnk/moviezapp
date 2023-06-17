const functions = require("firebase-functions");
const axios = require("axios");
const {MailtrapClient} = require("mailtrap");


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

const client = new MailtrapClient({endpoint: ENDPOINT, token: TOKEN});


exports.trendingMovies = functions
    .runWith({
      maxInstances: 10,
    })
    .https.onRequest(async (request, response) => {
      const url = baseUrl + "/trending/movie/day?api_key=" + apiKey + "&region=IN&page=1";
      const apiResponse = await axios.get(url);
      const responseData = apiResponse.data;
      response.set("Access-Control-Allow-Origin", "*");
      response.set("Access-Control-Allow-Methods", "GET, POST");
      response.set("Access-Control-Allow-Headers", "Content-Type");
      response.status(200).send({"data": responseData});
    });

exports.sendWelcomeEmail = functions
    .runWith({
      maxInstances: 10,

    })
    .https.onRequest(async (request, response) => {
      // const client = new MailtrapClient({token: TOKEN});
      // console.log("email :" + request.email);
      // const sender = {name: "MoviezApp", email: SENDER_EMAIL};
      // client
      //     .send({
      //       from: sender,
      //       to: [{email: request.email}],
      //       subject: "Welcome to MoviezApp!",
      //       text: "Thank you for sign-up!",
      //     })
      //     .then(console.log, console.error);
      client
          .send({
            from: sender,
            to: recipients,
            subject: "Hello from Mailtrap !!",
            text: "Welcome to Mailtrap Sending!",
          });
    });
