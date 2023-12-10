/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */


// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

import { auth, https } from "firebase-functions";
import admin from "firebase-admin";

admin.initializeApp();
const firestore = admin.firestore();
const settings = { timestampsInScreenshots: true };
firestore.settings(settings);

export const addAdminRole = https.onCall(async (data) => {
    try {
        const user = await admin.auth().getUserByEmail(data.email);
        await admin.auth().setCustomUserClaims(user.uid, {
            accountType: 'admin',
            schoolId: data.schoolId,
        });
        console.log(`Set ${data.email} as an admin`);
        return true;
    } catch (err) {
        console.log(err);
        return false;
    }
});

export const addTeacherRole = https.onCall(async (data) => {
    try {
        const user = await admin.auth().getUserByEmail(data.email);
        await admin.auth().setCustomUserClaims(user.uid, {
            accountType: 'teacher',
            schoolId: data.schoolId,
        });
        return {
            message: `Set ${data.email} as teacher in school ID ${data.schoolId}`,
        };
    } catch (err) {
        return err;
    }
});

// export const signUpAdmin = https.onCall((data, context) => {
//     admin.auth().createUser({
//         email: data.email,
//         password: data.password
//     })
//         .then(async (userRecord) => {
//             console.log(`Successfully created new user: ${userRecord.email}`);

//             await addAdminRole({
//                 email: userRecord.email,
//                 schoolId: userRecord.uid
//             });

//             await firestore.collection('schools').doc(userRecord.uid).set({
//                 name: data.schoolName,
//                 officeName: data.officeName,
//             });
//             console.log(`Successfully created school record for ${userRecord.email}`);
//         })
//         .catch((error) => {
//             console.log(`Error creating new user: ${error}`);

//             return {
//                 message: error
//             };
//         });
// });

export const signInTeacher = https.onCall((data, context) => {
    admin.auth().getUserByEmail(data.email).then(async user => {
        
    })
});

export const signUpTeacher = https.onCall((data, context) => {
    admin.auth().createUser({
        email: data.email,
        password: data.password
    })
        .then(async (userRecord) => {
            console.log(`Successfully created new user: ${userRecord.email}`);

            await addTeacherRole({
                email: userRecord.email,
                schoolId: data.schoolId
            });
            console.log(`Successfully set user ${userRecord.email} as teacher`);

            // await firestore.collection('schools').doc(data.schoolId).collection('teachers').doc(userRecord.uid).set({
                
            // });
            // console.log(`Successfully created teacher record for ${userRecord.email}`);
        })
        .catch((error) => {
            console.log(`Error creating new user: ${error}`);

            return {
                message: error
            };
        });
});