const express = require('express');
// Added for partials
var ejs = require('ejs');
const bodyParser = require('body-parser');
const request = require('request');
const app = express()

const apiKey = '6a57868754a2236f203c26ac29f10017';

app.use(express.static('public'));
app.use(bodyParser.urlencoded({ extended: true }));
// set the view engine to ejs
app.set('view engine', 'ejs')

app.get('/', function (req, res) {
  res.render('index', {weather: null, error: null});
})

app.post('/', function (req, res) {
  let city = req.body.city;
  let url = `http://api.openweathermap.org/data/2.5/weather?q=${city}&units=imperial&appid=${apiKey}`

  request(url, function (err, response, body) {
    if(err){
      res.render('index', {weather: null, error: 'Error, please try again'});
    } else {
      let weather = JSON.parse(body)
      if(weather.main == undefined){
        res.render('index', {weather: null, error: 'Error, please try again'});
      } else {
        let weatherText = `In ${weather.name} it's ${weather.main.temp}`;
        res.render('index', {weather: weatherText, error: null});
      }
    }
  });
})

// GET method route for About Page
app.get('/about', function (req, res) {
  // res.send('GET request to the homepage')
  res.render('about')
})

app.listen(3000, function () {
  console.log('Example app listening on port 3000!')
})
