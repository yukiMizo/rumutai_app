const functions = require("firebase-functions");

const admin = require('firebase-admin');
const { FieldValue } = require("@google-cloud/firestore");
admin.initializeApp();

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
//exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.dataToDataToRead = functions.firestore
    .document('gameData/{gameId}')
    .onUpdate((change, context) => {
        const newData = change.after.data();
        const oldData = change.before.data();
        var id = "none";
        class1 = newData["team"]["0"];
        class2 = newData["team"]["1"];
        oldClass1 = oldData["team"]["0"];
        oldClass2 = oldData["team"]["1"];
        const gameId = newData["gameId"];
        const gameKey = gameId[3];
        const classGameKey = gameId[1];
        if (gameId[0] == "1") {
            if (gameId[1] == "b") {
                id = "1b";
            }
            else if (gameId[1] == "g") {
                id = "1g";
            }
            else if (gameId[1] == "m") {
                id = "1m";
            }
        } else if (gameId[0] == "2") {

            if (gameId[1] == "b") {
                id = "2b";
            }
            else if (gameId[1] == "g") {
                id = "2g";
            }
            else if (gameId[1] == "m") {
                id = "2m";
            }
        }

        if (class1 == "110a" || class1 == "110b") {
            class1 = "110";
        } else if (class1 == "209a" || class1 == "209b") {
            class1 = "209";
        }
        if (class2 == "110a" || class2 == "110b") {
            class2 = "110";
        } else if (class2 == "209a" || class2 == "209b") {
            class2 = "209";
        }
        if (oldClass1 == "110a" || oldClass1 == "110b") {
            oldClass1 = "110";
        } else if (oldClass1 == "209a" || oldClass1 == "209b") {
            oldClass1 = "209";
        }
        if (oldClass2 == "110a" || oldClass2 == "110b") {
            oldClass2 = "110";
        } else if (oldClass2 == "209a" || oldClass2 == "209b") {
            oldClass2 = "209";
        }

        try {
            admin
                .firestore()
                .collection("gameDataToRead")
                .doc(id)
                .set({ [gameKey]: { [gameId]: newData } }, { merge: true });


            if (class1 != oldClass1) {
                admin
                    .firestore()
                    .collection("classGameDataToRead")
                    .doc(oldClass1)
                    .set({ [classGameKey]: { [gameId]: FieldValue.delete() } }, { merge: true });
            }
            if (class2 != oldClass2) {
                admin
                    .firestore()
                    .collection("classGameDataToRead")
                    .doc(oldClass2)
                    .set({ [classGameKey]: { [gameId]: FieldValue.delete() } }, { merge: true });
            }


            admin
                .firestore()
                .collection("classGameDataToRead")
                .doc(class1)
                .set({ [classGameKey]: { [gameId]: newData } }, { merge: true });

            admin
                .firestore()
                .collection("classGameDataToRead")
                .doc(class2)
                .set({ [classGameKey]: { [gameId]: newData } }, { merge: true });

        } catch (error) {
            console.log(JSON.stringify(error));
        }
        return 0;
    });

exports.sendNotification = functions.firestore
    .document('notification/{docId}')
    .onCreate((snap, context) => {
        const newValue = snap.data();
        admin.messaging().sendToTopic("notification", {
            notification: {
                title: newValue["title"],
                body: newValue["content"],
            }
        });

        return 0;
    });

exports.setOmikujiDataToRead = functions.firestore
    .document('omikujiData/{docId}')
    .onCreate(async (snap, context) => {
        const newValue = snap.data();
        const omikujiId = snap.id;

        var upload = true;

        await admin
            .firestore()
            .collection("omikujiData").where('oneWord', '==', newValue["oneWord"]).get().then(snapshot => {
                snapshot.forEach(doc => {
                    if (doc.id != omikujiId) {
                        admin
                            .firestore()
                            .collection("omikujiData").doc(doc.id).delete();
                        upload = false;
                    }
                })
            });


        if (upload == true) {
            admin
                .firestore()
                .collection("omikujiDataToRead")
                .doc("omikujiDataToReadDoc")
                .set({ [omikujiId]: newValue }, { merge: true });
        }

        return 0;
    });