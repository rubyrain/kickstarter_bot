#!/bin/bash
docker build -t kickstarter_bot .
docker run -itd kickstarter_bot