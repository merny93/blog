---
layout: post
title:  "Antarctica in Film"
date:   "2023-01-25"
gallery_url: "https://photos.app.goo.gl/8atZK6oSCLf4UKvP8"
cover_photo_number: 0
---

As most of my friends already know, I recently traveled to Antarctica for a few months to prepare and launch the Spider 2 instrument.
<!--more-->
[![Spider on the pad]({{page.image_urls[0]}})]({{page.gallery_url}})

Spider 2 is a CMB polarimeter which flies on a stratospheric weather balloon at about 30km above the ground. It is designed to fly for around 30 days during which it scans a small portion of the sky that is specially designed to be _boring_. For Spider to achieve it's science goals it needs to be able to see the earliest light in the universe and thus the patch of sky to be scanned is selected to avoid our own galaxy and any other bright sources (notably the sun). 

To measure the faint emission of the CMB, Spider has 6 individual telescopes which operate using Transition Edge Sensors (TES) on the focal planes. These TESs are effectively little bits of superconducting material which are carefully temperature controlled to stay right on the edge of superconductivity. This ballance is so delicate that even if a single photon lands on the TES it will deposit enough energy to knock it off the edge and the TES will noticeably heat up. TESs make for very sensitive detectors but they come with a lot of difficulties.

| [![inserts group photo]({{page.image_urls[1]}})]({{page.gallery_url}}) |
| Elle, Jared and Susan posing with the telescope inserts with Vy and Steven caught in the background |



To get TESs _on transition_ they need to be cooled down to near absolute zero. A ground based experiment might achieve this with a pulse-tube and dilution refrigerator combo but the mass and power constraints associated with balloon flights prohibit such a solution. Instead, Spider uses a 1000L bath of liquid helium to cool the system to a temperature of 4.2K and then a combination of a _pumped_ He4 and He3 system to cool the focal planes down to 0.3K 

| [![Loading inserts]({{page.image_urls[2]}})]({{page.gallery_url}})| [![vertical inserts]({{page.image_urls[3]}})]({{page.gallery_url}})|
| Corwin, Suren and Elle loading a telescope insert into the main cryostat| Jared, Elle and Sho posing with the inserts|

So why Antarctica? There are two main reasons: constant day and ease of recovery.

The balloons that are used to lift these large payloads are not sealed at the bottom. Since as the balloon rises the ambient pressure drops, the balloon inflates significantly between the time it is launched and when it reaches float. If the balloon was sealed it would be very easy to over-fill the balloon and have it pop at some point during ascent. To avoid this, the balloons are open at the bottom but this does not cause them to leak since the helium inside them stays at the top. However, if the balloon experienced day-night cycles it would heat during the day and cool at night which would intern rise and drop the internal pressure. With each such cycle it would _squeeze_ some helium out the bottom and thus every day the balloon would drop lower and lower. During the summer months, Antarctica experiences 24 hour sunlight, this makes the balloon stable and the solar panels that power the instrument efficient!

The second reason is that the instrument does not have enough bandwidth to downlink all observation data. To retrieve the data we have to physically grab hard-drives from the payload. There is also lots of high value equipment that can be reused. The wind patterns that set up over Antarctica usually keep stratospheric balloons over land and so, whenever it is time to terminate, we can be sure that the payload will not sink at sea.

I decided to bring my dad's old Soviet film camera, the Zenith from 1972 and take a hand-full of pictures. Most turned out ok so here is a stroll through them:

| [![Mount Erebus]({{page.image_urls[4]}})]({{page.gallery_url}})| [![bulldozer]({{page.image_urls[5]}})]({{page.gallery_url}})|
| Mount Erebus from Lond Duration Ballooning (LDB)| An ancient piece of equipment that I did not get to drive |
| [![church]({{page.image_urls[6]}})]({{page.gallery_url}}) | [![LDB town]({{page.image_urls[7]}})]({{page.gallery_url}})|
| The church in town | LDB after a small wind storm | 
| [![Scott's Hut]({{page.image_urls[8]}})]({{page.gallery_url}}) | [![pressure ridges]({{page.image_urls[9]}})]({{page.gallery_url}}) |
| Scott's hut from town | View of the pressure ridges on our way to work |

Assembling Spider to get it launch ready takes a long time and lots of patience. Antarctica also does not have Amazon Prime which means that anything that breaks needs to be fixed with whatever you have on hand. When we did have a day off, and the weather was co-operating, we would do outdoorsy activities. At the start of the season the sea ice was thick enough to let people ski on it: 

| [![skiing from far]({{page.image_urls[10]}})]({{page.gallery_url}}) | [![ski group]({{page.image_urls[11]}})]({{page.gallery_url}})|
| Susan, Elle, and Steven in front of McMurdo | Susan, Elle, and Steven up close |
| [![Susan and vy]({{page.image_urls[12]}})]({{page.gallery_url}}) | [![vy and bikes]({{page.image_urls[13]}})]({{page.gallery_url}})|
| Susan and Vy showing off the rented skis | Vy adding a splash of color to the backdrop |
| [![happy susan]({{page.image_urls[14]}})]({{page.gallery_url}}) | [![susan seal]({{page.image_urls[15]}})]({{page.gallery_url}})|
| Susan celebrating the end of the hike | Susan posing with the local wild-life|

At the end of December we were launch ready. We had about a week's worth of launch attempts before we finally sent Spider on it's way. Launching is heavily weather dependant and the weather would usually be best at 7am local time. To be ready to launch at 7am we would usually show up around midnight that morning. After a few hours of work to get everything ready, Spider would be taken out of the high-bay and would dangle majestically from the launch vehicle named "The Boss". At this point we would sit around launching pie-balls (the small red weather balloons) to asses the weather until it was either good enough to launch or at around 10am when we would call it for the day and try again tomorrow.

| [![spider outside]({{page.image_urls[16]}})]({{page.gallery_url}}) |  [![spider on the pad]({{page.image_urls[19]}})]({{page.gallery_url}})|
| Spider hanging out on the Boss | Spider sitting on the pad waiting for launch  |
| [![balloon in the air]({{page.image_urls[17]}})]({{page.gallery_url}}) |[![pi ball]({{page.image_urls[18]}})]({{page.gallery_url}})|
| Seconds before launch | Jared and Rose launching a weather balloon |


As always, most of the pictures I took were portraits!

{% for i in (10..19) -%}{%- assign j = i | times: 2 -%}{%- assign k = j | plus: 1 -%}
[![alt text]({{page.image_urls[j]}})]({{page.gallery_url}}) | [![more alt text]({{page.image_urls[k]}})]({{page.gallery_url}}) |
{% endfor -%}