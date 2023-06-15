# Project title: Workout planner

**Team members:**

Zongye Yang

David Traina

Ruxiao Duan

## Application description

**A mobile app to track fitness progress. Users create exercises and routines and log their progress. Progress over time is visualized in-app as interactive graphs. Users can add friends and friends can choose to share their routines/data.**

## Beta version key features
-   Create exercises (e.g bench press). Exercises can be categorized in a hierarchy (e.g. Push > Horizontal Push > Bench Press). Exercises are further categorized by how they are quantified (reps & sets, time, distance, etc.)

-   Create routines (an ordered list of exercises to be completed within a single session)

-   Log workout sessions for an exercise/routine (weight, reps, sets, time etc.). Notes can be added to exercises (e.g. for form tips). Notes and tags can be added to sets and/or sessions (applies tag to all sets within session). For example, an “injured” tag could indicate why performance was reduced for that session.

## Final version additional features
-   Visualize historical data/progress for exercises. Sets with certain tags could be included/excluded from visualization. Data about tagging could also be visualized (e.g. count “tired” tag frequency to see how often energy levels impede performance)

-   Connect with friends to share progress and participate in competitions

-   Download routines from marketplace (could be monetized by professional trainers)

-   Set fitness goals and app prompts you for progress. Goals could be workout frequency (5x a week) or movement specific (bench press 100lbs for 10 reps by March 1st)

## A description of technology we will use
-   Flutter to create mobile app

-   Node.js for backend

-   GraphQL for API

-   MongoDB for database

-   Data visualization library(chart.js)

-   Third party authentication via Facebook and Google

## Top 5 technical challenges
-   Data Visualization (visualizing workout progress in a nice-looking way)

-   Learning React Native and UI/UX design

-   Learning to host and deploy the app

-   Representing many types of exercises in an efficient and structured way

-   Integrating Facebook/Google api to connect users with friends


## app URL
Partially functional Online version (Integrated with AWS backend)
https://github.com/UTSCC09/workout-planner/releases/tag/1

Fully function offline version with online signin/signout
https://github.com/UTSCC09/workout-planner/releases/tag/master

## Video demo
https://www.youtube.com/watch?v=-Sjym0dlkt8

## API documentation
https://github.com/UTSCC09/workout-planner/blob/master/doc/README.md
