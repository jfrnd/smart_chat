import * as admin from "firebase-admin";

export interface User extends admin.firestore.DocumentData {
    activeAt: FirebaseFirestore.Timestamp
    createdAt: FirebaseFirestore.Timestamp
    email: string
    imageUrl: string
    languageCode: string
    timeZoneOffset: number
    token: string
    updatedAt: FirebaseFirestore.Timestamp
    userName: string
}