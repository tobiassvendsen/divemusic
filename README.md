# divemusic
Code assignment as part of job interview

## approach
I started by creating a new flutter project to get the general setup. Then I created the bottomnavigationbar to support the two different pages of the app. I used the official flutter documentation to create the navigationbar since its quite helpful to have quick glance at the general syntax and concept.
Once that was working I wanted to look at audio playback since I had no previous experience with that. I then started out creating a UI with simple buttons to create and test each function of the audioplayers package (while looking at the documentation). Then I started tweaking each feature at a time i.e. playing a specific song which required me to show the songs and play them onTap. This lead to the songlist being built as well as the playSong method. This process was then repeated until each feature was roughly working as intended.
I then looked at the notes seciton. As a base I created the textfield to have the ability to write text. Then I attempted to create the saveNotes method and afterwards I created the loadNotes method which was pretty essential to testing. I then tweaked my functions until I reached the desired functionality.

I then went back to the audio player and fixed some issues with how the player and the controls interacted. I then added the feature to skip to next and previous song.

## homepage.dart
The homepage has the bottomnavigationbar and allows the app to change the pages within the body element of the scaffold. It was done by looking at the official flutter documentation for reference (mostly to remember the syntax).
 
## player.dart
I chose to represent the songs in a String list by just including each URL. I did this because looking at postman and sending a http request to the server returns a body with only the song itself. If there had been more data i.e. length of the song, name, artist and so on it would have been beneficial to create a song.dart class to model the songs and create a song list instead.

For playing the audio I chose the "audioplayers" package from pub.dev. I chose this package because of it's popularity which can be quite important for long term support of the package. If the app was dependent on a package that few people uses there could be a higher likelyhood that it won't get updated or supported in the future. I also looked at the documentation before making my decision to make sure that the package supported the required features of the app.

Possible features for the app's music player could be a timeline slider for getting to a specific part of the song or adding auto play to continue the playlist once a song is finished. Could also add support for shuffle play or searching for songs.

## notes.dart
I chose to use the shared_preferences package to save the notes onto the device. Here I also looked at the popularity of the package before choosing it. I have also worked with this package before in my own project.

I chose to implement the notes section of the app as I did because of the assignment description. You could improve the feature by adding an overview of the stored notes and adding a button for creating a new note. This would allow users to have seperate notes for each song instead of one by notepad for all their thoughts.