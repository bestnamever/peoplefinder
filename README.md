# read here

You will find this project built in the framework of Flutter which is using Dart as programming language. Using the latest version of flutter and IDE is VS code. You have to set the environment first.

Tutorial here https://flutter.dev/docs

This is working on Android, but the framework is crossing platform, so if you are using Mac as your device, it’s also possible to run on IOS.

Please go through the whole folder and get some idea about what each file’s functions is. Basically, it’s doing the work literally as file’s name.

For now, I am using Google Firebase as database. I would suggest creating a collection of Firebase of your own to administer the database if you would to do some tests on this version.
Of course, you can run on my Firebase, please contact me to give your authority if you want so.

There are three parts to be improved: 
1.	Make API working. If you view the website of Fontys API, they would suggest you use implicit mode. BUT it’s not recommended by official website for some security reasons. They suggestion to use the authorization code flow with the PKCE extension instead.
Read here https://oauth.net/2/grant-types/implicit/
You can import the package of Oauth2 here https://pub.dev/packages/oauth2

2.	Migrate database to Microsoft 365. So instead of using Firebase, the database should be the same with Microsoft 365, then you would be able to use the Fontys account system.

3.	Update the algorithm. Once you access the API and building, you can do some tests to get the relationship of coordinates and the real location.
You can test the API by the function here https://api.fhict.nl/swagger/ui/index

Contact me if you get any questions! 
Cheers!

