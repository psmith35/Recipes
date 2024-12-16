### Steps to Run the App
1. Let the app load the list of recipes.
2. Scroll through the app and select a recipe to either open a website or video (depending on which is available).
3. Press the Reload button to reload the list.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I prioritized data fetching and architecture during this project. These areas were crucial to ensuring the project is scalable and accurate. 
I believe scalability and accuracy are important because they reduce worktime and user dissatisfaction.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I worked on this project when I had time available. In total, I probably spent about 5-6 hours on this project. This included all phases, from initial planning to final revisions.  
I spent the first hour researching the project and planning out how I wanted the data and UI to be designed and setup. I then dedicated ~4 hours to actually working on coding the 
core tasks of the project such as data fetching and UI loading. Finally, I spent 1 hour refining my work and checking for errors.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
Since this was expected to be a quick project, I made the trade-off of creating something simple vs. feature-heavy. I could've added more functionality or better UI, but I think
this project achieves its mission.

### Weakest Part of the Project: What do you think is the weakest part of your project?
I believe the weakest part of my project is the unit testing. Testing is very important to ensuring an app is efficient and accurate. 
The requirements didn't seem to focus too much on testing, so I didn't include too much.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
- An error popup appears if malformed recipe data gets loaded or some other error occurs during loading.
- There is also a message if the recipe list that gets loaded is empty.
- The app checks for a video link first for each recipe, and if that isn't available, it then checks for a website link. No link gets included if neither is available.
