# Resume

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Jekyll Site Website](https://github.com/franceme/franceme.github.io/workflows/Jekyll%20Site%20Website/badge.svg)
![Resume Repo Build](https://github.com/franceme/Resume/workflows/Create%20and%20Release%20Latex%20File/badge.svg)

## What is this?

This is my repository for my resume, cv, and website content.
I have been using this build process for close to a year while keeping it off of GitHub.
I left it off GitHub for so long since I didn't know of a way to hide the source information until after the documents are rendered.
Since I recently have been working with GitHub actions, I wanted to and did solve this.

## How does this work

![PlantUML Structure](https://www.plantuml.com/plantuml/png/TO_12i8m38RlVOeyWG-mNeONcSTTF9SjcvbTMjeK5V7TpJh4au50yd_vVqYRnIKfgpTDnpfx3rlB5I6wuUPcpDOqbqI2LUnu2d3EWM4YZzP4TPEGxiT2VeIN0ItDMd2GdsFvEe1OGjK5r-YT89HCFCC9MV1nY4-x9-nnss726990u07_CRdJ1j-cwL5AuihwognfaKTzy0C0)

## Why did I do this?

### Why use Latex?

I switched to Latex from Microsoft Word for various reasons.
* It's more difficult for versioning with Microsoft Word.
    * This makes comparing different versions more difficult
* The pdf rendering is "finicky"
    * With a previous assignment that involved pictures, the pdf photos were not successfully rendered but there was no signal of that.
* I use Linux distros and running a VM everytime I want to edit my resume takes more time
* Since I'm a Ph.D. student, Latex is still heavily relevant in my area

### Why use GitHub Actions?

* I want to make sure my documents can be rendered despite the computer I use

This stems from the Software Engineer sentiment I'm familiar with.
One of the ideals that I have come across is an independently built and tested project so it has more confidence.
Ideally it'll run a custom build and deploy to whatever server after successfully running all the tests.
This avoids the problem "this worked on my machine".

## How did I do this? 

### Latex Templates

There have been a lot of source information I've used for this project.
The idea is not fully novel (building a resume with json or building a resume over GitHub).

> References
* Resume
    * Structure (class/awesome-cv.cls): [Awesome-CV](https://github.com/posquit0/Awesome-CV)
    * Structure (class/fontawesome.sty): Copyright 2015-2016 Claud D. Park
    * Structure (class/yaac-another-awesome-cv.cls): Copyright 2016 Christophe Roger
    * Style (fonts/FontAwesome.ttf): FontAwesome
    * Style (fonts/Roboto-*): Roboto
    * Style (fonts/SourceSansPro-*): SourceSansPro

### How does GitHub Actions run?

* Checking out the latest branch
    * Get the latest code
* step: Set up Python
    * Install Python
* step: Install dependencies
    * Install dependencies (python and linux based)
* step: Decode secret
    * Decode the json file secret that is hosted on GitHub Secrets
* step: Build the resume
    * running the "make resume" command
* step: Build the cv
    * running the "make cv" command
* step: Build the website
    * running the "make website" command
* step: Zip the Website files
    * Archives the website for the Website Repo to download
* step: Get Time
    * Determines the current timestamp
        * *NOTE*: There is a known-timezone issue in the library
* step: Read value from Properties-file
    * Retrieves the version string
* step: Echo the current version into the version.txt file
    * This step is mostly seen as out of sync and not needed
* step: Display Current Version
    * Echos the current version
* step: Create Release
    * Creates a release with the tag name {Version}{Timestamp}
* step: Upload Resume to the Release
    * Uploads the Resume to the latest release
* step: Upload CV to the Release
    * Uploads the CV to the latest release
* step: Upload Website Data to the Release
    * Uploads the Website Data to the latest release
* step: Upload Version.txt to the Release
    * Uploads the Version.txt to the latest release
* step: Repository Dispatch
    * Tells the Website repo to build via GitHub Actions

## What makes it special?

I've created a Makefile that has greatly simplified the latex build process.
* *Including the python json injection*

I have tried using tectronic since it seems promising, however it does not seem to support lualatex.