build the docker image - docker build -t webserver-project .

Run the docker container - docker run -p 8080:8080 webserver-project

Now your app should be accessible at http://localhost:8080.
