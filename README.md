# Fit For 90 Warmup

I hate coding interviews. They're often filled with irrelevant, esoteric questions that serve to boost the interviewer's ego. Some favorites from over the years:

 - Having to recognize the [Look-and-say](http://en.wikipedia.org/wiki/Look-and-say_sequence) sequence
 - Being asked questions that revolved entirely around the dude's PhD thesis
 - Being expected to know `strftime` format characters from memory

Unlike that nonsense, this warmup intends to gauge how well you know your way around the stack with a very real task that you'd see at Fit For 90. Simply clone this repo, complete the task, upload a zipped version to the cloud (e.g. Dropbox, Google Drive), and email Mike the link (mikegell[at]fitfor90[dot]com). ***DO NOT FORK THIS REPO AND PUSH COMMITS TO GITHUB***. We'd prefer you not share your answers with everyone else. :wink:

So chillax take your time and do your thing. You are encouraged to use ***ANY*** resources (gems, JavaScript libraries, StackOverflow) to make your life easier.

Feel free to send any questions to the same email listed above. 

## Getting Started

You'll need [Ruby v2.2+ and working Rails environment](https://gorails.com/setup/). Note we are using sqlite3 as the database for this project. After that's set up

 - Simply `bundle install`
 - `bundle exec rake db:setup` to migrate the database and the load seed data
 - Run the app at will and hack away!

As much as possible, try to include the following:

 - Understandable, self-documenting code
 - Well-thought code design
 - Well-written git commits
 - An animated GIF in your hello file (see Part 0)

## Background

### Training Loads

Training loads provide a good estimate of the amount effort exerted during an activity and are highly correlated with heart rate data. We calculate the training load by collecting two numbers from each player per activity and taking their product: the rating of perceived exertion (1-10, with 0 being rest) and the minutes spent performing that activity. In short:

    Training Load = Rating of Perceived Exertion (RPE) * Duration

The training load for a day is the sum of all training loads for that day.

Say I run for an hour, and I rate it at a difficulty of 3. Then I lift weights for 20 minutes and rate it at a difficulty of 10. My training load for the day would be calculated as follows:

    Day's Training Load = (60 * 3) + (20 * 10) = 480

### Training Load Residuals

Because of the body's need for recovery from a training session, a training load residual exists and affects the capacity to perform work on subsequent days. The percentage of the training load (residual) decreases with time, but may last as long as 4 days. The result is a steady decline that models the body's recovery from stress for each subsequent potential training load. This is simplified here into 3 training load category ranges. Below is a table of residual factors broken down by load range and days passed. (Note these values have been invented for this exercise.)

| Load Range       | 1 Day Prior | 2 Days Prior | 3 Days Prior |
|------------------|-------------|--------------|--------------|
| 750+ (inclusive) | 0.40        | 0.20         | 0.10         |
| [250, 750)       | 0.30        | 0.15         | 0.05         |
| [0, 250]         | 0.20        | 0.10         | 0.00         |

Say we have the following training loads:

| ***Day***  | Day 1   | Day 2 | Day 3  | "Today" |
|------------|---------|-------|--------|---------|
| ***Load*** | 1000    | 740   | 100    | 300     | 

You can determine the following residuals by looking at the corresponding residual factor from the table as follows:

| Load Range       | 1 Day Prior | 2 Days Prior | 3 Days Prior | 
|------------------|-------------|--------------|--------------|
| 750+ (inclusive) | 0.40        | 0.20         | **0.10**     |
| [250, 750)       | 0.30        | **0.15**     | 0.05         |
| [0, 250)         | **0.20**    | 0.10         | 0.00         |

Then multiply those residual factors by the training load for the corresponding day:

| *Day*                           | Day 1 | Day 2  | Day 3  | "Today" | 
|---------------------------------|-------|--------|--------|---------|
| ***Load***                      | 1000  | 740    | 100    | 300     |
| ***RFactor***                   | 0.10  | 0.15   | 0.20   | N/A     |
| ***Residual = Load x RFactor*** | 100   | 111    | 20     | N/A     |

The perceived load for today is the sum of residuals and the current day's load:

    Today's Perceived Load = Residuals + Today's Load
    Today's Perceived Load = (100 + 111 + 20) + 300 = 531

## Part 0: Hello!

Create a markdown file named in the root of this project `HELLO.md` (hello file), add your name and email address to the top. Use this hello file to document or explain whatever you feel necessary.

## Part 1: Analyzing Residuals

Currently you're provided the following models:

 - `Player`
 - `TrainingLoad`

where `Player` has many `TrainingLoad`s. Data has already been such that players have data from 2015-01-25 to 2015-01-16. You may assume any days missing a training load were off days.

 1. Fill in the "Days to Recovery" column of the overview table in the dashboard with the number of days it'll take for the players perceived load to return to zero.
 2. Create a route with the format `/players/:player_id/training_loads` that charts the actual training loads for each date as bars against the perceived loads for each date as a line. Be sure to chart the perceived load far enough into the future to include their recovery dates (i.e. to each players zero point.) Link to each players chart page from the overview table in the dashboard.
 3. The method used to determine the residuals above with respect to the training load is piecewise. Devise a better strategy to determine the residual value for a given training load based on the provided table. Devise a way to easily toggle between these strategies from within your code, and document how to make that change in your hello file.

For the charting task, use whatever charting library you see fit. Here are some to look into (in alphabetical order):

 - [amCharts](http://www.amcharts.com/)
 - [Chartist.js](http://gionkunz.github.io/chartist-js/)
 - [Charts.js](http://www.chartjs.org/)
 - [Flot](http://www.flotcharts.org/)
 - [Google Charts](https://developers.google.com/chart/)
 - [Highcharts](http://www.highcharts.com/)
 - [NVD3](http://nvd3.org/)

## Part 2: Oy, Bad Code...

There are a few things that are poorly coded and even flat out wrong in the app. Do your best to clean things up.

 1. The sparkline charts on the dashboard are very, very wrong. Fix 'em.
 2. The dashboard can load much faster than it currently does. You can use the profiler at the top left corner of the page to diagnose the problem.
 3. Ew... what's this `player.training_loads.where(date: date).first.value` in `app/views/dashboard/index.html.erb`?

## Thanks and Next Steps

Thanks for taking the time to work on this project! After you've submitted your code, we'll have a look and send you an email about the next steps. We look forward to growing our team so we can increase our pace, continue to scale, and have an even greater impact.
