Project Requirements

[x] Provide a CLI

BW: the application is a CLI executable where the user inputs desired BART station and receives desired information in the command line interface.

[x] CLI must provide access to data from a web page.

BW: The CLI displays that the user may get the same system information from https://www.bart.gov/schedules/eta

[x] The data provided must go at least one level deep, generally by showing the user a list of available data and then being able to drill down into a specific item.

BW: The application provides a list of all stations in the BART system.  After selecting a station, the user can get real time departure information for all inbound trains and station info.

[X] The CLI application can not be a Music CLI application as that is too similar to the other OO Ruby final project. Also please refrain from using Kickstarter as that was used for the scraping 'code along'. Look at the example domains below for inspiration.

The CLI application is related to transportation, not Kickstarter, not music or any other final project.

[x] Use good OO design patterns. You should be creating a collection of objects - not hashes.

BW: The program can create instances of any of the 45 stations in the BART system (https://www.bart.gov/stations), as objects, upon the request of the user.  The application allows multiple search creating multiple objects.  The stations contain a name, station information, status updates, advisories all contained in a class called Station. The Station class holds all instances created and will provide the user a history of stations they have queried in that session.  Other classes are used, but not instantiated as an object, to control the application and scrape data from the BART.gov website.

Although the assignment discourages the use of hashes, a hash was necessarily used as a constant to store station codes, which was used solely for reference by the application to validate user inputs.  Also, a hash was used to capture real time train departure information during the data scraping process in order to efficiently move the large, semi-raw data set between classes. Because each real time departure data set, a snapshot has a extremely short, useful lifespan (i.e. <1 min), it is considered a property of a particular station instance.

****A earlier version of this CLI application was packaged by the author into a gem and was rebranded as "gobart", available at https://rubygems.org/gems/gobart.
