# T6_SoftEng2

## How to run the project (front-end)
**1. Clone the repository**
```
git clone https://github.com/RobertoPatino1/T6_SoftEng2.git
```
**2. Move to project directory**
```
cd T6_SoftEng2/share_your_route_front/
```

**3. Install dependencies**
```
flutter pub get
```

**4. Create .env config file**
```
mkdir lib/core/configs
touch lib/core/configs/.env
```

**5. Place your Mapbox access token inside the .env file**
```
MAPBOX_ACCESS_TOKEN = <TOKEN>
```
If you don't have an access token make sure to check the following [link](https://docs.mapbox.com/help/getting-started/access-tokens/)

**6. Run the project**
```
flutter run -t lib/main/main.dart
```
### How to build the APK
**In the root directory run the following command**
```
flutter build apk -t lib/main/main.dart --split-per-abi
```

## How to run the project (back-end)
The backend repository can be found [here](https://github.com/RobertoPatino1/T6_SoftEng2_Back).

**Clone the repository**
```
git clone https://github.com/RobertoPatino1/T6_SoftEng2_Back.git
```

**Install dependencies**
```
cd T6_SoftEng2_Back
npm i
```

**Start the server**
```
node index.js
```

**Add the secret key**
```
mkdir .firebase
mv <secret_key>.json .firebase/
```

**Create .env file at the project root**
```
touch .env
```
**Inside the .env file paste the following lines**
```
PORT = 4001
APPLICATION_CREDENTIALS=../.firebase/serviceAccountKey.json
FIREBASE_DATABASE_URL=https://share-your-route-ff4ad-default-rtdb.firebaseio.com
```

### Build configuration files for firebase
**Install Firebase CLI**
Check this [link](https://firebase.google.com/docs/cli#mac-linux-npm) for more detailed steps.
**Note:** _You need to have curl isntalled in your system_
```
curl -sL https://firebase.tools | bash
```

**Log in and test the Firebase CLI**

_After running this command you'll need to follow the link showed in the terminal and accept the required permissions._
```
firebase login
```

**Install the FlutterFire CLI**
```
dart pub global activate flutterfire_cli
```
**Configure the project to use Firebase**
**Note:** _Make sure this command is being executed on the root of the project_
```
flutterfire configure
```
### Back-End considerations
- The project is configured to run locally on *localhost* at port *3001*
- The deployed version of the backend can be found [here](https://shareyourroute-back.onrender.com/).
- The real time database can be found [here](https://share-your-route-ff4ad-default-rtdb.firebaseio.com).
- The application credentials can only be obtained via the sysadmin.

## Frameworks/Tools used during the project development
### Front-End
- [Flutter](https://flutter.dev/): Front-End framework used to develop the mobile application.
- [Dart](https://dart.dev/): Default programming language used by Flutter.
  
### Back-End
- [Express.js](https://expressjs.com/): Back-End framework used to create the API and set up the endpoints.
- [Firebase](https://firebase.google.com/): Real-Time database used to store relevant data regarding the project like users, routes and coordinates.
- [JavaScript](https://developer.mozilla.org/es/docs/Web/JavaScript): Default programming language used by Express.js.
- [Render](https://render.com/): Deployment service used to deploy the back-end.

## Additional documentation
- [Coding Standard Documentation](https://github.com/RobertoPatino1/T6_SoftEng2/blob/main/Resources/coding_standard_documentation.md)
