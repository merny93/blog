---
layout: post
title:  "Hacking a Typewriter"
date:   "2023-02-11"
gallery_url: "https://photos.app.goo.gl/7uNdqAZitZZMHVu97"
cover_photo_number: 7
---

Ever wondered what the world would have looked like if large language models were invented before we invented monitors? Probably not but talking to chatGPT on a typewriter is cool regardless. A few weekends ago, Raffi and I hooked up a chatGPT backend to a hacked vintage typewriter: here is a quick demo video!
<!--more-->
<iframe width="100%" height="400px" src="https://www.youtube.com/embed/Ow0xPYktSg0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

Getting to this point was a bit of a mission so lets go back to the start of the pandemic when I bought my first typewriter from the Quebec version of Craigslist as my first dumb Covid purchase. I had the idea to turn a typewriter into a printer and instead of doing any research I just went online and bought the first one which was within driving distance. It was advertised as "working 2 years ago, but lost power cable since. Sold as is". My first reaction was _power cable_???

Turns out typewriters come in three flavours:
* Mechanical: What most people think when they picture a typewriter. All the force required to stamp a letter on the page comes from the finger hitting the key.
* Electrical: Contain usually a single electric motor and a system of mechanical clutches and linkages which greatly reduce the actuation force of the keys.
* Electronic: No mechanical linkage between the keys and the [type](https://en.wikipedia.org/wiki/Sort_(typesetting)). A micro-controller interfaces a keyboard of switches to some mechanical printing element.

I had bought an electric typewriter which, would have been cool in the 40s, but was still way too mechanical to automate easily. Between its mechanical complexity and the handful of issues that were not advertised in the posting, it took me over a year to admit defeat and look elsewhere to achieve my goal.

 
|![electirc typewriter]({{page.image_urls[0]}})|![electronic typewriter]({{page.image_urls[1]}})|
| Sears Celebrity electric typewriter I bought originally | Brother AX-25 electronic typewriter pictured with raspberry pi power cord and ethernet cord |

Enter the daisy-wheel typewriter: Brother AX-25, a fully electronic typewriter. This typewriter uses 3 stepper motors to move the carriage, advance the page, and rotate the typeface [_daisy-wheel_](https://en.wikipedia.org/wiki/Daisy_wheel_printing). Since all printing is done via stepper motor, the brains of the operation is a PIC micro-controller which collects user input through a dome-switch keyboard. Having looked around the internet, I found that some people had managed to hack this style of typewriter to use it as an output device and others got it working as an input device. With some confidence that I could make this work I bought the typewriter which luckily arrived in "working condition".

I quickly took the thing apart and soldered parallel connections to the 17 wires (+1 ground) connecting the main PCB with the keyboard. Un-surprisingly the keyboard switches are multiplexed by the main board into 9 _rows_ and 8 _columns_ where the main micro-controller polls one row at a time and reads out the 8 columns on each polling cycle. The polling pulse is an entire 1ms: fast by ~~non-gamer~~ human standards but painfully slow by computer standards. This made me think that I can read input and write output to the typewriter without having to program an embedded system.

|![typewriter circuit]({{page.image_urls[2]}})|
|Brain-board of the AX-25. The two ribbon cables at the bottom connect to the keyboard|

A quick search of google shows that when running a ring oscillator on a raspberry-pi, one can achieve frequencies [above 1MHz](https://pub.pages.cba.mit.edu/ring/). The typewriter operates at only 1KHz which gives me a factor of 1000 margin. Even running python code might just be fast enough... 

I started my timing tests with a python script that would pull an output pin down when it detected a polling input. This resulted in a mean latency of 0.2ms but would occasionally be late by anything from 0.5ms to missing the pulse outright. The problem is that linux is not a real-time OS and therefore there is no promise that your process will not be set aside to let some other process finish up what it was doing. Playing with the [_niceness_](https://en.wikipedia.org/wiki/Nice_(Unix)) did not yield acceptable results either.

|![timming_diagram]({{page.image_urls[3]}})|
| Timing diagram with python script. Input pulse starts at -1ms. About 1 minute integration time |

To get near real-time performance out of linux you have to use a much more primitive programming language like _C_ and adjust the job scheduler to always give you priority. The article [Almost Realtime Linux](https://www.iot-programmer.com/index.php/books/22-raspberry-pi-and-the-iot-in-c/chapters-raspberry-pi-and-the-iot-in-c/33-raspberry-pi-iot-in-c-almost-realtime-linux) was my main resource for this and it worked great!

Switching to _C_ and adjusting the scheduler to keep my thread on highest priority resulted in less than 0.1ms latency with no glitches or missed pulses at all! Finally wrapping the whole thing in python means that I get to avoid the ~~annoyances~~ quirks of _C_ when connecting it to some web backend like chatGPT. At this point I had effectively re-invented the teletype, and it was ready to do some fun stuff!

|![asci_cow]({{page.image_urls[4]}})|![asci_fox]({{page.image_urls[5]}})|
| Demo of the default cowsay ubuntu utility | cowsay with --fox switch | 

Getting the embedded-_like_ code to work took a few weeks but I was hoping to get it working by the time Raffi came to visit me. The original idea was to turn the thing into an email server because I had enjoyed typing letters on the typewriter in the past but found the whole mailing delay annoying. Connecting it to email would let me send and receive type-written letters but with much less delay. However, leading up to this weekend Alev suggested that we connect the typewriter to chatGPT to be able to have full conversations with a computer all on a piece of paper.

In comparison to getting to this point, this turned out to be really easy! We used the [unofficial API](https://github.com/acheong08/ChatGPT) since when we integrated this openAI had yet to release the official thing. 

The final touches were to append "answer in 30 words or less" to all prompts and we were off to the races (turns out chatGPT is really chatty and typewriter ribbons are not infinite). 

|![asci_panther]({{page.image_urls[6]}})|![poetry]({{page.image_urls[7]}})|
| ASCII art from the internet | Some poetry demo with chatGPT|

The project has since been put on the back-burner for now. I might get the motivation to connect it to an email server eventually but that might require me to re-write a portion of the input code. The current setup is synchronous and thus the read operations happen in blocks (about 20ms per block). This usually works perfectly fine but if you are typing very fast (hitting two keys within a 20ms window) my code can get confused and miss one of the inputs. The fix here is to run a _C_ daemon and pipe output live to another thread which deals with the inputs. Although my love for _C_ makes me reluctant to change things up.

If anyone made it this far and is still reading, all the code is on [GitHub](https://github.com/merny93/typewriter).

<!-- The typewriter I had bought was an electrical one, and turns out it had way more problems than just the missing power cable. Within a day of buying the thing I replaced the Sears proprietary mains power receptacle with a standard [kettle cord](https://en.wikipedia.org/wiki/IEC_60320#C15/C16_coupler) one. To the sweet old ladies credit, the machine did turn on and even typed a couple characters at which point I noticed the key called _power return_ and of course had to press it! The carriage did as requested: advanced the paper one line spacing and then wound itself to the left margin, at which point the _power_ disengaged and the spring which advances the carriage one character at a time fully unwound slamming the carriage into the right margin in the process. -->

<!-- The mechanism which advances the carriage is based upon an [anchor escapement](https://en.wikipedia.org/wiki/Anchor_escapement) allowing the carriage to advance and retard a consistent spacing for each character. To implement power return (and repeated spacing) the anchor of the escapement is separated into two parts which are spring loaded to the nominal position. During the _power return_ the anchor disengages the escape wheel while a motor winds the carriage back, once the carriage reaches the end-stop it disengages the motor and re-engages the anchor. In my case, over the machines life, the spring which engages the anchor loosened and the join in the anchor stiffened resulting in slightly slower engagement time. The end result was that the escapement would unwind the entire way after the _power return_ motor disengaged. Indeed the fix was just to take apparat the escapement mechanism, wash and grease it, and replace the tired spring. -->

<!-- Other problems included a shift key which did nothing (caused by a missing linkage and fixed by making a linkage out of steel wire) and a broken backspace key (caused by a missing screw and bushing and fixed by machining a brass bushing and replacing the screw). -->

<!-- To automate the typewriter I had originally planned to add ~30 solenoids (one for each key) and actuate which ever one I needed! This turned out to not be realistic as even though the typewriter was electric, the force required to overcome the springs in the keys required a fairly large solenoid. Short of winding my own solenoids designed for very high voltage low duty cycle I decided to abandon that plan. The next plan was to actuate all the keys with a single solenoid mounted on a linear stage in a place where all inputs align together. This was certainly possible but it would still require some shenanigans to actuate special keys (like shift, space and others...) so I tabled that idea for some time. I really did not have it in me to work with microscopic linkages as everything in that typewriter was so compact. -->