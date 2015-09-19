## Authentication Session Handling in Ruby
This [Grape App](https://github.com/ruby-grape/grape) uses [Warden](https://github.com/hassox/warden) to showcase session handling.
The concept of XAuth for session handling is uses in simplier applications where OAuth is not feasible or needed.
Typical flow is as follows:
Assume Client == Mobile Application

* Client creates a GET request with HTTP header values that both Identify and Authorize.
* Service checks these credentials. If successful returns a Session Token.
* Session Token is then used with subsequent requests in HTTP headers.

*Think of it as OAuth where the Authentication Server and API Service are one in the same.*

This application does not use ActiveRecord. Simply because that is straight forward and not something I wanted to showcase. 

#### How it works?
* See [Grape App](https://github.com/ruby-grape/grape)
* See [Warden](https://github.com/hassox/warden)
* See Code

#### How to Run?
Assuming you have the essentials installed (Memcached, Ruby, Bundler, Foreman)

`foreman start`

Logging is in ./log/.log

#### How to see if it works?
Get [Paw](https://itunes.apple.com/us/app/paw-http-rest-client/id584653203?mt=12) or other RESTclient or check in `'app/api/protected_service.rb'` for breakdown of each the requests.

Simple and effective way of handling authentication in your application mobile - Ruby/Grape Applications.

