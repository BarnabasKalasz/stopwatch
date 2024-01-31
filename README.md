## Stopwatch app

Creating this app was a test first and foremost, but also a gigantic learning opportunity.
I tried to take advantage of that and made this app without using any outside packages or libraries other than what flutter provides (even though the test allowed the use of using a premade analog clock).

It is a fairly simple stopwatch, but it can do what any other stopwatch should be capable of doing. Keeping track of time, resetting itself and saving lap-times.

The analog clock widget is customizable to a fairly high extent. Design wise the colors are coordinated using the theme of the applications. The number of clockhands/arms are completely dynamic, as well as how fast each individual are capable of mnaking a full revolution. To keep up with the arm speeds customizability , the numbers on the clock are also custom and can be controlled by the range you provide. This made it easy to add 2 separate analog clocks to my app, one with a range of 60 for the standard stopwatch and one with 12, like any normal clock would have.

![Alt text](<assets/images/Screenshot 2024-01-31 184847.png>)

![Alt text](<assets/images/Screenshot 2024-01-31 184822.png>)

![Alt text](assets/images/stopwatch_1.png)

![Alt text](<assets/images/Screenshot 2024-01-31 184916.png>)

![Alt text](<assets/images/Screenshot 2024-01-31 184946.png>)