#!/bin/bash

rm -rf slave.jar*


wget http://jenkins.inconcert/jnlpJars/slave.jar
java -jar slave.jar

