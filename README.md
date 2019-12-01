# URL Shortener

A URL shortening service using Ruby. 

## Local installation

* Clone this repository
* Run the following commands

```
bundle install
```

* Check all the tests are running using ```rspec``` commmand.
* Run the server using ``` rackup``` 
* On the command line to make a POST request run 

```
curl localhost:9292/shortener -XPOST -d '{ "url": "https://www.farmdrop.com/london/recipes/555/chickpea-squash-and-coconut-curry" }'
{"short_url":"/yyotpw","url":"https://www.farmdrop.com/london/recipes/555/chickpea-squash-and-coconut-curry"}
```

* Take the short url and then run this.

```
curl -v localhost:9292/yyotpw
```

* Run ```rackup``` and go to http://localhost:9292/ in your browser to see the front end. 


## User Stories

```
As a user,
When I POST a JSON body containing the URL  https://www.farmdrop.com/london/recipes/546/www.farmdrop.com/london/recipes/555/chickpea-squash-and-coconut-curry
To localhost:9292/shorten
It should respond with a JSON response containing the URL and a new short URL 
e.g. /sftjgb
```

```
As a user,
When I send a GET request to short URL localhost:9292/sftjgb
It should redirect me to the URL www.farmdrop.com/london/recipes/555/chickpea-squash-and-coconut-curry
```

### Technology used

- Ruby 
- Sinatra
- Javascript 

#### Testing (98.5% coverage)

- Rspec 
- Rubocop
- Simplecov 

# Url Shortener Code Test

Without using an external database, we'd like you to create a URL shortening
service. The URLs do not need to persist between restarts, but should be
shareable between different clients while the server is running.

- There should be an endpoint that responds to `POST` with a json body
  containing a URL, which responds with a JSON repsonse of the short url and
  the orignal URL, as in the following curl example:

```
curl localhost:4000 -XPOST -d '{ "url": "http://www.farmdrop.com" }'
{ "short_url": "/abc123", "url": "http://www.farmdrop.com" }
```


- When you send a GET request to a previously returned URL, it should redirect
  to the POSTed URL, as shown in the following curl example:

```
curl -v localhost:4000/abc123
...
< HTTP/1.1 301 Moved Permanently
...
< Location: http://www.farmdrop.com
...
{ "url": "http://www.farmdrop.com" }
```

Use whatever languages and frameworks you are comfortable with. Don't worry
about getting the whole thing working flawlessly, this is more to see how you
structure a program. Please don't spend more than a few hours on it.

Bonus points:

- I often forget to type "http://" at the start of a URL. It would be nice if
  this was handled by the application (frontend or backend is up to you).
- We like to see how you approach the problem, so a few git commits with a
  clear message about what you're doing are better than one git commit with
  everything in it.
- We like tests. We don't expect a full test suite, but some tests would be
  nice to see. Its up to you whether thats integration, unit or some other
  level of testing.
- We'd be very happy to see a Dockerfile to run the project. This by no means a
  requirement, so don't go reading the Docker docs if you've never worked with
  it.
- If you'd like to show off your frontend skills, you could create a simple
  frontend that can create and display shortened URLs without reloading the
  page.

## Submission

Please clone this repository, write some code and update this README with a
guide of how to run it.

Either send us a link to the repository on somewhere like github or bitbucket
(bitbucket has free private repositories) or send us a git bundle.

    git bundle create yournamehere-url-shortener-test.bundle master

And send us the resulting `yournamehere-url-shortener-test.bundle` file.

This `.bundle` file can be cloned using:

    git bundle clone bundle-filename.bundle -b master directory-name