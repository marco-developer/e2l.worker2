#!/bin/bash

newjwt () {

    getjwt=$(curl --location --request POST 'http://localhost:4000/users' --header 'Content-Type: application/json' --data-raw '{ "username":"test", "orgName":"Usuario"}')
    echo $getjwt
    return getjwt
}