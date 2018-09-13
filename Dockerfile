FROM ruby:2.4
RUN mkdir -p /data
WORKDIR /data
ADD . /data
RUN bundle install
CMD ["ruby", "/data/main.rb"]