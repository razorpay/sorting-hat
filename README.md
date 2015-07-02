![Sorting Hat](public/logo.png)

Web API wrapper over the clearbit-slack integration gem. Just make the following curl
request from your application to put information in your slack channel.

    curl -d "email=shashank@razorpay.com" "https://app-url.herokuapp.com/"

The environment variables, set in Heroku are:

    SLACK_CHANNEL="#signups"
    SLACK_URL=http://slack.com/webhook/url
    CLEARBIT_KEY=Your clearbit API Key

**Note**: Slack channel names must begin with `#`.
The API will respond with a JSON response with correct HTTP status code. The ones currently used are:

- 204: Everything went fine. Message posted to Slack
- 400: Invalid Email Address
- 502: Slack returned an error
- 503: ClearBit returned an error

No content is returned as part of the response. If your Clearbit runs out of quota, it will just post the name and email directly to Slack.

## Why

The `clearbit-slack` gem works perfectly, however, it only integrates with your application if you are on a ruby stack. In fact, the sample code in their README assumes a Rails setup. Since we are not on Rails, we wrote a simple http wrapper over the gem that we can easily hit from our own app.

## License
Licensed under MIT. Please see LICENSE.
