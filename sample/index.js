const functions = require("firebase-functions");
const axios = require("axios");
// const cors = require("cors");
const apiKey = "8d5a3dfeea83619117402fc317d79d25";
const baseUrl = "https://api.themoviedb.org/3";

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


// exports.trendingMoviesForWeb = functions
//     .runWith({
//       maxInstances: 10,
//     })
//     .https.onRequest(async (request, response) => {
//       const url = baseUrl + "/trending/movie/day?api_key=" + apiKey + "&region=IN&page=1";
//       const apiResponse = await axios.get(url);
//       const responseData = apiResponse.data;
//       response.set("Access-Control-Allow-Origin", "*");
//       response.set("Access-Control-Allow-Methods", "GET, POST");
//       response.set("Access-Control-Allow-Headers", "Content-Type");
//       response.status(200).send({"data": responseData});
//     });
