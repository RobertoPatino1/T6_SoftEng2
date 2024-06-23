# T6_SoftEng2_Front

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
### Back-End considerations
- The project is configured to run locally on *localhost* at port *3001*
- The deployed version of the backend can be found [here](https://shareyourroute-back.onrender.com/).
- The real time database can be found [here](https://share-your-route-ff4ad-default-rtdb.firebaseio.com).
- The application credentials can only be obtained via the sysadmin.


